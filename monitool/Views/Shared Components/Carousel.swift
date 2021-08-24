//
//  Carousel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 24/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Carousel: View {
    var images: [String]?

    @State var index = 0

    var body: some View {
        if let images = images {
            VStack {
                Spacer(minLength: 300)
//                    .frame(width: 200, height: 200, alignment: .center)
//                    .clipped()
                PageControl(totalPage: images.count, current: index)
            }
            .padding([.leading, .top, .trailing])
            .background(
                WebImage(url: URL(string: images[index]))
                    .resizable()
                    .indicator { _, _ in
                        ProgressView()
                    }
                    .scaledToFill()
            )
            .cornerRadius(8)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppColor.accent, lineWidth: 2)
            )
            .highPriorityGesture(
                DragGesture(minimumDistance: 25, coordinateSpace: .local)
                    .onEnded { value in
                        let x = abs(value.translation.height)
                        let y = abs(value.translation.width)

                        if x < y, y > 50.0 {
                            if value.translation.width > 0, index > 0 {
                                self.index -= 1
                            } else if value.translation.width < 0,
                                      index < images.count - 1 {
                                self.index += 1
                            }
                        }
                    }
            )
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
