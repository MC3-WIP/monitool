//
//  ProofOfWork.swift
//  monitool
//
//  Created by Christianto Budisaputra on 26/08/21.
//

import SwiftUI
import FirebaseFirestore

class ProofOfWorkModel: ObservableObject {
    @Published var isImagePickerPresenting = false
    @Published var imageToBeAdded: UIImage?
    @Published var proofOfWork: [String]?

    @ObservedObject var store: Store = .shared

    private let task: Task

    init(task: Task) {
        self.task = task
    }

    func saveChanges() {
        if let image = imageToBeAdded {
            store.post(task: task, image: image) { metadata, _ in
                guard let metadata = metadata, let path = metadata.path else { return }

                self.store.getDownloadURL(path: path) { [self] url in
                    store.update(task: task, field: .proof, with: FieldValue.arrayUnion([url])) { _ in
                        imageToBeAdded = nil
                        proofOfWork?.append(url)
                    }
                }
            }
        }
    }
}

struct ProofOfWork: View {
    @StateObject private var viewModel: ProofOfWorkModel

    init(task: Task) {
        _viewModel = StateObject(wrappedValue: ProofOfWorkModel(task: task))
    }

    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Header
            HStack {
                SectionHeader(title: "Proof of Work")

                if !RoleService.shared.isOwner {
                    Spacer()
                    // MARK: Button: Add Photo
                    Button {
                        viewModel.isImagePickerPresenting.toggle()
                    } label: {
                        HStack {
                            Text("Add Photo")
                            Image(systemName: "camera")
                        }
                    }
                    .sheet(isPresented: $viewModel.isImagePickerPresenting) {
                        ImagePicker(sourceType: .camera) { image in
                            viewModel.imageToBeAdded = image
                            viewModel.saveChanges()
                        }
                    }
                }
            }
            // MARK: Pictures
            renderImages()
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 360)
            .background(AppColor.lightAccent)
            .cornerRadius(12)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColor.accent, lineWidth: 2)
            )
            .padding(2)
        }
    }

    @ViewBuilder
    private func renderImages() -> some View {
        if let imageToBeAdded = viewModel.imageToBeAdded {
            // MARK: Photo Preview
            Image(uiImage: imageToBeAdded)
                .resizable()
                .scaledToFill()
                .cornerRadius(12)
        } else if let proofOfWork = viewModel.proofOfWork {
            // MARK: Proof of Work
            Carousel(images: proofOfWork)
        } else {
            // MARK: Default Image
            Group {
                if RoleService.shared.isOwner {
                    Image("MonitoolAddPhotoIllustration")
                        .resizable()
                        .scaledToFit()
                } else {
                    Button {
                        viewModel.isImagePickerPresenting.toggle()
                    } label: {
                        Image("MonitoolAddPhotoIllustration")
                        .resizable()
                        .scaledToFit()
                    }
                }
            }.padding(36)
        }
    }
}
