
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userRegistration:EnterViewJson
    
    var body: some View {
        VStack {
            if !userRegistration.fil.files.isEmpty  {
                VStack{
                    List(userRegistration.fil.files){ dat in
                        VStack{
                            Text(dat.taskName)
                        }
                    }
                }
            }
            else{
                List{
                    Text("ничего нет")
                   
                }.refreshable {
                    print("refresh")
                    userRegistration.getData()
                }
            }
        }
        .onAppear{
            print("OnAppear")
            print("\(userRegistration.userNameCONST)")
            userRegistration.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
