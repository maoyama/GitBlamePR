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
        VStack {
            Divider()
            Text("Personal access token")
                .onTapGesture {
                    self.show = true
                }

        }
            .popover(isPresented: $show) {
                PersonalAccessTokenView(hasToken: false)
            }

    }
}

struct DetailFooter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailFooter()
        }
    }
}

