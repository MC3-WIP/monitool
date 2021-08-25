//
//  TodayListView+ViewBuilders.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

// MARK: - View Builders

extension TodayListView {
    private var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Choose mode"),
            message: Text("Please choose your preferred mode to set your profile image"),
            buttons: [
                ActionSheet.Button.default(Text("Camera")) {
                    self.showImagePicker.toggle()
                    self.sourceType = .camera
                },
                ActionSheet.Button.cancel()
            ]
        )
    }

    private var imagePicker: some View {
        ImagePicker(sourceType: sourceType) { image in
            todayListViewModel.imageToBeAdded = image
            todayListViewModel.update()
        }
    }
    
    @ViewBuilder func LeftColumn() -> some View {
        VStack(alignment: .leading) {
            Text(todayListViewModel.task.name)
                .font(.system(size: 28, weight: .bold))
            if let image = todayListViewModel.task.photoReference {
                WebImage(url: URL(string: image))
                    .resizable()
                    .placeholder(Image("MonitoolEmptyReferenceIllus"))
                    .indicator { _, _ in
                        ProgressView()
                    }
                    .transition(.fade)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("MonitoolEmptyReferenceIllus")
                    .resizable()
                    .scaledToFit()
            }
            if let desc = todayListViewModel.task.desc {
                Text(desc)
                    .font(.system(size: 17))
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
    @ViewBuilder func RightColumn() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            // MARK: - Proof of Work
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Proof of Work")
                        .padding(.bottom, 8)
                        .font(.system(size: 20, weight: .bold))
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
                        .foregroundColor(Color(hex: "898989"))
                    Spacer()
                    if !role.isOwner {
                        Button {
                            self.showActionSheet.toggle()
                        } label: {
                            HStack(alignment: .lastTextBaseline) {
                                Text(todayListViewModel.imageToBeAdded != nil ? "Retake" : "Add Photo")
                                Image(systemName: "camera")
                            }
                        }
                        .sheet(isPresented: $showImagePicker) { imagePicker }
                        .actionSheet(isPresented: $showActionSheet) { actionSheet }
                    }
                }
                proofOfWork()
            }
            // MARK: - Setelah Proof of Work
            if role.isOwner {
                CustomText(title: "PIC: ", content: todayListViewModel.pic?.name)
                CustomText(title: "Notes: ", content: todayListViewModel.task.notes)
            } else {
                PICSelector()
                NotesTextField()
                Button("Submit") {
                    todayListViewModel.submitTask(
                        pic: employeeRepository.employees[todayListViewModel.picSelection],
                        notes: todayListViewModel.notesText
                    )
                    presentationMode.wrappedValue.dismiss()
                }.buttonStyle(PrimaryButtonStyle())
            }
        }
    }
    
    @ViewBuilder func proofOfWork() -> some View {
        if let imageToBeAdded = todayListViewModel.imageToBeAdded {
            Image(uiImage: imageToBeAdded)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(12)
        } else if let proofOfWork = todayListViewModel.proofOfWork, proofOfWork.count > 0 {
            Carousel(images: todayListViewModel.task.proof)
        } else {
            Button {
                self.showActionSheet.toggle()
            } label: {
                Image("MonitoolAddPhotoIllustration")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(36)
            }
            .sheet(isPresented: $showImagePicker) { imagePicker }
            .actionSheet(isPresented: $showActionSheet) { actionSheet }
        }
    }
    
    @ViewBuilder func EmployeePicker() -> some View {
        VStack(spacing: -36) {
            HStack {
                Button("Cancel") {
                    todayListViewModel.isEmployeePickerPresenting = false
                }.foregroundColor(AppColor.accent)
                Spacer()
                Text("PIC")
                Spacer()
                Button {
                    todayListViewModel.isEmployeePickerPresenting = false
                } label: {
                    Text("Done").bold()
                }.foregroundColor(AppColor.accent)
            }
            .padding()
            .zIndex(1)
            
            Picker("PIC", selection: $todayListViewModel.picSelection) {
                ForEach(0..<employeeRepository.employees.count) { index in
                    Text(employeeRepository.employees[index].name).tag(index)
                }
            }
        }
    }
    
    @ViewBuilder func PICSelector() -> some View {
        VStack(alignment: .leading) {
            Text("PIC")
                .font(.title2)
                .foregroundColor(.secondary)
                .bold()
            HStack {
                Text(employeeRepository.employees[todayListViewModel.picSelection].name)
                Spacer()
                Button {
                    todayListViewModel.isEmployeePickerPresenting = true
                } label: {
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.secondary)
                .popover(isPresented: $todayListViewModel.isEmployeePickerPresenting) {
                    EmployeePicker()
                }
            }
            .padding()
            .background(AppColor.accent.brightness(0.65))
            .modifier(RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8))
        }
    }
    
    @ViewBuilder func NotesTextField() -> some View {
        VStack(alignment: .leading) {
            Text("Notes")
                .font(.title2)
                .foregroundColor(.secondary)
                .bold()
            TextField("Add notes here", text: $todayListViewModel.notesText)
                .padding()
                .frame(height: 120, alignment: .top)
                .background(Color(hex: "F0F9F8"))
                .modifier(RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8))
                .zIndex(1)
        }
    }
    
    @ViewBuilder func CustomText(title: String, content: String?) -> some View {
        HStack {
            Text(title)
                .foregroundColor(Color(hex: "6C6C6C"))
                .font(.system(size: 17, weight: .bold))
            Text(content ?? "-")
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder func ProofOfWork(image: String, date: String) -> some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 400)
        }
    }
}
