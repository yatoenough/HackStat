//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	@State private var submissionsViewModel = SubmissionsViewModel()

	var body: some View {
		List(submissionsViewModel.submissions, id: \.id) { submission in
			Text("\(submission.date) - \(submission.submissionsCount)")
		}
		.task {
			await submissionsViewModel.fetchSubmissions(for: "yatoenough")
		}
	}
}

#Preview {
	ContentView()
}
