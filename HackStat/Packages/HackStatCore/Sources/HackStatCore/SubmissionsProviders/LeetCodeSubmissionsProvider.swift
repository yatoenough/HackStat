//
//  LeetCodeSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation
import HackStatModels
import HackStatNetworkUtils

private struct LeetCodeResponse: Decodable {
	struct DataResponse: Decodable {
		struct MatchedUser: Decodable {
			let submissionCalendar: String
		}
		let matchedUser: MatchedUser
	}
	let data: DataResponse
}

public struct LeetCodeSubmissionsProvider: SubmissionsProvider {
	public let platformType: PlatformType = .leetcode
	
	private let leetCodeApiURL: String
	private let leetCodeGraphQLQuery: String
	
	public init(leetCodeApiURL: String, leetCodeGraphQLQuery: String) {
		self.leetCodeApiURL = leetCodeApiURL
		self.leetCodeGraphQLQuery = leetCodeGraphQLQuery
	}
	
	public func getSubmissions(for username: String) async -> Result<[Submission], Error> {
		let url = URL(string: leetCodeApiURL)!

		let graphQLRequest = GraphQLRequest(
			url: url,
			query: leetCodeGraphQLQuery,
			variables: ["username": username]
		)

		do {
			let (data, _) = try await URLSession.shared.data(for: graphQLRequest.request)
			let decodedResponse = try JSONDecoder().decode(LeetCodeResponse.self, from: data)
			let submissionCalendar = decodedResponse.data.matchedUser.submissionCalendar

			guard let submissionData = submissionCalendar.data(using: .utf8) else {
				struct CorruptedDataError: Error {}
				return .failure(CorruptedDataError())
			}

			let submissions = try JSONDecoder().decode([String: Int].self, from: submissionData)

			let parsedSubmissions = submissions.compactMap { (key, value) -> Submission? in
				guard let timeInterval = TimeInterval(key) else {
					return nil
				}
				
				let date = Date(timeIntervalSince1970: timeInterval)
				return Submission(date: date, submissionsCount: value)
			}

			return .success(parsedSubmissions)
		} catch {
			return .failure(error)
		}
	}

}
