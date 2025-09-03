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
	
	private let providers: [SubmissionsProvider] = [
		LeetCodeSubmissionsProvider(),
		GitHubSubmissionsProvider()
	]
	
	
	init() {
		Task {
			await fetchSubmissions()
		}
	}
	
	func fetchSubmissions() async {
		await withTaskGroup(of: [Submission].self) { group in
			var results = [Submission]()

			for provider in providers {
				group.addTask {
					let result = await provider.getSubmissions(for: "yatoenough")
					
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
			
			submissions = results
		}
	}
}
