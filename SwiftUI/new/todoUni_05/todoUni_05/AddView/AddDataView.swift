//
//  AddDataView.swift
//  todoUni_05
//
//  Created by Islombek Gofurov on 14.04.2023.
//

import SwiftUI

struct AddDataView: View {
    @Environment(\.presentationMode) var presentationMode
        @State private var taskName:String = ""
        @State private var taskDesc:String = ""
        @State private var taskDate:Date = .init()
        let elems = ["Project", "Work", "Movie", "Music", "Health", "Home", "Sport", "University"]
        let pictOfElems = ["folder", "briefcase", "popcorn","music.note.list", "bolt.heart","house","dumbbell","graduationcap"]
        @State private var selectedCategory: String? = nil
        @State private var selectedPriority: String? = nil
        @State private var selectedCategoryImg:String? = nil
        var body: some View {
            ZStack{
                VStack{
                    VStack(alignment: .leading, spacing: 10.0){
                        Text("Новое напоминание")
                            .font(.largeTitle)
                            .fontWeight(.black)
                        Group{
                            Text("Название")
                            TextField("Введите название", text: $taskName)
                                .padding(13)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("light"), lineWidth: 1.5)
                                )
                        }
                        Group{
                            Text("Напомни мне")
    
                            ZStack{
                                Image(systemName: "alarm.waves.left.and.right")
                                    .padding(.leading, -165.0)
                                    .font(.title)
                                DatePicker("", selection: $taskDate, in:Date()...)
                            }
                        }
                        Group{
                            Text("Приоритет")
                            HStack{
                                Button{
                                    self.selectedPriority = "g"
                                }label: {
                                    Circle()
                                        .fill(.green)
                                        .frame(width: self.selectedPriority == "g" ? 30 : 25, height: self.selectedPriority == "g" ? 30 : 25, alignment: .center)
                                }
                                Button{
                                    self.selectedPriority = "y"
                                }label: {
                                    Circle()
                                        .fill(.yellow)
                                        .frame(width: self.selectedPriority == "y" ? 30 : 25, height: self.selectedPriority == "y" ? 30 : 25, alignment: .center)
                                }
                                Button{
                                    self.selectedPriority = "o"
                                }label: {
                                    Circle()
                                        .fill(.orange)
                                        .frame(width: self.selectedPriority == "o" ? 30 : 25, height: self.selectedPriority == "o" ? 30 : 25, alignment: .center)
                                }
                                Button{
                                    self.selectedPriority = "r"
                                }label: {
                                    Circle()
                                        .fill(.red)
                                        .frame(width: self.selectedPriority == "r" ? 30 : 25, height: self.selectedPriority == "r" ? 30 : 25, alignment: .center)
                                }
                            }
                        }
                        Group{
                            Text("Категории")
                            VStack{
                                HStack{
                                    ForEach(0..<3) { index in
                                        Button{
                                            self.selectedCategory = self.elems[index]
                                            self.selectedCategoryImg = self.pictOfElems[index]
                                        }label: {
                                            HStack{
                                                Image(systemName: pictOfElems[index])
                                                Text(self.elems[index])
                                            }
                                            .frame(width: 100, height: 50)
                                            .background(self.selectedCategory == self.elems[index] ? Color("light") : Color.white)
                                            .foregroundColor(self.selectedCategory == self.elems[index] ? Color.white : Color.gray)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                HStack{
                                    ForEach(3..<6) { index in
                                        Button {
                                            self.selectedCategory = self.elems[index]
                                            self.selectedCategoryImg = self.pictOfElems[index]
                                        }label: {
                                            HStack{
                                                Image(systemName: pictOfElems[index])
                                                Text(self.elems[index])
                                            }
                                            .frame(width: 100, height: 50)
                                            .background(self.selectedCategory == self.elems[index] ? Color("light") : Color.white)
                                            .foregroundColor(self.selectedCategory == self.elems[index] ? Color.white : Color.gray)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                HStack {
                                    ForEach(6..<8) { index in
                                        Button(action: {
                                            self.selectedCategory = self.elems[index]
                                            self.selectedCategoryImg = self.pictOfElems[index]
                                        }) {
                                            HStack{
                                                Image(systemName: pictOfElems[index])
                                                Text(self.elems[index])
                                            }
                                            .frame(width: 125, height: 50)
                                            .background(self.selectedCategory == self.elems[index] ? Color("light") : Color.white)
                                            .foregroundColor(self.selectedCategory == self.elems[index] ? Color.white : Color.gray)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                        }
                        Text("Заметки")
                        TextField("Введите заметку", text: $taskDesc)
                            .padding(13)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("light"), lineWidth: 1.5)
                            )
                    }
                    .padding(.horizontal, 30)
                    .foregroundColor(Color("light"))
                    Spacer()
    
                    }.ignoresSafeArea()
                    .padding(.top, 40)
    //                    .padding(.bottom, -34)
    
                GeometryReader{ geometry in
                    Group{
                        Rectangle()
                            .fill(Color("dark"))
                            .frame(width: 130, height: 60)
                            .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15  ))
                        Button{
                            if !taskName.isEmpty{
                                
                                print("data added succsessfully")
                            }
                            else{
                                print("error dataAdd in AddTaskView-islam")
                            }
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                            Label("добавить", systemImage: "plus")
                                .foregroundColor(.white)
    
                        }
                    }.position(x: geometry.size.width-60, y: geometry.size.height-60)
                }
                .navigationBarBackButtonHidden(true)
                }
    
            }
        }

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}


//
//
//import SwiftUI
//
//struct AddTaskView: View {
//    
//    @StateObject var model: AddDataJson
//    @Environment(\.presentationMode) var presentationMode
//    @State private var taskName:String = ""
//    @State private var taskDesc:String = ""
//    @State private var taskDate:Date = .init()
//    let elems = ["Project", "Work", "Movie", "Music", "Health", "Home", "Sport", "University"]
//    let pictOfElems = ["folder", "briefcase", "popcorn","music.note.list", "bolt.heart","house","dumbbell","graduationcap"]
//    @State private var selectedCategory: String? = nil
//    @State private var selectedPriority: String? = nil
//    @State private var selectedCategoryImg:String? = nil
//    var body: some View {
//        ZStack{
//            VStack{
//                VStack(alignment: .leading, spacing: 10.0){
//                    Text("New Task")
//                        .font(.largeTitle)
//                        .fontWeight(.black)
//                    Group{
//                        Text("Name")
//                        TextField("EnterTaskName", text: $taskName)
//                            .padding(13)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color("light"), lineWidth: 1.5)
//                            )
//                    }
//                    Group{
//                        Text("Remind me")
//                        
//                        ZStack{
//                            Image(systemName: "alarm.waves.left.and.right")
//                                .padding(.leading, -165.0)
//                                .font(.title)
//                            DatePicker("", selection: $taskDate, in:Date()...)
//                        }
//                    }
//                    Group{
//                        Text("Priority")
//                        HStack{
//                            Button{
//                                self.selectedPriority = "g"
//                            }label: {
//                                Circle()
//                                    .fill(.green)
//                                    .frame(width: self.selectedPriority == "g" ? 30 : 25, height: self.selectedPriority == "g" ? 30 : 25, alignment: .center)
//                            }
//                            Button{
//                                self.selectedPriority = "y"
//                            }label: {
//                                Circle()
//                                    .fill(.yellow)
//                                    .frame(width: self.selectedPriority == "y" ? 30 : 25, height: self.selectedPriority == "y" ? 30 : 25, alignment: .center)
//                            }
//                            Button{
//                                self.selectedPriority = "o"
//                            }label: {
//                                Circle()
//                                    .fill(.orange)
//                                    .frame(width: self.selectedPriority == "o" ? 30 : 25, height: self.selectedPriority == "o" ? 30 : 25, alignment: .center)
//                            }
//                            Button{
//                                self.selectedPriority = "r"
//                            }label: {
//                                Circle()
//                                    .fill(.red)
//                                    .frame(width: self.selectedPriority == "r" ? 30 : 25, height: self.selectedPriority == "r" ? 30 : 25, alignment: .center)
//                            }
//                        }
//                    }
//                    Group{
//                        Text("Tags")
//                        VStack{
//                            HStack{
//                                ForEach(0..<3) { index in
//                                    Button{
//                                        self.selectedCategory = self.elems[index]
//                                        self.selectedCategoryImg = self.pictOfElems[index]
//                                    }label: {
//                                        HStack{
//                                            Image(systemName: pictOfElems[index])
//                                            Text(self.elems[index])
//                                        }
//                                        .frame(width: 100, height: 50)
//                                        .background(self.selectedCategory == self.elems[index] ? Color("light") : Color.white)
//                                        .foregroundColor(self.selectedCategory == self.elems[index] ? Color.white : Color.gray)
//                                        .cornerRadius(10)
//                                    }
//                                }
//                            }
//                            HStack{
//                                ForEach(3..<6) { index in
//                                    Button {
//                                        self.selectedCategory = self.elems[index]
//                                        self.selectedCategoryImg = self.pictOfElems[index]
//                                    }label: {
//                                        HStack{
//                                            Image(systemName: pictOfElems[index])
//                                            Text(self.elems[index])
//                                        }
//                                        .frame(width: 100, height: 50)
//                                        .background(self.selectedCategory == self.elems[index] ? Color("light") : Color.white)
//                                        .foregroundColor(self.selectedCategory == self.elems[index] ? Color.white : Color.gray)
//                                        .cornerRadius(10)
//                                    }
//                                }
//                            }
//                            HStack {
//                                ForEach(6..<8) { index in
//                                    Button(action: {
//                                        self.selectedCategory = self.elems[index]
//                                        self.selectedCategoryImg = self.pictOfElems[index]
//                                    }) {
//                                        HStack{
//                                            Image(systemName: pictOfElems[index])
//                                            Text(self.elems[index])
//                                        }
//                                        .frame(width: 125, height: 50)
//                                        .background(self.selectedCategory == self.elems[index] ? Color("light") : Color.white)
//                                        .foregroundColor(self.selectedCategory == self.elems[index] ? Color.white : Color.gray)
//                                        .cornerRadius(10)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    Text("Note")
//                    TextField("EnterTaskDesc", text: $taskDesc)
//                        .padding(13)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color("light"), lineWidth: 1.5)
//                        )
//                }
//                .padding(.horizontal, 30)
//                .foregroundColor(Color("light"))
//                Spacer()
//                
//                }.ignoresSafeArea()
//                .padding(.top, 40)
////                    .padding(.bottom, -34)
//
//            GeometryReader{ geometry in
//                Group{
//                    Rectangle()
//                        .fill(Color("dark"))
//                        .frame(width: 130, height: 60)
//                        .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15  ))
//                    Button{
//                        if !taskName.isEmpty{
//                            self.model.userData.taskName = taskName
//                            self.model.userData.creationDate = taskDate
//                            self.model.userData.priority = selectedPriority!
//                            self.model.userData.tags = selectedCategory!
//                            self.model.userData.notes = taskDesc
//                            self.model.userData.doneOrNot = false
//                            self.model.userData.tagsImg = selectedCategoryImg!
//                            self.model.addToSQL()
//                            print("data added succsessfully")
//                        }
//                        else{
//                            print("error dataAdd in AddTaskView-islam")
//                        }
//                        presentationMode.wrappedValue.dismiss()
//                    }label: {
//                        Label("добавить", systemImage: "plus")
//                            .foregroundColor(.white)
//                        
//                    }
//                }.position(x: geometry.size.width-60, y: geometry.size.height-60)
//            }
//            .navigationBarBackButtonHidden(true)
//            }
//          
//        }
//    }
//
////
////struct AddTaskView_Previews: PreviewProvider {
////    static var previews: some View {
////        AddTaskView(model: <#AddDataJson#>)
////    }
////}
