//
//  TaskListDetailView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct TaskListDetailView: View {
    @State var taskTitle: String = ""
    @State var description: String = ""
    @State private var repeatPopover = false
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    @State var selectedDays: [String] = []
    @State var taskRepeated = [false, false, false, false, false, false, false]
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                        HStack(spacing: 70) {
                            Text("Title")
                            TextField("Buka Gerbang Toko", text: $taskTitle)
                        }
                        HStack(spacing: 16) {
                            Text("Description")
                            TextField("Input description here", text: $description)
                        }
                    HStack {
                        Button("Repeat") {
                            repeatPopover = true
                        }
                        .popover(isPresented: $repeatPopover) {
                            RepeatSheetView(repeated: $taskRepeated, selectedDays: $selectedDays).frame(width: 400, height: 400)
                        }
                        Spacer()
                        Button(action: {
                            repeatPopover = true
                        }) {
                            HStack() {
                                if selectedDays.count != 0 {
                                    if selectedDays.count == 7 {
                                        Text("Everyday")
                                    } else {
                                        ForEach(selectedDays, id:\.self) { day in
                                            Text(day)
                                        }
                                    }
                                }
                                Image(systemName: "chevron.right").foregroundColor(.gray)
                            }
                        }
                    }
                }.listStyle(DefaultListStyle())
                .frame(height: 200.0)
                NoSeparatorList{
                    VStack{
                        Text("Photo Reference").font(.title2).foregroundColor(.black).fontWeight(.semibold).padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                        Button(action: {
                            self.showImagePicker.toggle()
                            self.sourceType = .camera

                        }) {
                            Image("camera")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .padding(.leading)
                            
                        }
                            Spacer()
                        }.sheet(isPresented: $showImagePicker) {
                            ImagePicker(sourceType: self.sourceType) { image in
                                self.image = image
                            }
                        }
                    }
                }
            }.navigationTitle("Task List").navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TaskListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListDetailView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
