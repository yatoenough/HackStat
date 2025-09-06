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
						print("Error fetching submissions for \(type(of: provider)): \(error)")
						return []
					}
				}
			}

			for await result in group {
				results.append(contentsOf: result)
			}

			submissions = results.sorted(by: { $0.date > $1.date })
		}
	}

	func fetchSubmissions(for usernames: Usernames) async {
		await withTaskGroup(of: [Submission].self) { group in
			var results = [Submission]()

			for provider in providers {
				group.addTask {
					let username: String?
					
					switch provider {
					case is GitHubSubmissionsProvider:
						username = usernames.github
					case is GitLabSubmissionsProvider:
						username = usernames.gitlab
					case is CodeWarsSubmissionsProvider:
						username = usernames.codewars
					case is LeetCodeSubmissionsProvider:
						username = usernames.leetcode
					default:
						username = nil
					}

					guard let username, !username.isEmpty else {
						return []
					}

					let result = await provider.getSubmissions(for: username)

					switch result {
					case .success(let fetchedSubmissions):
						return fetchedSubmissions
					case .failure(let error):
						print(
							"Error fetching submissions for \(type(of: provider)): \(error)"
						)
						return []
					}
				}
			}

			for await result in group {
				results.append(contentsOf: result)
			}

			submissions = results.sorted(by: { $0.date > $1.date })
		}
	}

	#if DEBUG
		static let previewInstance: SubmissionsViewModel = {
			return SubmissionsViewModel(providers: [MockSubmissionsProvider()])
		}()
	#endif
}
