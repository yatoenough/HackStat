//
//  UsernameFieldCard.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI

struct UsernameFieldCard: View {
    let title: String
    let emoji: String
    let color: Color
    let username: Binding<String>

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 40, height: 40)

                Text(emoji)
                    .font(.system(size: 20))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.primary)

                TextField("Enter username", text: username)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(14)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

#Preview() {
	UsernameFieldCard(title: "Demo", emoji: "💻", color: .blue, username: .constant(""))
}
