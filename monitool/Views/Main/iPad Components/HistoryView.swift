//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var taskViewModel = TaskViewModel()
    let dateHelper: DateHelper = DateHelper()
    
    let min2Day = Calendar.current.date(byAdding: .day, value: -2, to: Date())
    
    init(){
        UITableViewHeaderFooterView.appearance().backgroundView = .init()
    }
    
    var body: some View {
        List {
            Section(header: Text("Today").font(.title).foregroundColor(.black).fontWeight(.bold)){
                ForEach(taskViewModel.tasks, id: \.id){ task in
                    if(dateHelper.getNumDays(first: Date(), second: task.createdAt) == 0 && task.status.rawValue == "Completed"){
                        HistoryRow(task: task)
                    }
                }
            }
            .textCase(nil)
            .listRowBackground(AppColor.primaryForeground)
            
            Section(header: Text("Yesterday").font(.title).foregroundColor(.black).fontWeight(.bold)){
                ForEach(taskViewModel.tasks, id: \.id){ task in
                    if(dateHelper.getNumDays(first: task.createdAt, second: Date()) == 1 && task.status.rawValue == "Completed"){
                        HistoryRow(task: task)
                    }
                }
            }
            .textCase(nil)
            
            Section(header: Text(dateHelper.getStringFromDate(date: min2Day!)).font(.title).foregroundColor(.black).fontWeight(.bold)){
                ForEach(taskViewModel.tasks, id: \.id){ task in
                    if(dateHelper.getNumDays(first: task.createdAt, second: Date()) == 2 && task.status.rawValue == "Completed"){
                        HistoryRow(task: task)
                    }
                }
            }
            .textCase(nil)
        }
        .listStyle(PlainListStyle())
		.navigationTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
