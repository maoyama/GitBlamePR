//
//  LineView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct LineView: View {
    var line: (revision: SourceRevisionViewModel, url: URL?, code: String, number: String)
    var revisionOnSelect: ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void
    var width: CGFloat
    var numberWidth: CGFloat = 30
    var revisionWidth: CGFloat = 90
    var space: CGFloat = 8
    var codeWidth: CGFloat {
        max(width - numberWidth - revisionWidth - space * 2, 100)
    }

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: space) {
                Text(line.number)
                    .font(Font.system(.caption, design: .monospaced)).truncationMode(.head)
                    .foregroundColor(.secondary)
                    .opacity(0.8)
                    .lineLimit(1)
                    .frame(width: numberWidth, alignment: .trailing)
                Text(self.line.code)
                    .font(Font.system(.caption, design: .monospaced))
                    .frame(width: codeWidth, alignment: .leading)
                if line.url == nil {// e.g. Not commited
                    Text(line.revision.description)
                        .lineLimit(1)
                        .font(Font.system(.caption, design: .monospaced))
                        .foregroundColor(.gray)
                        .frame(width: revisionWidth, alignment: .leading)
                } else {
                    Text(line.revision.description)
                        .font(Font.system(.caption, design: .monospaced))
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(width: revisionWidth, height: nil, alignment: .leading)
                        .onTapGesture {
                            self.revisionOnSelect((commitHash: self.line.revision.commitHash, pullRequest: self.line.revision.pullRequest))
                        }
                }

            }
        }
    }
}
