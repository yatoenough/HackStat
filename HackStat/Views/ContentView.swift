//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel

	var body: some View {
		SubmissionsGraph(submissions: submissionsViewModel.submissions)
			.task {
				await submissionsViewModel.fetchSubmissions(for: "yatoenough")
			}
	}
}

#Preview {
	ContentView()
		.environment(SubmissionsViewModel.previewInstance)
}
