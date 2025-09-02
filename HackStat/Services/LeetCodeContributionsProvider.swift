//
//  LeetCodeContributionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct LeetCodeContributionsProvider: ContributionsProvider {
	private let graphQLQuery = """
		query getUserProfile($username: String!) {
			matchedUser(username: $username) {
				submissionCalendar
			}
		}
		"""
	
	private struct LeetCodeGraphQLResponse: Decodable {
		struct DataResponse: Decodable {
			struct MatchedUser: Decodable {
				let submissionCalendar: String
			}
			let matchedUser: MatchedUser
		}
		let data: DataResponse
	}

	func getContributions(for username: String) async -> Result<
		[Contribution], Error
	> {
		let url = URL(string: Strings.leetCodeApiURL)!

		let request = GraphQLRequestBuilder.build(
			url: url,
			query: graphQLQuery,
			variables: ["username": username]
		)

		do {
			let (data, _) = try await URLSession.shared.data(for: request)
			let decodedResponse = try JSONDecoder().decode(LeetCodeGraphQLResponse.self, from: data)
			let submissionCalendar = decodedResponse.data.matchedUser.submissionCalendar

			guard let submissionData = submissionCalendar.data(using: .utf8) else {
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
