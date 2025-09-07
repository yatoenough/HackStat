//
//  SubmissionsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 03/09/2025.
//

import Foundation

@MainActor
@Observable
class SubmissionsViewModel {
	private(set) var submissions = [Submission]()
	private(set) var loadingState = LoadingState.idle
	private(set) var platformStates = PlatformLoadingState()

	private let providers: [SubmissionsProvider]

	init(providers: [SubmissionsProvider]) {
		self.providers = providers
	}

	func fetchSubmissions(for usernames: Usernames) async {
		loadingState = .loading

		for provider in providers {
			let username: String?
			switch provider.platformType {
			case .github:
				username = usernames.github
			case .gitlab:
				username = usernames.gitlab
			case .codewars:
				username = usernames.codewars
			case .leetcode:
				username = usernames.leetcode
			}
			
			let status: PlatformStatus = (username?.isEmpty != false) ? .skipped : .loading
			platformStates.setStatus(for: provider.platformType, status: status)
		}
		
		await withTaskGroup(of: (platform: PlatformType, submissions: [Submission], hasError: Bool).self) { group in
			var allResults = [Submission]()
			var hasAnyErrors = false

			for provider in providers {
				group.addTask {
					let username: String?
					
					switch await provider.platformType {
					case .github:
						username = usernames.github
					case .gitlab:
						username = usernames.gitlab
					case .codewars:
						username = usernames.codewars
					case .leetcode:
						username = usernames.leetcode
					}

					guard let username, !username.isEmpty else {
						return (platform: await provider.platformType, submissions: [], hasError: false)
					}

					let result = await provider.getSubmissions(for: username)

					switch result {
					case .success(let fetchedSubmissions):
						return (platform: await provider.platformType, submissions: fetchedSubmissions, hasError: false)
					case .failure(let error):
						print("Error fetching submissions for \(await provider.platformType): \(error)")
						return (platform: await provider.platformType, submissions: [], hasError: true)
					}
				}
			}

			for await result in group {
				allResults.append(contentsOf: result.submissions)
				
				let currentStatus = platformStates.getStatus(for: result.platform)
				let finalStatus: PlatformStatus
				
				switch currentStatus {
				case .skipped:
					finalStatus = .skipped
				default:
					finalStatus = result.hasError ? .failed : .success
				}
				
				platformStates.setStatus(for: result.platform, status: finalStatus)
				
				if result.hasError {
					hasAnyErrors = true
				}
			}

			submissions = allResults.sorted(by: { $0.date > $1.date })
			loadingState = submissions.isEmpty && hasAnyErrors ? .error("Error fetching submissions") : .loaded
		}
	}

	#if DEBUG
		static let previewInstance: SubmissionsViewModel = {
			return SubmissionsViewModel(providers: [MockSubmissionsProvider()])
		}()
	#endif
}
