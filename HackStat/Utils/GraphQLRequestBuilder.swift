//
//  GraphQLRequestBuilder.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct GraphQLRequestBuilder {
	static func build(url: URL, query: String, variables: [String: Any]) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	
		let body: [String: Any] = ["query": query, "variables": variables]
		
		request.httpBody = try? JSONSerialization.data(withJSONObject: body)
		
		return request
	}
}
