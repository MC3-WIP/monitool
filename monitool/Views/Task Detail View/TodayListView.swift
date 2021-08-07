//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI

struct TodayListView: View {

	@StateObject var taskDetailViewModel: TaskDetailViewModel

	init(task: Task) {
		_taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
	}

    private let notes: String = "-"
    // MARK: INITIALIZE TOTAL PAGE
    private let totalPage: Int = 3
    
    @State var proofPage = 0
    
    var body: some View {
        NoSeparatorList{
            HStack{
                GeometryReader{ metric in
                    VStack{
						Text(taskDetailViewModel.task.name)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.vertical, 24.0)
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                        Image("kucing1")
                            .resizable()
                            .frame(width: metric.size.width * 0.75, height: metric.size.width * 0.75, alignment: .leading)
						if let desc = taskDetailViewModel.task.desc {
							Text(desc)
								.fixedSize(horizontal: false, vertical: true)
								.font(.system(size: 17))
								.multilineTextAlignment(.leading)
						}
                    }
                    .padding(.leading, 18.0)
                }
                GeometryReader{ matric in
                    VStack(spacing: 8){
                        Text("Proof of Work")
                            .padding(.bottom, 8)
                            .font(.system(size: 20, weight: .bold))
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
                            .foregroundColor(Color(hex: "898989"))
                        VStack{
                            ProofOfWork(image: "kucing2", date: "p", metricSize: matric)
                        }
                        .frame(width: matric.size.width * 0.75, height: matric.size.width * 0.75)
                        .padding(.vertical, 10)
                        .background(Color(hex: "F0F9F8"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                        )

						HStack{
                            Text("PIC: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 17, weight: .bold))
							Text(taskDetailViewModel.pic?.name ?? "-")
                        }
						.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        .padding(.top, 27)

						HStack{
                            Text("Notes: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 17, weight: .bold))
							Text(taskDetailViewModel.task.notes ?? "-")
                        }
						.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        .padding(.top, 20)
                        
                    }.frame(alignment: .leading)
                }
                
                
            }
        }
    }
    @ViewBuilder
    func ProofOfWork(image: String, date: String, metricSize: GeometryProxy) -> some View{
        VStack{
            Image(image)
                .resizable()
                .frame(width: metricSize.size.width * 0.5, height: metricSize.size.width * 0.5)
//            Text("21 Jul 2021 at 15:57")
//                .font(.system(size: 11))
//                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }
}

struct TodayListView_Previews: PreviewProvider {
    static var previews: some View {
		TodayListView(task: Task(name: "Hehe"))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
