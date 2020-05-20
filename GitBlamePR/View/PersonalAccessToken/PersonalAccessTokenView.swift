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
        VStack {
            Text("Personal access token")
                .fontWeight(.bold)
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
            PersonalAccessTokenView(
                hasToken: true,
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
            PersonalAccessTokenView(
                hasToken: true,
                error: "Some error occurred",
                saveButtonAction: {_ in },
                removeButtonAction: {}
            )
        }
    }
}
