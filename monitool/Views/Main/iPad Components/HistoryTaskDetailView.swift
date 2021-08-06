//
//  HistoryTaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI

struct HistoryTaskDetailView: View {
    private let pic: String = "Mawar"
    private let notes: String = "Sudah Pak Bos"
    // MARK: INITIALIZE TOTAL PAGE
    private let totalPage: Int = 3
    private let comment: String = "Kursi yang panjang kurang rapi, lalu lantai depan masih kurang bersih."
    
    @State var proofPage = 0
    
    var body: some View {
        NoSeparatorList{
            HStack{
                GeometryReader{ metric in
                    VStack{
                        Text("Buka Gerbang Toko!")
                            .font(.system(size: 28, weight: .bold))
                            .padding(.vertical, 24.0)
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                        Image("kucing1")
                            .resizable()
                            .frame(width: metric.size.width * 0.75, height: metric.size.width * 0.75, alignment: .leading)
                        Text("Masukkan saja kawat ke lubang kunci dan gerak-gerakkan searah dengan jarum jam. Jika digerakkan berlawanan dengan arah jarum jam sama saja anda menguncinya dan berujung sia-sia. Walaupun demikian, jangan terlalu bergantung pada cara ini, karena bisa saja kualitas kunci yang baik tidak mudah jika dilakukan hal-hal yang tidak sesuai ketentuan dalam proses membuka pintu yang terkunci")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 17))
                            .multilineTextAlignment(.leading)
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
                            ZStack{
                                switch proofPage{
                                case 0:
                                    ProofOfWork(image: "kucing2", date: "21 Jul 2021 at 15:57", metricSize: matric)
                                case 1:
                                    ProofOfWork(image: "kucing3", date: "21 Jul 2021 at 15:57", metricSize: matric)
                                case 2:
                                    ProofOfWork(image: "kucing4", date: "21 Jul 2021 at 15:57", metricSize: matric)
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
                                                    proofPage -= 1
                                                }
                                            }
                                            else if value.translation.width < 0 {
                                                if proofPage == totalPage - 1 {
                                                    
                                                }
                                                else{
                                                    proofPage += 1
                                                }
                                            }
                                        }
                                    }
                                }
                            )
                            PageControl(totalPage: totalPage, current: proofPage)
                        }
                        .frame(width: matric.size.width * 0.75)
                        .padding(.top, 10)
                        .background(Color(hex: "F0F9F8"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                        )
                        HStack{
                            Text("PIC: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 17, weight: .bold))
                            Text(pic)
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        .padding(.top, 27)
                        
                        HStack{
                            Text("Notes: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .font(.system(size: 17, weight: .bold))
                            Text(notes)
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 21, alignment: .leading)
                        .padding(.top, 20)
                        Spacer()
                        HStack{
                            Text("Comment: ")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .frame(alignment: .topLeading)
                            Text(comment)
                                .fixedSize(horizontal: false, vertical: true)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        Spacer()
                        VStack{
                            Text("Log")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .frame(alignment: .topLeading)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        ScrollView(.vertical){
                            List{
                                ForEach(0..<10){number in
                                    HStack{
                                        Text("Aku kiri")
                                        Spacer()
                                        Text("Aku kanan")
                                    }.padding(.horizontal)
                                }
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 105, alignment: .topLeading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                        )
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "#F0F9F8")))
                    }
                    .frame(width: matric.size.width * 0.9)
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

struct HistoryTaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTaskDetailView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
