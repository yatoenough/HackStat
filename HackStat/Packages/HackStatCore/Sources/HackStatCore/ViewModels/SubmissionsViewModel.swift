//
//  SubmissionsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 03/09/2025.
//

import Foundation
import HackStatModels

@MainActor
@Observable
public class SubmissionsViewModel {
	private(set) public var submissions = [Submission]()

	public var currentStreak: Int {
		var streak = 0
		let calendar = Calendar.current
		var currentDate = Date()

		for submission in submissions {
			let daysBetween = calendar.dateComponents([.day], from: submission.date, to: currentDate).day ?? 0
			if daysBetween == streak {
				streak += 1
				currentDate = submission.date
			} else {
				break
			}
		}

		return streak
	}

	private let providers: [SubmissionsProvider]

	public init(providers: [SubmissionsProvider]) {
		self.providers = providers
	}

	public func fetchSubmissions(for usernames: Usernames) async {
		await withTaskGroup(of: (platform: PlatformType, submissions: [Submission], hasError: Bool).self) { group in
			var allResults = [Submission]()

			for provider in providers {
				let username = getUsername(for: provider.platformType, from: usernames)

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
			}

			submissions = allResults
				.filter(isSubmissionInLastYear)
				.sorted { $0.date > $1.date }
			
		}
	}

	private func getUsername(for platformType: PlatformType, from usernames: Usernames) -> String {
		switch platformType {
		case .github:
			return usernames.github
		case .gitlab:
			return usernames.gitlab
		case .codewars:
			return usernames.codewars
		case .leetcode:
			return usernames.leetcode
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

