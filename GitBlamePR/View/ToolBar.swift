//
//  ToolBar.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct ToolBar: View {
    @State var textField: String
    var textFieldOnCommit: (String) -> Void

    var body: some View {
        VStack {
            TextField(
                "Enter full path",
                text: $textField,
                onEditingChanged: {_ in },
                onCommit: {
                    self.textFieldOnCommit(self.textField)
                })
                .lineLimit(1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

struct ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ToolBar(
            textField: "hello!",
            textFieldOnCommit: {_ in }
        )
    }
}
