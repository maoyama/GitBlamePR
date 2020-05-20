//
//  AccessToken.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct PersonalAccessTokenView: View {
    @State var token: String = ""
    var hasToken: Bool
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
                    Button("Delete Token") {
                        print(self.token)
                    }
                }
            } else {
                HStack {
                    SecureField("", text: $token)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 300)
                    Button("Save") {
                        print(self.token)
                    }
                }
            }
        }
            .padding()
    }
}

struct PersonalAccessTokenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonalAccessTokenView(hasToken: false)
            PersonalAccessTokenView(hasToken: true)
        }
    }
}
