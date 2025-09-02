//
//  LeetCodeContributionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct LeetCodeResponse: Decodable {
	var submissionCalendar: [Date: Int]
}

struct LeetCodeContributionsProvider: ContributionsProvider {
	func getContributions(for username: String) async -> Result<[Contribution], Error> {
		let url = URL(string: "https://alfa-leetcode-api.onrender.com/\(username)/calendar")!
		let (data, _) = try! await URLSession.shared.data(from: url)
		
		do {
			var contributions = [Contribution]()
			let response = try JSONDecoder().decode(LeetCodeResponse.self, from: data)
			
			for (date, count) in response.submissionCalendar {
				contributions.append(Contribution(date: date, contributionsCount: count))
			}
			
			return .success(contributions)
		} catch {
			return .failure(error)
		}
	}
	
}
