//
//  CodeWarsSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 04/09/2025.
//

import Foundation
import HackStatModels

private struct CodeWarsResponse: Codable {
	let totalPages, totalItems: Int
	let data: [CodeWarsData]
}

private struct CodeWarsData: Codable {
	let id, name, slug: String
	let completedAt: Date
	let completedLanguages: [String]
}

public struct CodeWarsSubmissionsProvider: SubmissionsProvider {
	public let platformType: PlatformType = .codewars
	
	private let codeWarsApiURL: String
	
	public init(codeWarsApiURL: String) {
		self.codeWarsApiURL = codeWarsApiURL
	}
	
	public func getSubmissions(for username: String) async -> Result<[Submission], any Error> {
		var submissions: [Submission] = []
		var currentPage = 0
		var totalPages = 1

		do {
			while currentPage < totalPages {
				let url = buildURL(page: currentPage, username: username)
				let (data, _) = try await URLSession.shared.data(from: url)
				let decoder = JSONDecoder()

				decoder.dateDecodingStrategy = .iso8601

				let response = try decoder.decode(CodeWarsResponse.self, from: data)
				totalPages = response.totalPages

				let dateGrouped = Dictionary(grouping: response.data) { $0.completedAt }

				for (date, fetchedSubmissions) in dateGrouped {
					let newSubmission = Submission(
						date: date,
						submissionsCount: fetchedSubmissions.count,
					)

					submissions.append(newSubmission)
				}
				
				currentPage += 1
			}
			
			return .success(submissions)
		} catch {
			return .failure(error)
		}
	}
	
	private func buildURL(page: Int, username: String) -> URL {
		return URL(
			string:
				"\(codeWarsApiURL)/users/\(username)/code-challenges/completed?page=\(page)"
		)!
	}
}
