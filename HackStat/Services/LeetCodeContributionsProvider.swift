//
//  LeetCodeContributionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct LeetCodeResponse: Decodable {
	var submissionCalendar: String
}

struct LeetCodeContributionsProvider: ContributionsProvider {
	func getContributions(for username: String) async -> Result<[Contribution], Error> {
		let url = URL(string: "http://localhost:3000/\(username)/calendar")!
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let response = try JSONDecoder().decode(LeetCodeResponse.self, from: data)
			
			guard let submissionData = response.submissionCalendar.data(using: .utf8) else {
				struct CorruptedDataError: Error {}
				return .failure(CorruptedDataError())
			}
			
			let submissions = try JSONDecoder().decode([String: Int].self, from: submissionData)
			
			let contributions = submissions.compactMap { (key, value) -> Contribution? in
				guard let timeInterval = TimeInterval(key) else {
					return nil
				}
				let date = Date(timeIntervalSince1970: timeInterval)
				return Contribution(date: date, contributionsCount: value)
			}
			
			return .success(contributions)
		} catch {
			return .failure(error)
		}
	}
	
}
