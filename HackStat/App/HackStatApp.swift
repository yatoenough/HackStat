//
//  HackStatApp.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import HackStatCore
import SwiftUI

@main
struct HackStatApp: App {
	let submissionsViewModel: SubmissionsViewModel
	let settingsViewModel: SettingsViewModel

	init() {
		let providers: [SubmissionsProvider] = [
			GitLabSubmissionsProvider(gitLabApiURL: Strings.gitLabApiURL),
			GitHubSubmissionsProvider(
				gitHubApiURL: Strings.gitHubApiURL,
				gitHubGraphQLQuery: Strings.gitHubGraphQLQuery,
				gitHubApiToken: Credentials.gitHubApiToken
			),
			LeetCodeSubmissionsProvider(
				leetCodeApiURL: Strings.leetCodeApiURL,
				leetCodeGraphQLQuery: Strings.leetCodeGraphQLQuery
			),
			CodeWarsSubmissionsProvider(codeWarsApiURL: Strings.codeWarsApiURL),
		]

		submissionsViewModel = SubmissionsViewModel(providers: providers)
		settingsViewModel = SettingsViewModel()
	}

	var body: some Scene {
		WindowGroup {
			RootView()
				.environment(submissionsViewModel)
				.environment(settingsViewModel)
		}
	}
}
