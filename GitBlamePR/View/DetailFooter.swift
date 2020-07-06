//
//  DetailFooter.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/19.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct DetailFooter: View {
    @State var show = false
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                Image("GitHub-Mark-S")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 15, height: 15)
                Text("Personal access token")
                    .lineLimit(1)
            }
                .onTapGesture {
                    self.show = true
                }
                .padding(6)
        }
            .popover(isPresented: $show) {
                PersonalAccessTokenViewWrapper()
            }
            .background(Color(.windowBackgroundColor))
    }
}

struct DetailFooter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailFooter()
                .environment(\.colorScheme, .light)
            DetailFooter()
                .environment(\.colorScheme, .dark)
        }
    }
}

