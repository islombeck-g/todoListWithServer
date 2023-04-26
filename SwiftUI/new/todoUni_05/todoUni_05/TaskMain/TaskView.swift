
import SwiftUI

struct TaskView: View {
    @Binding public var path:NavigationPath
    
    @State private var showInfo:Bool = false
    
    var data:arrayOfData = arrayOfData(files: [
        userData(id: 1,
                 user_id: 2,
                 taskName: "Курсовая работа",
                 creationDate: Date()+10560,
                 priority: "r",
                 tags: "University",
                 notes: "до 23 мая нужно сдать все документы",
                 doneOrNot: true,
                 tagsImg:"graduationcap"),
        userData(id: 2,
                 user_id: 2,
                 taskName: "помыть посуду",
                 creationDate: Date(),
                 priority: "o",
                 tags: "Home",
                 notes: "Somчмчсмясчмясчмумдлроукдмкоуишмытукшзмгфыитмофимшгфукитзмшукфтишмфтe notes",
                 doneOrNot: false,
                 tagsImg:"house"),
        userData(id: 2,
                 user_id: 2,
                 taskName: "Прочитать новую главу",
                 creationDate: Date(),
                 priority: "g",
                 tags: "Health",
                 notes: "aldkfnaskfa notes",
                 doneOrNot: false,
                 tagsImg:"bolt.heart"),
        userData(id: 2,user_id: 2,
                 taskName: "написать Тимуру",
                 creationDate: Date(),
                 priority: "g",
                 tags: "Work",
                 notes: "asldkfjakdfjadf notes",
                 doneOrNot: false,
                 tagsImg:"briefcase"),
        userData(id: 2,
                 user_id: 2,
                 taskName: "отработать последнее занятие",
                 creationDate: Date()+1543,
                 priority: "o",
                 tags: "Sport",
                 notes: "не забыть зачётную книжку",
                 doneOrNot: false,
                 tagsImg:"dumbbell")])
    
    
    var body: some View {
        ZStack{
            VStack{
                Text("Напоминания")
                    .foregroundColor(Color("light"))
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.top, 10)
                    .padding(.leading, -90)
                
                List{
                    Section(
                        header: Text("следующие 24 часа")
                            .foregroundColor(Color("dark"))
                    ){
                        ForEach(data.files, id: \.self){item in
                            if item.creationDate <= Date()+1440 && item.doneOrNot == false{
                                ItemView(item: item, showInfo: $showInfo)
                                    .sheet(isPresented: $showInfo){
                                        SheetView(item: item, showSheetView: $showInfo)
                                            .presentationDetents([.medium, .large])
                                    }

                            }
                        }
                    }
                    
                    
                    Section(
                        header: Text("другая дата")
                            .foregroundColor(Color("dark"))
                    ){
                        ForEach(data.files, id: \.self){item in
                            if item.creationDate >= Date()+1440 && item.doneOrNot == false{
                                ItemView(item: item, showInfo: $showInfo)
                                    .sheet(isPresented: $showInfo){
                                        SheetView(item: item, showSheetView: $showInfo)
                                            .presentationDetents([.medium, .large])
                                    }
                            }
                           
                        }
                    }

                    
                    Section(
                        header: Text("выполненные")
                            .foregroundColor(Color("dark"))
                    ){
                        ForEach(data.files, id: \.self){item in
                            if item.doneOrNot == true{
                                ItemView(item: item, showInfo: $showInfo)
                                    .sheet(isPresented: $showInfo){
                                        SheetView(item: item, showSheetView: $showInfo)
                                            .presentationDetents([.medium, .large])
                                    }
                            }
                           
                        }
                    }

                   
                    
                }.listStyle(.plain)
                    
                
                
                Spacer()
            }
            GeometryReader{ geometry in
                Group{
                    Rectangle()
                        .fill(Color("dark"))
                        .frame(width: 180, height: 60)
                        .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15  ))
                    
                    Button{
                        path.append("Напоминания")
                    }label: {
                        Label("Напоминание", systemImage: "plus")
                            .foregroundColor(.white)
                    }
                    
                   
                }.position(x: geometry.size.width-80, y: geometry.size.height-60)
                
                Group{
                    Rectangle()
                        .fill(Color("dark"))
                        .frame(width: 60, height: 60)
                        .modifier(RoundedCorner(corners: [.topRight, .bottomRight], radius: 15  ))
                    Button{
                        path.append("Фокусирование")
                    }label: {
                        Image(systemName: "timer")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                    
                    
                }.position(x: geometry.size.width-geometry.size.width+20, y: geometry.size.height-60)
                
            }
            
        }
        .navigationBarBackButtonHidden()
        }
    }


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(path: .constant(NavigationPath()))
    }
}


//
//{
//    ForEach(emptyArrayOfData.dataFromSQL.files.indices, id: \.self) { index in
//        let data = $emptyArrayOfData.dataFromSQL.files[index]
//        HStack{
//            Button{
//                if data.doneOrNot.wrappedValue == true{
//                    data.doneOrNot.wrappedValue = false
//                }else{
//                    data.doneOrNot.wrappedValue = true
//                }
////                                        $emptyArrayOfData.files[index] = data // Update the original array with the modified element
//            } label: {
//                if data.doneOrNot.wrappedValue == false {
//                    Image(systemName: "circle")
//                        .foregroundColor(Color("dark"))
//                } else {
//                    Image(systemName: "circle.fill")
//                        .foregroundColor(Color("dark"))
//                }
//            }
//            VStack(alignment: .leading) {
//                Text(data.taskName.wrappedValue)
//                    .foregroundColor(Color("light"))
//                    .font(.system(size:25))
//                    .fontWeight(.black)
//                    .lineLimit(1)
//                    .multilineTextAlignment(.leading)
//                HStack{
//                    Image(systemName: data.tagsImg.wrappedValue)
//                    Text(data.tags.wrappedValue)
//                }
//
//                Text("Notes: \(data.notes.wrappedValue)")
//            }
//            .padding(.vertical, 8)
//            Spacer()
//            VStack{
//                Text(dateTostring(dat: data.creationDate.wrappedValue))
//                    .frame(width: 100, height: 50)
//                    .border(Color("light"), width: 2)
//                    .foregroundColor(Color("light"))
//            }
//        }
//
//    }
//    .onDelete(perform: deleteTask)
//
//}





//
//
//if !showAddView && !showFocuseView && !showTaskInfoView
//{
//    GeometryReader{ geometry in
//        Group{
//            Rectangle()
//                .fill(Color("dark"))
//                .frame(width: 180, height: 60)
//                .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15  ))
//
//            NavigationLink{
//                AddTaskView(model: AddDataJson(user: userRegistration.user))
//
//            }label: {
//                Label("Напоминание", systemImage: "plus")
//                    .foregroundColor(.white)
//
//            }
//        }.position(x: geometry.size.width-80, y: geometry.size.height-60)
//
//        Group{
//            Rectangle()
//                .fill(Color("dark"))
//                .frame(width: 60, height: 60)
//                .modifier(RoundedCorner(corners: [.topRight, .bottomRight], radius: 15  ))
//
//            NavigationLink{
//                FocuseView()
//                    .environmentObject(focuseModel)
//
//
//            }label: {
//                Image(systemName: "timer")
//                    .font(.system(size: 25))
//                    .foregroundColor(.white)
//
//            }
//            //                            .transition(.move(edge: .trailing)) it is not works
//        }.position(x: geometry.size.width-geometry.size.width+20, y: geometry.size.height-60)
//
//    }
//
//}




struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct RoundedCorner: ViewModifier {
    var corners: UIRectCorner
    var radius: CGFloat
    func body(content: Content) -> some View {
        content
            .clipShape( RoundedCornerShape(corners: corners, radius: radius))
    }
}
