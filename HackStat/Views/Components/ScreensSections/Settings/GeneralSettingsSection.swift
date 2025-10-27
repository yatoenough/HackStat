//
//  GeneralSettingsSection.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore

struct GeneralSettingsSection: View {
    let settingsViewModel: Bindable<SettingsViewModel>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("GENERAL")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)

            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("First Weekday")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.primary)

                        Text("Choose how your week starts")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Picker("First weekday", selection: settingsViewModel.firstWeekday) {
                        Text("Sunday").tag(1)
                        Text("Monday").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(14)
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
        }
    }
}

#Preview {
	@Bindable var settingsViewModel = SettingsViewModel()
	
	GeneralSettingsSection(settingsViewModel: $settingsViewModel)
}
