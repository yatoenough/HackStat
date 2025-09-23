//
//  Strings.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

public struct Strings {
	// MARK: - AppStorage Keys
	public static let useSameUsernameKey = "useSameUsername"
	public static let universalUsernameKey = "universalUsername"
	
	public static let githubUsernameKey = "githubUsername"
	public static let gitlabUsernameKey = "gitlabUsername"
	public static let codewarsUsernameKey = "codewarsUsername"
	public static let leetcodeUsernameKey = "leetcodeUsername"
	
	public static let firstWeekdayKey = "firstWeekday"
	
	// MARK: - API URLs
	public static let leetCodeApiURL = "https://leetcode.com/graphql"
	public static let gitHubApiURL = "https://api.github.com/graphql"
	public static let gitLabApiURL = "https://gitlab.com"
	public static let codeWarsApiURL = "https://www.codewars.com/api/v1"
	
	// MARK: - GraphQL Queries
	public static let leetCodeGraphQLQuery = """
		query getSubmissions($username: String!) {
			matchedUser(username: $username) {
				submissionCalendar
			}
		}
		"""
	
	public static let gitHubGraphQLQuery = """
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
