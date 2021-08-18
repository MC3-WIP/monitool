//
//  HistoryTaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HistoryTaskDetailView: View {
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    @StateObject var historyViewModel: TodayListViewModel
    @State var proofPage = 0
    @State var totalPage = 3

    init(task: Task) {
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
        _historyViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    var body: some View {
        ScrollView {
            HStack {
                GeometryReader { metric in
                    VStack {
                        Text(taskDetailViewModel.task.name)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.vertical, 24.0)
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                        if let image = historyViewModel.task.photoReference {
                            WebImage(url: URL(string: image))
                                .resizable()
                                .frame(width: metric.size.width * 0.75, height: metric.size.width * 0.75, alignment: .leading)
                        }
                        Text(taskDetailViewModel.task.desc ?? "-")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 17))
                            .multilineTextAlignment(.leading)
                    }
                }
                GeometryReader { matric in
                    VStack(spacing: 8) {
                        Text("Proof of Work")
                            .padding(.bottom, 8)
                            .font(.system(size: 20, weight: .bold))
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
                            .foregroundColor(Color("DarkGray"))
                        VStack {
                            ZStack {
                                switch proofPage {
                                case 0:
                                    ProofOfWork(image: "kucing2", date: "21 Jul 2021 at 15:57", metricSize: matric)
                                case 1:
                                    ProofOfWork(image: "kucing3", date: "21 Jul 2021 at 15:57", metricSize: matric)
                                case 2:
                                    ProofOfWork(image: "kucing4", date: "21 Jul 2021 at 15:57", metricSize: matric)
                                default:
                                    Text("Error")
                                }
                            }
                            .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                                .onEnded { value in
                                    if abs(value.translation.height) < abs(value.translation.width) {
                                        if abs(value.translation.width) > 50.0 {
                                            if value.translation.width > 0 {
                                                if proofPage == 0 {

                                                } else {
                                                    proofPage -= 1
                                                }
                                            } else if value.translation.width < 0 {
                                                if proofPage == totalPage - 1 {

                                                } else {
                                                    proofPage += 1
                                                }
                                            }
                                        }
                                    }
                                }
                            )
                            PageControl(totalPage: 3, current: 0)
                        }
                        .frame(width: matric.size.width * 0.75)
                        .padding(.top, 10)
                        .background(Color("LightTosca"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("Accent"), lineWidth: 1)
                        )
                        HStack {
                            Text("PIC: ")
                                .foregroundColor(Color("DarkGray"))
                                .font(.system(size: 17, weight: .bold))
                            Text(taskDetailViewModel.pic?.name ?? "-")
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        .padding(.top, 27)

                        HStack {
                            Text("Notes: ")
                                .foregroundColor(Color("DarkGray"))
                                .font(.system(size: 17, weight: .bold))
                            Text(taskDetailViewModel.task.notes ?? "-")
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        .padding(.top, 20)
                        Spacer()
                        HStack {
                            Text("Comment: ")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color("DarkGray"))
                                .frame(alignment: .topLeading)
                            Text(taskDetailViewModel.task.comment ?? "-")
                                .fixedSize(horizontal: false, vertical: true)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        Spacer()
                        VStack {
                            Text("Log")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color("DarkGray"))
                                .frame(alignment: .topLeading)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        ScrollView(.vertical) {
                            List {
                                ForEach(0..<10) {_ in
                                    HStack {
                                        Text("Aku kiri")
                                        Spacer()
                                        Text("Aku kanan")
                                    }.padding(.horizontal)
                                }
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 105, alignment: .topLeading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("Accent"), lineWidth: 1)
                        )
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color("LightTosca")))
                    }
                    .frame(width: matric.size.width * 0.9)
                }
            }
        }
    }
    @ViewBuilder
    func ProofOfWork(image: String, date: String, metricSize: GeometryProxy) -> some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            Text("21 Jul 2021 at 15:57")
                .font(.system(size: 11))
                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }
}
