
import SwiftUI

struct ItemView: View {
    @State var item:userData
    
    @Binding var showInfo:Bool
    var body: some View {
        
        HStack{
            
            VStack{
                
                Text(item.taskName)
                    .foregroundColor(Color("light"))
                    .font(.system(size:25))
                    .fontWeight(.black)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .strikethrough(item.doneOrNot, color: .red)

                    
                HStack{
                    Image(systemName: item.tagsImg)
                    Text(item.tags)
                     
                }.foregroundColor(Color("\(item.priority)"))
                
                
            }
            Spacer()
            Button{
                showInfo.toggle()
            }label: {
                Text("\(item.creationDate.formatted(date: .omitted, time: .shortened))")
                .padding()
                .border(Color("light"), width: 4)
            }
                
                
        }
        
    }
}
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: .init(taskName: "Task 1", creationDate: Date(), priority: "High", tags: "Project", notes: "Some notes", doneOrNot: false, tagsImg: "folder"), showInfo: .constant(false))
    }
}
