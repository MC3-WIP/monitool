//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//
import SwiftUI
import SDWebImageSwiftUI

struct IphoneTodayListView: View {
    @StateObject var todayListViewModel: TodayListViewModel
    
    
    init(task: Task) {
        _todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }
    
    var body: some View {
        VStack{
            GeometryReader{proxy in
                NoSeparatorList{
                    Text(todayListViewModel.task.name)
                        .font(.system(size: 28, weight: .bold))
                        .frame(width: proxy.size.width, alignment: .leading)
                    Text("Proof of Work")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: proxy.size.width, alignment: .leading)
                        .foregroundColor(Color(hex: "898989"))
                    ProofOfWork(image: "kucing2", date: "p", metricSize: proxy)
                        .frame(width: proxy.size.width, height: proxy.size.width)
                        .padding(.vertical, 10)
                        .background(Color(hex: "F0F9F8"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                        )
                    VStack(spacing: 4){
                        HStack{
                            Text("PIC: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .fontWeight(.bold)
                            Text(todayListViewModel.task.notes ?? "-")
                        }
                        .frame(width: proxy.size.width, alignment: .leading)
                        HStack{
                            Text("Notes: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .fontWeight(.bold)
                            Text(todayListViewModel.task.notes ?? "-")
                        }
                        .frame(width: proxy.size.width, alignment: .leading)
                    }
                    .font(.system(size: 17))
                    .padding(.vertical, 18)
                    
                    WebImage(url: URL(string: todayListViewModel.task.photoReference ?? ""))
                        .resizable()
                        .frame(width: proxy.size.width, height: proxy.size.width)
                    if let desc = todayListViewModel.task.desc{
                        Text(desc)
                            .font(.system(size: 17))
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topLeading)
            }
        }
        .padding()
    }
    @ViewBuilder func ProofOfWork(image: String, date: String, metricSize: GeometryProxy) -> some View{
        VStack{
            if image == ""{
                Image("MonitoolAddPhotoIllustration")
                    .resizable()
                    .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            }
            else{
                Image(image)
                    .resizable()
                    .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            }
        }
    }
}

struct IphoneTodayListView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneTodayListView(task: Task(name: "Task1", repeated: []))
            .previewDevice("Iphone 12")
    }
}
