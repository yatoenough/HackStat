//
//  PlatformUsernameField.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

public struct PlatformUsernameField: View {
	let title: String
	let image: Image
	
	@Binding var username: String
	
	public init(title: String, image: Image, username: Binding<String>) {
		self.title = title
		self.image = image
		self._username = username
	}
	
	public var body: some View {
		HStack {
			PlatformUsernameLabel(title: title, image: image)

			Spacer()

			TextField("Username", text: $username)
				.transition(.opacity)
		}
	}
}

#Preview {
	PlatformUsernameField(title: "Platform", image: Image(systemName: "person.crop.circle"), username: .constant(""))
}
