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
    let detailWidthMin: CGFloat = 100

    private var drag: some Gesture {
        DragGesture(minimumDistance: 1, coordinateSpace: .global)
            .onChanged { value in
                self.detailWidth = max(self.detailWidthOfDraggOnEnd - value.translation.width, self.detailWidthMin)
                self.applyCoursor(dragging: true)
            }.onEnded { (value) in
                self.detailWidthOfDraggOnEnd = max(self.detailWidthOfDraggOnEnd - value.translation.width, self.detailWidthMin)
                self.applyCoursor(dragging: false)
            }
    }

    var body: some View {
        HStack(spacing: 0) {
            master
            SplitSeparator().frame(width: 1).gesture(drag).onHover { (enters) in
                if enters {
                    self.applyCoursor(dragging: true)
                } else {
                    self.applyCoursor(dragging: false)
                }
            }
            detail.frame(width: detailWidth)
        }
    }

    private func applyCoursor(dragging: Bool) {
        guard dragging else {
            NSCursor.arrow.set()
            return
        }
        if self.detailWidth == self.detailWidthMin {
            NSCursor.resizeLeft.set()
        } else {
            NSCursor.resizeLeftRight.set()
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
