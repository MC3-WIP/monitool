//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct HistoryView: View {
    var tasks = TaskListViewModel().tasks
    
    var body: some View {
        List{
            Section(header: Text("Today").font(.title).foregroundColor(.black).fontWeight(.bold)){
                HistoryRow()
                HistoryRow()
                HistoryRow()
            }
            .textCase(nil)
            Section(header: Text("Yesterday").font(.title).foregroundColor(.black).fontWeight(.bold)){
                HistoryRow()
                HistoryRow()
                HistoryRow()
            }
            .textCase(nil)
        }
        .listStyle(GroupedListStyle())
        .background(Color.white)
    }
}

struct HistoryRow: View {
    var body: some View{
        VStack(alignment: .leading){
            Text("Todo")
            Text("PIC: Devin").font(.caption).foregroundColor(Color(hex: "#7A7A7A"))
        }.listRowBackground(Color(hex: "#F0F9F8"))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
