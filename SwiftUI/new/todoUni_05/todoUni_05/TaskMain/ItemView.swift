
import SwiftUI

struct ItemView: View {
    @State var item:userData
    
    @Binding var showInfo:Bool
    var body: some View {
        
        HStack{
            
            VStack{
                HStack{
                    Text(item.taskName)
                        .foregroundColor(Color("light"))
                        .font(.system(size:25))
                        .fontWeight(.black)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .strikethrough((item.doneOrNot != 0), color: .red)
                    Spacer()
                }
               

                    
                HStack{
                    Image(systemName: item.tagsImg)
                    Text(item.tags)
                     Spacer()
                }.foregroundColor(Color("\(item.priority)"))
                
                
            }
            Spacer()
            Button{
                showInfo.toggle()
            }label: {
                Text("\(timeString(line:item.creationDate))")
                .padding()
                .border(Color("light"), width: 4)
            }
                
                
        }
        
    }
    func timeString(line:String)->String{
        var returnLine = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: line) else {
            return returnLine // Некорректный формат даты
        }
        let calendar = Calendar.current
        
        return "\(calendar.component(.hour, from: date)):\(calendar.component(.minute, from: date))"
    }
}
//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(item: .init(taskName: "Task 1", creationDate: DateString(), priority: "High", tags: "Project", notes: "Some notes", doneOrNot: false, tagsImg: "folder"), showInfo: .constant(false))
//    }
//}
