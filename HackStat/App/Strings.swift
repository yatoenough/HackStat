//
//  Strings.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

struct Strings {
	// MARK: - API URLs
	static let leetCodeApiURL = "https://leetcode.com/graphql"
	static let gitHubApiURL = "https://api.github.com/graphql"
	
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
