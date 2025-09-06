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
	
	var body: some View {
		Label {
			Text(title)
		} icon: {
			image
				.resizable()
				.frame(width: 25, height: 25)
		}
	}
}

#Preview {
	PlatformUsernameLabel(title: "GitHub", image: Image(.github))
}
