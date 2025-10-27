//
//  SettingsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI
import HackStatCore

struct SettingsScreen: View {
	@Environment(SettingsViewModel.self) private var settingsViewModel

    var body: some View {
		@Bindable var settingsViewModel = settingsViewModel

		NavigationStack {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {
					VStack(alignment: .leading, spacing: 8) {
						GradientText(text: "Settings")

						Text("Customize your experience")
							.font(.system(size: 14))
							.foregroundColor(.gray)
					}
					.padding(.horizontal)
					.padding(.top, 10)

					VStack(alignment: .leading, spacing: 20) {
						GeneralSettingsSection(settingsViewModel: $settingsViewModel)

						PlatformUsernamesSection(settingsViewModel: $settingsViewModel)
					}
					.padding(.horizontal)
					.padding(.top, 24)
					.padding(.bottom, 20)
				}
			}
			.scrollDismissesKeyboard(.immediately)
			.textInputAutocapitalization(.never)
			.animation(.easeInOut, value: settingsViewModel.useSameUsername)
		}
    }
}

#Preview {
	SettingsScreen()
		.environment(SettingsViewModel())
}
