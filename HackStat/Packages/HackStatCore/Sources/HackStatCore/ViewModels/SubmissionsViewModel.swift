//
//  SubmissionsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 03/09/2025.
//

import Foundation
import HackStatModels
import HackStatNetworkUtils

@MainActor
@Observable
public class SubmissionsViewModel {
	private(set) public var submissions = [Submission]()
	private(set) public var loadingState = LoadingState.idle
	private(set) public var platformStates = PlatformLoadingState()

	private let providers: [SubmissionsProvider]

	public init(providers: [SubmissionsProvider]) {
		self.providers = providers
	}

	public func fetchSubmissions(for usernames: Usernames) async {
		loadingState = .loading

		for provider in providers {
			let username: String
			
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
			
			let status: PlatformStatus = (username.isEmpty != false) ? .skipped : .loading
			platformStates.setStatus(for: provider.platformType, status: status)
		}
		
		await withTaskGroup(of: (platform: PlatformType, submissions: [Submission], hasError: Bool).self) { group in
			var allResults = [Submission]()
			var hasAnyErrors = false
			
			for provider in providers {
				let username: String
				
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
				
				guard !username.isEmpty else {
					continue
				}
				
				group.addTask {
					let result = await provider.getSubmissions(for: username)

					switch result {
					case .success(let fetchedSubmissions):
						return (platform: provider.platformType, submissions: fetchedSubmissions, hasError: false)
					case .failure(let error):
						print("Error fetching submissions for \(provider.platformType): \(error)")
						return (platform: provider.platformType, submissions: [], hasError: true)
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

			submissions = allResults
				.filter(isSubmissionInLastYear)
				.sorted { $0.date > $1.date }
			
			loadingState = submissions.isEmpty && hasAnyErrors ? .error("Error fetching submissions") : .loaded
		}
	}
	
	private func isSubmissionInLastYear(_ submission: Submission) -> Bool {
		let calendar = Calendar.current
		guard let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: Date()) else { return false }
		
		return submission.date >= oneYearAgo
	}

	#if DEBUG
	public static let previewInstance: SubmissionsViewModel = {
			return SubmissionsViewModel(providers: [MockSubmissionsProvider()])
		}()
	#endif
}

