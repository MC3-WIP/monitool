//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct IphoneTodayListView: View {
    @StateObject var todayListViewModel: TodayListViewModel

    init(task: Task) {
        _todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                Text(todayListViewModel.task.name.capitalized)
                    .font(.title2.weight(.bold))

                Text("Proof of Work")
                    .font(.title3.weight(.bold))
                    .foregroundColor(.gray)

                if let proofOfWork = todayListViewModel.proofOfWork, proofOfWork.count > 0 {
                    Carousel(images: todayListViewModel.task.proof)
                } else {
                    Image("AddPhoto")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .padding(36)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("PIC: ")
                            .foregroundColor(.gray)
                            .bold()
                        Text(todayListViewModel.task.notes ?? "-")
                    }
                    HStack {
                        Text("Notes: ")
                            .foregroundColor(.gray)
                            .bold()
                        Text(todayListViewModel.task.notes ?? "-")
                    }
                }.padding(.bottom)

                PhotoReference(url: todayListViewModel.task.photoReference)

                if let desc = todayListViewModel.task.desc {
                    Text(desc)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct IphoneTodayListView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneTodayListView(task: Task(name: "Task1"))
            .previewDevice("Iphone 12")
    }
}
