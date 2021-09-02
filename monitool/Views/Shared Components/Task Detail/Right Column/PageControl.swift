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

    func makeUIView(context _: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor(AppColor.accent)
        page.numberOfPages = totalPage
        page.pageIndicatorTintColor = .gray
        return page
    }

    func updateUIView(_ uiView: UIPageControl, context _: UIViewRepresentableContext<PageControl>) {
        uiView.currentPage = current
    }
}
