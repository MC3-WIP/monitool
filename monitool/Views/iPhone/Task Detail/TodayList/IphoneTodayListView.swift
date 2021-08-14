//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//

import SwiftUI

struct IphoneTodayListView: View {
    var body: some View {
        VStack{
            GeometryReader{proxy in
                NoSeparatorList{
                    Text("Buka Gerbang Toko")
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
                            Text("-")
                        }
                        .frame(width: proxy.size.width, alignment: .leading)
                        HStack{
                            Text("Notes: ")
                                .foregroundColor(Color(hex: "6C6C6C"))
                                .fontWeight(.bold)
                            Text("-")
                        }
                        .frame(width: proxy.size.width, alignment: .leading)
                    }
                    .font(.system(size: 17))
                    .padding(.vertical, 18)
                    
                    Image("kucing1")
                        .resizable()
                        .frame(width: proxy.size.width, height: proxy.size.width)
                    Text("masukkan saja kawat ke lubang kunci dan gerak-gerakkan searah dengan jarum jam. Jika digerakkan berlawanan dengan arah jarum jam sama saja anda menguncinya dan berujung sia-sia. Walaupun demikian, jangan terlalu bergantung pada cara ini, karena bisa saja kualitas kunci yang baik tidak mudah jika dilakukan hal-hal yang tidak sesuai ketentuan dalam proses membuka pintu yang terkunci")
                        .font(.system(size: 17))
                        .multilineTextAlignment(.leading)
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topLeading)
                

            }
                            
            
        }
        .padding()
    }
    @ViewBuilder func ProofOfWork(image: String, date: String, metricSize: GeometryProxy) -> some View{
        VStack{
            Image(image)
                .resizable()
                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            //            Text("21 Jul 2021 at 15:57")
            //                .font(.system(size: 11))
            //                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }
}

struct IphoneTodayListView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneTodayListView()
            .previewDevice("Iphone 12")
    }
}
