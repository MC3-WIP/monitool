//
//  IphoneReviseView.swift
//  monitool
//
//  Created by Mac-albert on 12/08/21.
//

import SwiftUI

struct IphoneReviseView: View {
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    @StateObject var reviseViewModel: TodayListViewModel
    @ObservedObject var taskViewModel = TaskViewModel()
    
    @State var totalPage: Int = 3
    @State var datePhoto = "21 Juli 2021 at 15.57"
    @State var proofPage = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    init (task: Task){
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
        _reviseViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }
    
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                NoSeparatorList{
                    Text(taskDetailViewModel.task.name)
                        .font(.system(size: 28, weight: .bold))
                        .frame(width: proxy.size.width, alignment: .leading)
                    Text("Proof of Work")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: proxy.size.width, alignment: .leading)
                        .foregroundColor(Color(hex: "898989"))
                    proofOfWorkComponent(matric: proxy, proofPage: proofPage, totalPage: totalPage, datePhoto: datePhoto)
                        .padding(.top, 10)
                    
                    VStack(spacing: 4){
                        HStack{
                            Text("PIC: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .fontWeight(.bold)
                            Text(taskDetailViewModel.pic?.name ?? "-")
                        }
                        .frame(width: proxy.size.width, alignment: .leading)
                        HStack{
                            Text("Notes: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .fontWeight(.bold)
                            Text(taskDetailViewModel.task.notes ?? "-")
                        }
                        .frame(width: proxy.size.width, alignment: .leading)
                    }
                    .font(.system(size: 17))
                    .padding(.vertical, 18)
                    
                    Image("kucing1")
                        .resizable()
                        .frame(width: proxy.size.width, height: proxy.size.width)
                    if let desc = taskDetailViewModel.task.desc{
                        Text(desc)
                            .font(.system(size: 17))
                            .multilineTextAlignment(.leading)
                    }
                    
                    VStack(spacing: 8){
                        approveButton()
                        reviseButton()
                    }
                    .padding(.vertical, 24)
                    
                }
            }
        }
        .padding()
    }
    @ViewBuilder func proofOfWorkComponent(matric: GeometryProxy, proofPage: Int, totalPage: Int, datePhoto: String) -> some View {
            VStack{
                ZStack{
                    switch proofPage{
                    case 0:
                        ProofOfWork(image: "kucing2", date: "21 Jul 2021 at 15:57", metricSize: matric, datePhoto: datePhoto)
                    case 1:
                        ProofOfWork(image: "kucing3", date: "21 Jul 2021 at 15:57", metricSize: matric, datePhoto: datePhoto)
                    case 2:
                        ProofOfWork(image: "kucing4", date: "21 Jul 2021 at 15:57", metricSize: matric, datePhoto: datePhoto)
                    default:
                        Text("Error")
                    }
                }
                .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                    .onEnded { value in
                        if abs(value.translation.height) < abs(value.translation.width) {
                            if abs(value.translation.width) > 50.0 {
                                if value.translation.width > 0 {
                                    if proofPage == 0{
                                        
                                    }
                                    else{
                                        self.proofPage -= 1
                                    }
                                }
                                else if value.translation.width < 0 {
                                    if proofPage == totalPage - 1 {
                                        
                                    }
                                    else{
                                        self.proofPage += 1
                                    }
                                }
                            }
                        }
                    }
                )
                PageControl(totalPage: totalPage, current: proofPage)
            }
            .frame(width: matric.size.width)
            .padding(.vertical, 20)
            .background(Color(hex: "F0F9F8"))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
            )
    }
    
    @ViewBuilder
    func ProofOfWork(image: String, date: String, metricSize: GeometryProxy, datePhoto: String) -> some View{
        VStack{
            Image(image)
                .resizable()
                .frame(width: metricSize.size.width * 0.85, height: metricSize.size.width * 0.85)
            Text(datePhoto)
                .font(.system(size: 11))
                .frame(width: metricSize.size.width * 0.85, height: 12, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func reviseButton() -> some View{
        Button(action: {
            // MARK: ACTION BUTTON REVISE
            taskViewModel.updateStatus(id: taskDetailViewModel.task.id, status: TaskStatus.completed.title)
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Image(systemName: "repeat")
                Text("Revise")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding()
            .foregroundColor(Color(hex: "#4FB0AB"))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
                            )
        }
    }
    
    @ViewBuilder
    func approveButton() -> some View{
        Button(action: {
            // MARK: ACTION BUTTON APPROVE
            
        }){
            HStack{
                Image(systemName: "checkmark")
                Text("Approve")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding()
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
            ).background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#4FB0AB")))
        }
    }
}

struct IphoneReviseView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneReviseView(task: Task(name: "Revise Iphone", repeated: []))
    }
}
