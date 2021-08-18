//
//  PageControllProofOfWork.swift
//  monitool
//
//  Created by Mac-albert on 06/08/21.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var totalPage = 0
    var current = 0

    func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor(Color(hex: "4EB0AB"))
        page.numberOfPages = totalPage
        page.pageIndicatorTintColor = .gray
        return page
    }

    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
        uiView.currentPage = current
    }
}
