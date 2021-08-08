//
//  TaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 03/08/21.
//

import SwiftUI

struct EmployeeReviewView: View {
    
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    
    init (task: Task){
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
    }
    
    
    private let pic: String = "Mawar"
    private let notes: String = "Sudah Pak Bos"
    // MARK: INITIALIZE TOTAL PAGE
    @State var totalPage: Int = 3
    @State var datePhoto = "21 Juli 2021 at 15.57"
    @State var proofPage = 0
    
    var body: some View {
        VStack{
            ScrollView{
                HStack{
                    LeftColumn()
                    RightColumn()
                }
            }
        }
    }
    @ViewBuilder
    func ProofOfWork(image: String, date: String, metricSize: GeometryProxy) -> some View{
        VStack{
            Image(image)
                .resizable()
                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            Text("21 Jul 2021 at 15:57")
                .font(.system(size: 11))
                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeReviewView(task: (Task(name: "EmployeeReview")))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
        //        TaskDetailView()
        //
        //            .previewDevice("iPad Air (4th generation)")
        //            .environment(\.horizontalSizeClass, .regular)
    }
}

//struct PageControllProofOfWork: UIViewRepresentable{
//    
//    var totalPage = 0
//    var current  = 0
//    
//    func makeUIView(context: UIViewRepresentableContext<PageControllProofOfWork>) -> UIPageControl {
//        let page = UIPageControl()
//        page.currentPageIndicatorTintColor = UIColor(Color(hex: "4EB0AB"))
//        page.numberOfPages = totalPage
//        page.pageIndicatorTintColor = .gray
//        
//        return page
//    }
//    
//    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControllProofOfWork>) {
//        uiView.currentPage = current
//    }
//}
