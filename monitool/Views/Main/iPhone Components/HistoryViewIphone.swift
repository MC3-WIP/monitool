//
//  HistoryViewIphone.swift
//  monitool
//
//  Created by Natalia fellyana Laurensia on 09/08/21.
//

import SwiftUI

struct HistoryViewIphone: View {
    @ObservedObject var taskViewModel = TaskViewModel()
    let dateHelperIphone: DateHelperIphone = DateHelperIphone()
    
    let min2Day = Calendar.current.date(byAdding: .day, value: -2, to: Date())
    
    init(){
        UITableViewHeaderFooterView.appearance().backgroundView = .init()
    }
    
    var body: some View {
        List {
            Section(header: Text("Today").font(.title).foregroundColor(.black).fontWeight(.bold).padding(.top, 10.0)){
                ForEach(taskViewModel.tasks, id: \.id){ task in
                    if(dateHelperIphone.getNumDays(first: Date(), second: task.createdAt) == 0 && task.status.rawValue == "Completed"){
                        HistoryViewRow(task: task)
                    }
                }
            }
            .textCase(nil)
            .listRowBackground(AppColor.primaryForeground)
            
            Section(header: Text("Yesterday").font(.title).foregroundColor(.black).fontWeight(.bold).padding(.top, 10.0)){
                ForEach(taskViewModel.tasks, id: \.id){ task in
                    if(dateHelperIphone.getNumDays(first: task.createdAt, second: Date()) == 1 && task.status.rawValue == "Completed"){
                        HistoryViewRow(task: task)
                    }
                }
            }
            .textCase(nil)
            
            Section(header: Text(dateHelperIphone.getStringFromDate(date: min2Day!)).font(.title).foregroundColor(.black).fontWeight(.bold).padding(.top, 10.0)){
                ForEach(taskViewModel.tasks, id: \.id){ task in
                    if(dateHelperIphone.getNumDays(first: task.createdAt, second: Date()) == 2 && task.status.rawValue == "Completed"){
                        HistoryViewRow(task: task)
                    }
                }
            }
            .textCase(nil)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("History")
    }
}

struct HistoryViewRow: View {
    var task: Task
    
    var body: some View{
        VStack(alignment: .leading){
            Text(task.name)
            Text("PIC: \(task.pic!)").font(.caption).foregroundColor(Color(hex: "#7A7A7A"))
        }.listRowBackground(Color(hex: "#F0F9F8"))
    }
}

struct HistoryViewIphone_Previews: PreviewProvider {
    static var previews: some View {
        HistoryViewIphone()
    }
}

struct DateHelperIphone {
    let dateFormatter = DateFormatter()
    func getNumDays(first: Date, second: Date) -> Int {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: first)
        let date2 = calendar.startOfDay(for: second)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
    
    func getStringFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YY"
        return dateFormatter.string(from: date)
    }
}
