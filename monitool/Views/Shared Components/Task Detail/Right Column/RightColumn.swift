//
//  RightColumn.swift
//  monitool
//
//  Created by Christianto Budisaputra on 25/08/21.
//

import SwiftUI

struct ActivityLog {
    let id = UUID()
    let title: String
    let timestamp: String
}

protocol RightColumnViewModel: ObservableObject {
    var comment: String { get }
    var commentTextField: String { get set }
    var pic: Employee? { get set }
    var notes: String { get }
    var notesTextField: String { get set }
    var employees: [Employee] { get }
    var imageToBeAdded: UIImage? { get set }
    var proofOfWork: [String]? { get set }
    var logs: [ActivityLog] { get set }
    var isEmployeePickerPresenting: Bool { get set }
    var picSelection: Int { get set }
    var isImagePickerPresenting: Bool { get set }
    var reviewer: [Employee] { get set }
    var company: Company? { get set }
}

struct RightColumn<Model>: View where Model: RightColumnViewModel {
    @StateObject private var viewModel: Model

    private let components: [Component]

    init(components: [Component], viewModel: Model) {
        self.components = components
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 24) {
            renderComponents()
        }
    }

    @ViewBuilder
    private func renderComponents() -> some View {
        if components.contains(.proofOfWork) {
//            renderProofOfWork()
        }
        if components.contains(.picSelector) {
            renderPICSelector()
        }
        VStack(alignment: .leading, spacing: 12) {
            if components.contains(.picText) {
                renderPICText()
            }
            if components.contains(.notesText) {
                renderNotesText()
            }
        }
		if components.contains(.commentText) {
			renderCommentText()
		}
		if components.contains(.notesTextField) {
			renderNotesTextField()
		}
        if components.contains(.reviewStatus) {
            renderReviewStatus()
        }
        if components.contains(.commentTextField) {
            renderCommentTextField()
        }
        if components.contains(.logs) {
            renderLogs()
        }

        EmptyView()
    }
}

extension RightColumn {
    enum Component: String {
        case proofOfWork,
             picSelector,
             notesTextField,
             picText,
             notesText,
             reviewStatus,
             commentText,
             commentTextField,
             logs
    }

    @ViewBuilder private func sectionHeader(title: String) -> some View {
        Text(title).foregroundColor(.gray).font(.title3).bold()
    }

    @ViewBuilder private func renderLogs() -> some View {
        VStack(alignment: .leading) {
            sectionHeader(title: "Logs")

            ScrollView(.vertical) {
                if viewModel.logs.count > 0 {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.logs, id: \.id) { log in
                            HStack {
                                Text(log.title)
                                Spacer()
                                Text(log.timestamp)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                } else {
                    Text("There hasn't been anything going on.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .padding()
            .frame(height: 120, alignment: .topLeading)
            .background(AppColor.lightAccent)
            .modifier(
                RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8)
            )
        }
    }

    @ViewBuilder private func renderCommentText() -> some View {
        HStack {
            sectionHeader(title: "Comment: ")
            Text(viewModel.comment)
        }
    }

    @ViewBuilder private func renderCommentTextField() -> some View {
        VStack(alignment: .leading) {
            sectionHeader(title: "Comment")

            TextField("Type your comment here...", text: $viewModel.commentTextField)
                .padding()
                .frame(minHeight: 100, alignment: .topLeading)
                .background(AppColor.lightAccent)
                .modifier(
                    RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8)
                )
        }
    }

    @ViewBuilder private func renderPICText() -> some View {
        HStack {
            sectionHeader(title: "PIC: ")
            Text(viewModel.pic?.name ?? "-").font(.headline)
        }
    }

    @ViewBuilder private func renderNotesText() -> some View {
        HStack {
            sectionHeader(title: "Notes: ")
            Text(viewModel.notes)
        }
    }

    @ViewBuilder private func renderReviewStatus() -> some View {
        if let company = viewModel.company, company.minReview > 0 {
            ReviewStatus(currentReviewer: viewModel.reviewer.count, minReviewer: company.minReview)
        } else {
            VStack(alignment: .leading) {
                sectionHeader(title: "Review Status")
                Text("No review policy, yet. Set minimum task reviewer from the profile tab.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                    .background(AppColor.lightAccent)
                    .modifier(
                        RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8)
                    )
            }
        }
    }

    @ViewBuilder private func renderNotesTextField() -> some View {
        VStack(alignment: .leading) {
            sectionHeader(title: "Notes")

            TextField("Add notes here", text: $viewModel.notesTextField)
                .padding()
                .frame(minHeight: 100, alignment: .topLeading)
                .background(AppColor.lightAccent)
                .modifier(
                    RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8)
                )
        }
    }

    private var employeePicker: some View {
        let employees = EmployeeRepository.shared.employees

        return VStack(spacing: -36) {
            HStack {
                Button("Cancel") {
                    viewModel.isEmployeePickerPresenting.toggle()
                }.foregroundColor(AppColor.accent)
                Spacer()
                Text("PIC")
                Spacer()
                Button("Done") {
                    viewModel.isEmployeePickerPresenting.toggle()
                }.foregroundColor(AppColor.accent)
            }
            .padding()
            .zIndex(1)

            Picker("PIC", selection: $viewModel.picSelection) {
                ForEach(0 ..< employees.count) { index in
                    Text(employees[index].name).tag(index)
                }
            }
        }
    }

    @ViewBuilder private func renderPICSelector() -> some View {
        VStack(alignment: .leading) {
            sectionHeader(title: "PIC")

            Group {
                if viewModel.employees.count > 0 {
                    HStack {
                        Text(viewModel.employees[viewModel.picSelection].name)
                        Spacer()
                        Button {
                            viewModel.isEmployeePickerPresenting.toggle()
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.gray)
                        .popover(isPresented: $viewModel.isEmployeePickerPresenting) {
                            employeePicker
                        }
                    }
                } else {
                    Text("You currently have no employee registered.")
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()
            .background(AppColor.lightAccent)
            .modifier(
                RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8)
            )
        }
    }

    private var imagePicker: some View {
        ImagePicker(sourceType: .camera) { image in
            viewModel.imageToBeAdded = image
//            viewModel.saveChanges()
        }
    }
}

class MyViewModel: RightColumnViewModel {
    var company: Company? = Company(name: "Monitool", minReview: 0, ownerPin: "1234", hasLoggedIn: true, profileImage: nil)

    var reviewer: [Employee] = []

    func saveChanges() {
        print("Hehe")
    }

    @Published var isImagePickerPresenting: Bool = false

    @Published var picSelection: Int = 0

    @Published var isEmployeePickerPresenting: Bool = false

    @Published var commentTextField = ""

    @Published var notesTextField = ""

    @Published var logs: [ActivityLog] = [
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59"),
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59"),
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59"),
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59"),
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59"),
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59"),
        ActivityLog(title: "Submitted by Mawar", timestamp: "21 Jul 2021 at 15:59")
    ]

    @Published var comment = "No comment"

    @Published var pic: Employee? = Employee(name: "Andre")

    @Published var notes = "This is a note."

    @Published var employees: [Employee] = []

    @Published var imageToBeAdded: UIImage?

    @Published var proofOfWork: [String]?
}

struct RightColumn_Previews: PreviewProvider {
    static var previews: some View {
        RightColumn<MyViewModel>(components: [
//            .proofOfWork,
            .commentText,
            .commentTextField,
            .notesText,
            .notesTextField,
            .picText,
            .picSelector,
            .reviewStatus,
            .logs
        ], viewModel: MyViewModel())
        .padding()
        .previewLayout(.fixed(width: 400, height: 1200))
    }
}
