//
//  Platform.swift
//  HackStatModels
//
//  Created by Nikita Shyshkin on 28/10/2025.
//

import SwiftUI

public struct Platform: Identifiable {
    public let id = UUID()
	public let name: String
	public let emoji: String
	public let count: Int
	public let color: Color
	public let platformType: PlatformType
	
	public init(name: String, emoji: String, count: Int, color: Color, platformType: PlatformType) {
		self.name = name
		self.emoji = emoji
		self.count = count
		self.color = color
		self.platformType = platformType
	}
}
