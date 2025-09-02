//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	@State private var contributions = [Contribution]()
	
    var body: some View {
		List(contributions, id: \.id) { contribution in
			Text("\(contribution.date) - \(contribution.contributionsCount)")
		}
		.task {
			let leetCodeContributions = LeetCodeContributionsProvider()
			let result = await leetCodeContributions.getContributions(for: "yatoenough")
			
			switch result {
			case .success(let leetCodeContributions):
				contributions = leetCodeContributions
			case .failure(let error):
				print("Error fetching contribuions: \(error)")
			}
	
		}
    }
}

#Preview {
    ContentView()
}
