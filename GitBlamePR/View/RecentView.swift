//
//  RecentView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/22.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import SwiftUI

struct RecentViewModel {
    var fullPaths: [(value: String, id: UUID)]
}

struct RecentView: View {
    var model: RecentViewModel
    var textOnTap: (String) -> Void
    var clearOnTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Recent")
                    .font(.headline)
                Spacer()
                Button("Clear") {
                    self.clearOnTap()

                }
            }
            ForEach(model.fullPaths, id: \.id) { fullPath in
                Text(fullPath.value)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        self.textOnTap(fullPath.value)
                    }
            }
        }
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView(model: RecentViewModel(fullPaths: [
            (value: "/Users/aoyama/Dropbox/GitBlamePR/GitBlamePR/ContentView1.swift", id: UUID()),
            (value: "/Users/aoyama/Dropbox/GitBlamePR/GitBlamePR/ContentView1.swift", id: UUID()),
            (value: "/Users/aoyama/Dropbox/GitBlamePR/GitBlamePR/ContentView1.swift", id: UUID()),
            (value: "/Users/aoyama/Dropbox/GitBlamePR/GitBlamePR/ContentView1.swift", id: UUID()),
        ]), textOnTap: {_ in }, clearOnTap: {})
    }
}
