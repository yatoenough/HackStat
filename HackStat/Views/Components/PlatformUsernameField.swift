//
//  PlatformUsernameField.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct PlatformUsernameField: View {
	let title: String
	let image: Image
	
	@Binding var username: String
	
	var body: some View {
		HStack {
			PlatformUsernameLabel(title: title, image: image)

			Spacer()

			TextField("Username", text: $username)
				.transition(.opacity)
		}
	}
}

#Preview {
	PlatformUsernameField(title: "GitHub", image: Image(.github), username: .constant(""))
}
