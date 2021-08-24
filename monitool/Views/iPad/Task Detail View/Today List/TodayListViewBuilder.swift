//
//  TodayListView+ViewBuilders.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - View Builders
extension TodayListView {
    @ViewBuilder func LeftColumn() -> some View {
        VStack(alignment: .leading) {
            Text(todayListViewModel.task.name)
                .font(.system(size: 28, weight: .bold))
            if let image = todayListViewModel.task.photoReference {
                WebImage(url: URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 400)
            } else {
                Image("MonitoolEmptyReferenceIllus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 400)
            }
            if let desc = todayListViewModel.task.desc {
                Text(desc)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    @ViewBuilder func RightColumn() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Proof of Work")
                .padding(.top, 10)
                .font(.system(size: 20, weight: .bold))
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
                .foregroundColor(Color(hex: "898989"))
            
            ProofOfWork(image: "MonitoolAddPhotoIllustration", date: "p")
                .padding(.vertical, 10)
                .background(Color(hex: "F0F9F8"))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
                )
            
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
