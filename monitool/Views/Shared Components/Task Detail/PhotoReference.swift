//
//  PhotoReference.swift
//  monitool
//
//  Created by Christianto Budisaputra on 31/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoReference: View {
    let url: String?

    var body: some View {
        if let imageUrl = url, !imageUrl.isEmpty {
            WebImage(url: URL(string: imageUrl))
                .resizable()
                .indicator { _, _ in
                    ProgressView()
                }
                .scaledToFit()
        } else {
            Image("EmptyReference")
                .resizable()
                .scaledToFit()
                .padding([.horizontal, .bottom], 36)
        }
    }
}

struct PhotoReference_Previews: PreviewProvider {
    static var previews: some View {
        PhotoReference(url: "")
    }
}
