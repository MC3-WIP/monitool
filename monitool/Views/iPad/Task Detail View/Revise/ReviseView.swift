//
//  ReviseTaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI

struct ReviseView: View {
    @StateObject var reviseViewModel: TodayListViewModel
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    @ObservedObject var taskViewModel = TaskViewModel()
    @Environment(\.presentationMode) var presentationMode

    init (task: Task) {
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
        _reviseViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    private let notes = "Sudah Pak Bos"
    private let pic = "Mawar"

    @State var totalPage: Int = 3
    @State var datePhoto = "21 Juli 2021 at 15.57"
    @State private var comment: String = ""
    @State var proofPage = 0

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    leftColumn()
                    rightColumn()
                }
                .frame(height: 680)
            }
            HStack(spacing: 24) {

                reviseButton()
                approveButton()
            }.padding()
        }
    }
}

struct ReviseTaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviseView(task: Task(name: "Revise Page", repeated: []))
    }
}
