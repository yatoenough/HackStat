//
//  GitLabSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 03/09/2025.
//

import Foundation

struct GitLabSubmissionsProvider: SubmissionsProvider {
	let platformType: PlatformType = .gitlab
	func getSubmissions(for username: String) async -> Result<[Submission], any Error> {
		let url = URL(string: "\(Strings.gitLabApiURL)/users/\(username)/calendar.json")!
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let calendarResponse = try JSONDecoder().decode([String: Int].self, from: data)
			
			var submissions = [Submission]()
			
			for (date, count) in calendarResponse {
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				
				let submissionDate = dateFormatter.date(from: date)!
				submissions.append(Submission(date: submissionDate, submissionsCount: count))
			}
			return .success(submissions)
		} catch {
			return .failure(error)
		}
	}
}
