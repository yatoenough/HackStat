//
//  RootView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct RootView: View {
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
    }
}

#Preview {
    RootView()
		.environment(SubmissionsViewModel.previewInstance)
}
