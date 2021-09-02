//
//  File.swift
//  monitool
//
//  Created by Devin Winardi on 20/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct HistoryDetail: View {
    @StateObject var taskDetailViewModel: TaskDetailViewModel

    init(history: Task) {
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: history))
    }

    private let dateHelper = DateLogHelper()

    private var logs: [ActivityLog] {
        var log = [ActivityLog]()
        let task = taskDetailViewModel.task

        for index in 0...task.titleLog.count - 1 {
            log.append(
                ActivityLog(
                    title: task.titleLog[index],
                    timestamp: dateHelper.getStringFromDate(date: task.timeStampLog[index])
                )
            )
        }
        return log
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                descComponent()
                statusComponent()
                ProofOfWork(task: taskDetailViewModel.task)
                PICComponent()
                notesComponent()
                commentComponent()

                // Logs
                VStack(alignment: .leading) {
                    Text("Logs").foregroundColor(.gray).font(.title3).bold()

                    NoSeparatorList {
                        if logs.count > 0 {
                            ForEach(logs, id: \.id) { log in
                                HStack {
                                    Text(log.title)
                                    Spacer()
                                    Text(log.timestamp)
                                }
                            }
                        } else {
                            Text("There hasn't been anything going on.")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                    }
                    .padding([.horizontal, .top])
                    .background(AppColor.lightAccent)
                }
            }
            .padding(18)
            .navigationTitle(taskDetailViewModel.task.name)
        }
    }

    @ViewBuilder func descComponent() -> some View {
        if let desc = taskDetailViewModel.task.desc, !desc.isEmpty {
            Text(desc)
        } else {
            Text("No description").foregroundColor(.gray)
        }
    }

    @ViewBuilder func statusComponent() -> some View {
        HStack {
            Text("Status").foregroundColor(.gray).font(.title3).bold()
            Spacer()
            Text(taskDetailViewModel.task.status.title)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(AppColor.lightAccent)
                .cornerRadius(32)
        }
    }

    @ViewBuilder func PICComponent() -> some View {
        Text("PIC")
            .font(.title2)
            .fontWeight(.bold)
        Text(taskDetailViewModel.pic?.name ?? "-")
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()
            .background(AppColor.lightAccent)
            .cornerRadius(8)
    }

    @ViewBuilder func notesComponent() -> some View {
        Text("Notes").foregroundColor(.gray).font(.title3).bold()
        Text(taskDetailViewModel.task.notes ?? "-")
            .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
            .padding()
            .background(AppColor.lightAccent)
            .cornerRadius(8)
    }

    @ViewBuilder func commentComponent() -> some View {
        Text("Comment").foregroundColor(.gray).font(.title3).bold()
        Text(taskDetailViewModel.task.comment ?? "-")
            .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
            .padding()
            .background(AppColor.lightAccent)
            .cornerRadius(8)
    }
}

struct HistoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetail(history: Task(name: "Test"))
    }
}
