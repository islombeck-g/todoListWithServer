
import SwiftUI

struct SheetView: View {
    @State var item:userData
    @Binding var showSheetView:Bool
    var body: some View {
        ZStack{
            Color("dark")
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("light"))
                .frame(width: 400, height: 300)
            VStack{
                Group{
                    HStack{
                        Text("Название:")
                        Spacer()
                        Text(item.taskName)
                    }
                    HStack{
                        Text("Время напоминания:")
                        Spacer()
                        Text("dateHere")
                    }
                    HStack{
                        Text("Приоритет:")
                        Spacer()
                        Group{
                            if item.priority == "g"{
                                Text("можно не париться")
                            }else if item.priority == "y"{
                                Text("как нибудь сделаем")
                            }else if item.priority == "o"{
                                Text("важно")
                            }else{
                                Text("очень важно")
                            }
                        }.foregroundColor(Color(item.priority))
                    }
                    HStack{
                        Text("Категория: ")
                        Spacer()
                        Image(systemName: item.tagsImg)
                        Text(item.tags)
                    }
                    HStack{
                        Text("Заметки: ")
                        Spacer()
                        Text(item.notes)
                    }
                    Spacer().frame(height: 40)
                    HStack{Spacer()
                        Button{
                            showSheetView.toggle()
                        }label: {
                                Label("Выполнено", systemImage: "dot.circle.and.hand.point.up.left.fill")
                                    .foregroundColor(.white)
                                    .padding(6)
                        }
                        .buttonStyle(.bordered)
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

//struct SheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetView(item: .init(taskName: "Task 1", creationDate: Date(), priority: "High", tags: "Project", notes: "Some notes", doneOrNot: false, tagsImg: "folder"), showSheetView: .constant(false))
//    }
//}
