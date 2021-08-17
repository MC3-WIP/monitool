//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject private var taskViewModel = TaskViewModel()
    private let dateHelper = DateHelper()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        List{
            ForEach(0..<6){ index in
                if taskViewModel.historiesPerDay[index].count == 0{
                    EmptyView()
                }
                else{
                    HistoriesSection(histories: taskViewModel.historiesPerDay[index])
                        .padding(.vertical, 5)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .background(Color.white)
    }
        
}

struct HistoriesSection: View{
    var dateHelper = DateHelper()
    var histories: [Task]
    var day: String
    
    init(histories: [Task]){
        self.histories = histories
        if dateHelper.getNumDays(first: histories[0].createdAt, second: Date()) == 0 {
            self.day = "Today"
        }
        else{
            self.day = dateHelper.getStringFromDate(date: histories[0].createdAt)
        }
    }
    
    var body: some View{
        Section(header: Text(day).font(.title).foregroundColor(.black).fontWeight(.bold)){
            ForEach(histories, id: \.id){ history in
                HistoryRow(task: history)
            }
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
