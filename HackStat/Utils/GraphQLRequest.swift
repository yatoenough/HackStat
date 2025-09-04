//
//  GraphQLRequest.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct GraphQLRequest {
	let request: URLRequest
	
	init(url: URL, query: String, variables: [String: Any]) {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	
		let body: [String: Any] = ["query": query, "variables": variables]
		
		request.httpBody = try? JSONSerialization.data(withJSONObject: body)
		
		self.request = request
	}
}
