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

struct HistoryRow: View {
    let task: Task
    
    var body: some View{
        VStack(alignment: .leading){
            Text(task.name)
            Text("PIC: ").font(.caption).foregroundColor(Color(hex: "#7A7A7A"))
        }.listRowBackground(Color(hex: "#F0F9F8"))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

struct DateHelper {
    let dateFormatter = DateFormatter()
    func getNumDays(first: Date, second: Date) -> Int {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: first)
        let date2 = calendar.startOfDay(for: second)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
    
    func getStringFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        return dateFormatter.string(from: date)
    }
}
