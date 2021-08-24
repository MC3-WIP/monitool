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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                descComponent()
                Spacer()
                statusComponent()
                proofOfWorkComponent()
                PICComponent()
                notesComponent()
                commentComponent()
            }
            .padding()
            .navigationTitle(taskDetailViewModel.task.name)
        }
    }

    @ViewBuilder func descComponent() -> some View {
        if taskDetailViewModel.task.desc == "" {
            Text("No description").foregroundColor(.gray)
        } else if let desc = taskDetailViewModel.task.desc {
            Text(desc)
        }
    }

    @ViewBuilder func statusComponent() -> some View {
        Text("Status")
            .font(.title2)
            .fontWeight(.bold)
        Text(taskDetailViewModel.task.status.rawValue)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color("LightTosca"))
            .cornerRadius(40)
    }

    @ViewBuilder func proofOfWorkComponent() -> some View {
        Text("Proof of Work")
            .font(.title2)
            .fontWeight(.bold)
        if let image = taskDetailViewModel.task.photoReference {
            WebImage(url: URL(string: image))
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
        } else {
            Image("MonitoolEmptyReferenceIllus")
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
        }
    }

    @ViewBuilder func PICComponent() -> some View {
        Text("PIC")
            .font(.title2)
            .fontWeight(.bold)
        HStack {
            Text(taskDetailViewModel.pic?.name ?? "-")
                .padding(.horizontal)
            Spacer()
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .background(AppColor.accent.brightness(0.65))
    }

    @ViewBuilder func notesComponent() -> some View {
        Text("Notes")
            .font(.title2)
            .fontWeight(.bold)
        HStack {
            Text(taskDetailViewModel.task.notes ?? "-")
                .padding(.horizontal)
            Spacer()
        }
        .frame(minHeight: 100, alignment: .topLeading)
        .padding(.horizontal, 5)
        .padding(.vertical, 15)
        .background(AppColor.accent.brightness(0.65))
    }

    @ViewBuilder func commentComponent() -> some View {
        Text("Comment")
            .font(.title2)
            .fontWeight(.bold)
        HStack {
            Text(taskDetailViewModel.task.comment ?? "-")
                .padding(.horizontal)
            Spacer()
        }
        .frame(minHeight: 100, alignment: .topLeading)
        .padding(.horizontal, 5)
        .padding(.vertical, 15)
        .background(AppColor.accent.brightness(0.65))
    }
}

struct HistoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetail(history: Task(name: "Test", repeated: [false]))
    }
}
