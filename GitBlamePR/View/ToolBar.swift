//
//  ToolBar.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct ToolBar: View {
    @Binding var path:  String

    var body: some View {
        VStack(spacing: 0) {
            TextField("Enter full path", text: $path)
                .lineLimit(1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 3, leading: 8, bottom: 8, trailing: 8))
            Divider()
        }
        .background(Color(.windowBackgroundColor))
    }
}

struct ToolBar_Previews: PreviewProvider {

    static var previews: some View {
        ToolBar(path: Binding<String>(get: { () -> String in
            "hello"
        }, set: { _ in }))
    }
}
