//
//  PlatformUsernameField 2.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//


import SwiftUI

struct PlatformUsernameLabel: View {
	let title: String
	let image: Image
	let status: PlatformStatus?
	
	init(title: String, image: Image, status: PlatformStatus? = nil) {
		self.title = title
		self.image = image
		self.status = status
	}
	
	var body: some View {
		Label {
			Text(title)
		} icon: {
			ZStack(alignment: .topTrailing) {
				image
					.resizable()
					.frame(width: 25, height: 25)
				
				if let status {
					PlatformStatusIndicator(status: status)
						.offset(x: 3, y: -3)
				}
			}
		}
	}
}

#Preview {
	PlatformUsernameLabel(title: "GitHub", image: Image(.github))
}
