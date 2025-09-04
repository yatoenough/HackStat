//
//  SubmissionsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 03/09/2025.
//

import Foundation

@Observable
class SubmissionsViewModel {
	private(set) var submissions = [Submission]()
	
	private let providers: [SubmissionsProvider]
	
	init(providers: [SubmissionsProvider]) {
		self.providers = providers
	}
	
	func fetchSubmissions(for username: String) async {
		await withTaskGroup(of: [Submission].self) { group in
			var results = [Submission]()

			for provider in providers {
				group.addTask {
					let result = await provider.getSubmissions(for: username)
					
					switch result {
					case .success(let fetchedSubmissions):
						return fetchedSubmissions
					case .failure(let error):
						print("Error fetching submissions: \(error)")
						return []
					}
				}
			}

			for await result in group {
				results.append(contentsOf: result)
			}
			
			submissions = results.sorted(by: { $0.date > $1.date})
		}
	}
	
	#if DEBUG
	static let mockInstance: SubmissionsViewModel = {
		let providers: [SubmissionsProvider] = [
			MockSubmissionsProvider()
		]
		
		return SubmissionsViewModel(providers: providers)
	}()
	#endif
}
