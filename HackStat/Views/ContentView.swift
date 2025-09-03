//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	private let submissionsProviders: [SubmissionsProvider] = [
		LeetCodeSubmissionsProvider(),
		GitHubSubmissionsProvider()
	]
	
	@State private var submissions = [Submission]()
	
    var body: some View {
		List(submissions, id: \.id) { submission in
			Text("\(submission.date) - \(submission.submissionsCount)")
		}
		.task {
			submissions = await fetchSubmissions()
		}
    }
	
	func fetchSubmissions() async -> [Submission] {
		return await withTaskGroup(of: [Submission].self) { group in
			var results = [Submission]()

			for provider in submissionsProviders {
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
			
			return results
		}
	}
}

#Preview {
    ContentView()
}
