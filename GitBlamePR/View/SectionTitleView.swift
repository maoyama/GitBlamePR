//
//  SectionTitleView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/02.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct SectionTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.system(size: 11))
            .foregroundColor(.primary)
            .opacity(0.6)
    }
}

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView(title: "Library")
    }
}
