//
//  SplitView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/28.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct SplitView<Master, Detail>: View where Master : View, Detail : View {
    var master: Master
    var detail: Detail

    @State private var detailWidth: CGFloat = 200
    @State private var detailWidthOfDraggOnEnd: CGFloat = 200

    private var drag: some Gesture {
        DragGesture(minimumDistance: 1, coordinateSpace: .global)
            .onChanged { value in
                self.detailWidth = self.detailWidthOfDraggOnEnd - value.translation.width
                NSCursor.resizeLeftRight.set()
            }.onEnded { (value) in
                self.detailWidthOfDraggOnEnd = self.detailWidthOfDraggOnEnd - value.translation.width
            }
    }

    var body: some View {
        HStack(spacing: 0) {
            master
            SplitSeparator().frame(width: 1).gesture(drag).onHover { (enters) in
                if enters {
                    NSCursor.resizeLeftRight.set()
                } else {
                    NSCursor.arrow.set()
                }
            }
            detail.frame(width: detailWidth)
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplitView(master: Text("Master"), detail: Text("Detail"))
            SplitView(master: Text("Master"), detail: Text("Detail")).background(Color(.textBackgroundColor))
                .environment(\.colorScheme, .dark)
        }
    }
}
