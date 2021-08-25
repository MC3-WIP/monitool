//
//  LeftColumnTaskDetail.swift
//  monitool
//
//  Created by Mac-albert on 25/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct LeftColumnTaskDetail: View {
    var todayListViewModel: TodayListViewModel
    var taskDetailViewModel: TaskDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.task.name)
                .font(.system(size: 28, weight: .bold))
            if let image = viewModel.task.photoReference {
                WebImage(url: URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 400)
            } else {
                Image("MonitoolEmptyReferenceIllus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 400)
            }
            if let desc = viewModel.task.desc {
                Text(desc)
                    .font(.system(size: 17))
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}
