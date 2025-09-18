//
//  RootView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct RootView: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	@Environment(SettingsViewModel.self) private var settingsViewModel
	
    var body: some View {
		TabView {
			SubmissionsScreen()
				.tabItem {
					Label("Submissions", systemImage: "arrow.up.arrow.down")
				}
			
			SettingsScreen()
				.tabItem {
					Label("Settings", systemImage: "gear")
				}
		}
		.task {
			await fetchSubmissions()
		}
    }
	
	private func fetchSubmissions() async {
		let usernames = settingsViewModel.resolveUsernames()
		await submissionsViewModel.fetchSubmissions(for: usernames)
	}
}

#Preview {
    RootView()
		.environment(SubmissionsViewModel.previewInstance)
		.environment(SettingsViewModel())
}
