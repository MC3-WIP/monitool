//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct IphoneTodayListView: View {
    @StateObject var todayListViewModel: TodayListViewModel

    init(task: Task) {
        _todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                Text(todayListViewModel.task.name.capitalized)
                    .font(.title2.weight(.bold))

                HStack {
                    Text("Proof of Work")
                        .font(.title3.weight(.bold))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(
                        todayListViewModel.imageToBeAdded != nil ? "Retake" : "Add Photo",
                        action: todayListViewModel.showImagePicker
                    )
                }

                if let imageToBeAdded = todayListViewModel.imageToBeAdded {
                    Image(uiImage: imageToBeAdded)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(12)
                } else if let proofOfWork = todayListViewModel.proofOfWork, proofOfWork.count > 0 {
                    Carousel(images: todayListViewModel.task.proof)
                } else {
                    Image("MonitoolAddPhotoIllustration")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .padding(36)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("PIC: ")
                            .foregroundColor(.gray)
                            .bold()
                        Text(todayListViewModel.task.notes ?? "-")
                    }
                    HStack {
                        Text("Notes: ")
                            .foregroundColor(.gray)
                            .bold()
                        Text(todayListViewModel.task.notes ?? "-")
                    }
                }

                Group {
                    if let image = todayListViewModel.task.photoReference {
                        WebImage(url: URL(string: image))
                            .resizable()
                    } else {
                        Image("MonitoolEmptyReferenceIllus")
                            .resizable()
							.padding(36)
                    }
                }

                if let desc = todayListViewModel.task.desc {
                    Text(desc)
                }
            }
            .fullScreenCover(isPresented: $todayListViewModel.isImagePickerShowing) {
                ImagePicker(sourceType: .camera) { image in
                    todayListViewModel.imageToBeAdded = image
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }

    @ViewBuilder func ProofOfWork(image _: String, date _: String, metricSize: GeometryProxy) -> some View {
        VStack {
            Image("MonitoolAddPhotoIllustration")
                .resizable()
                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
        }
    }
}

struct IphoneTodayListView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneTodayListView(task: Task(name: "Task1", repeated: []))
            .previewDevice("Iphone 12")
    }
}
