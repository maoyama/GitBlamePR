//
//  AccessToken.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct PersonalAccessTokenView: View {
    @State private var token = ""
    var hasToken: Bool
    var error = ""
    var saveButtonAction: (_ token: String) -> Void
    var removeButtonAction: () -> Void

    var body: some View {
        VStack() {
            HStack {
                Image("GitHub-Mark-L")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 26, height: 26)

                Text("Personal access token")
                    .font(.headline)
            }
            Text("""
                Token are needed to get a Pull Request for the following reasons:
                - To avoid api limit
                - To access private repositoies
                """)
            if hasToken {
                HStack {
                    Text("There are previously saved token.")
                        .foregroundColor(.secondary)
                    Button("Remove", action: removeButtonAction)
                }
            } else {
                HStack {
                    SecureField("", text: $token)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 300)
                    Button("Save") {
                        self.saveButtonAction(self.token)
                    }
                }
            }
            if !error.isEmpty {
                Text(error)
            }
        }
            .padding()
            .background(Color(.windowBackgroundColor))

    }
}

struct PersonalAccessTokenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonalAccessTokenView(
                hasToken: false,
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
                .environment(\.colorScheme, .light)
            PersonalAccessTokenView(
                hasToken: true,
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
                .environment(\.colorScheme, .light)
            PersonalAccessTokenView(
                hasToken: true,
                error: "Some error occurred",
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
                .environment(\.colorScheme, .light)

            PersonalAccessTokenView(
                hasToken: false,
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
                .environment(\.colorScheme, .dark)
            PersonalAccessTokenView(
                hasToken: true,
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
                .environment(\.colorScheme, .dark)
            PersonalAccessTokenView(
                hasToken: true,
                error: "Some error occurred",
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
                .environment(\.colorScheme, .dark)

        }
    }
}
