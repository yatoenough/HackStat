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
	
	init() {
		let providers: [SubmissionsProvider] = [
		   GitLabSubmissionsProvider(),
		   GitHubSubmissionsProvider(),
		   LeetCodeSubmissionsProvider(),
		   CodeWarsSubmissionsProvider()
	   ]
		
		submissionsViewModel = SubmissionsViewModel(providers: providers)
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(submissionsViewModel)
        }
    }
}
