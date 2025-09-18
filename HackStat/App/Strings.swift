//
//  Strings.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

struct Strings {
	// MARK: - AppStorage Keys
	static let useSameUsernameKey = "useSameUsername"
	static let universalUsernameKey = "universalUsername"
	
	static let githubUsernameKey = "githubUsername"
	static let gitlabUsernameKey = "gitlabUsername"
	static let codewarsUsernameKey = "codewarsUsername"
	static let leetcodeUsernameKey = "leetcodeUsername"
	
	static let firstWeekdayKey = "firstWeekday"
	
	// MARK: - API URLs
	static let leetCodeApiURL = "https://leetcode.com/graphql"
	static let gitHubApiURL = "https://api.github.com/graphql"
	static let gitLabApiURL = "https://gitlab.com"
	static let codeWarsApiURL = "https://www.codewars.com/api/v1"
	
	// MARK: - GraphQL Queries
	static let leetCodeGraphQLQuery = """
		query getSubmissions($username: String!) {
			matchedUser(username: $username) {
				submissionCalendar
			}
		}
		"""
	
	static let gitHubGraphQLQuery = """
		query getSubmissions($username: String!) { 
			user(login: $username) {
				contributionsCollection {
					contributionCalendar {
						weeks {
							contributionDays {
								contributionCount
								date
							}
						}
					}
				}
			}
		}
		"""
}
