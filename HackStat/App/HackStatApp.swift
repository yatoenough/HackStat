//
//  HackStatApp.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

@main
struct HackStatApp: App {
	let submissionsViewModel: SubmissionsViewModel
	let settingsViewModel: SettingsViewModel
	
	init() {
		let providers: [SubmissionsProvider] = [
		   GitLabSubmissionsProvider(),
		   GitHubSubmissionsProvider(),
		   LeetCodeSubmissionsProvider(),
		   CodeWarsSubmissionsProvider()
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
