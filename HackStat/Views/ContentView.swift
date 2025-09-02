//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	private let contributionProviders: [ContributionsProvider] = [
		LeetCodeContributionsProvider()
	]
	
	@State private var contributions = [Contribution]()
	
    var body: some View {
		List(contributions, id: \.id) { contribution in
			Text("\(contribution.date) - \(contribution.contributionsCount)")
		}
		.task {
			contributions = await fetchContributions()
		}
    }
	
	func fetchContributions() async -> [Contribution] {
		return await withTaskGroup(of: [Contribution].self) { group in
			var results = [Contribution]()

			for provider in contributionProviders {
				group.addTask {
					let result = await provider.getContributions(for: "yatoenough")
					
					switch result {
					case .success(let fetchedContributions):
						return fetchedContributions
					case .failure(let error):
						print("Error fetching contributions: \(error)")
						return []
					}
				}
			}

			for await result in group {
				results.append(contentsOf: result)
			}
			
			return results
		}
	}
}

#Preview {
    ContentView()
}
