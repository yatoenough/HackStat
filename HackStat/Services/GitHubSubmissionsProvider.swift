//
//  GitHubSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 03/09/2025.
//

import Foundation

private struct GitHubResponse: Decodable {
	struct Week: Decodable {
		struct ContributionDay: Decodable {
			let contributionCount: Int
			let date: Date
		}
		let contributionDays: [ContributionDay]
	}

	let weeks: [Week]

	private enum RootCodingKeys: String, CodingKey { case data }
	private enum DataCodingKeys: String, CodingKey { case user }
	private enum UserCodingKeys: String, CodingKey { case contributionsCollection }
	private enum ContributionsCollectionCodingKeys: String, CodingKey { case contributionCalendar }
	private enum ContributionCalendarCodingKeys: String, CodingKey { case weeks }

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RootCodingKeys.self)
		let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
		let userContainer = try dataContainer.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .user)
		let contributionsContainer = try userContainer.nestedContainer(keyedBy: ContributionsCollectionCodingKeys.self, forKey: .contributionsCollection)
		let calendarContainer = try contributionsContainer.nestedContainer(keyedBy: ContributionCalendarCodingKeys.self, forKey: .contributionCalendar)
		
		weeks = try calendarContainer.decode([Week].self, forKey: .weeks)
	}
}

struct GitHubSubmissionsProvider: SubmissionsProvider {
	let platformType: PlatformType = .github
	func getSubmissions(for username: String) async -> Result<[Submission], any Error> {
		let url = URL(string: Strings.gitHubApiURL)!

		let graphQLRequest = GraphQLRequest(
			url: url,
			query: Strings.gitHubGraphQLQuery,
			variables: ["username": username]
		)
		
		var request = graphQLRequest.request
		request.setValue("Bearer \(Credentials.gitHubApiToken)", forHTTPHeaderField: "Authorization")

		do {
			let (data, _) = try await URLSession.shared.data(for: request)
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
			
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .formatted(dateFormatter)
			
			let response = try decoder.decode(GitHubResponse.self, from: data)
			
			let weeks = response.weeks
			
			let contributions = weeks.flatMap { week in
				week.contributionDays.map { day in
					Submission(date: day.date, submissionsCount: day.contributionCount)
				}
			}

			return .success(contributions.filter({ $0.submissionsCount > 0 }))
		} catch {
			return .failure(error)
		}
	}
	
}
