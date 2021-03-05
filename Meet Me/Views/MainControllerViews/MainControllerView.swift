//
//  MainControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI
import FirebaseAuth

struct MainControllerView: View {
    
    @State var startProcessDone: Bool = false
    @State var startTab = 2
    
    var body: some View {
        
        // shows the main screen if the startProcess (user-creation) is done AND logged into firebase
        if startProcessDone || checkUserAccForAutoLogin() {
            TabView(selection: $startTab) {
                MainSettingsView(startProcessDone: $startProcessDone).tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                .tag(1)
                
                MainExploreView().tabItem {
                    Image(systemName: "circle.dashed")
                    Text("Marketplace")
                }
                .tag(2)
                
                MainChatView().tabItem {
                    Image(systemName: "paperplane.circle")
                    Text("Chats")
                }
                .tag(3)
            }
        } else {
            StartView(startProcessDone: $startProcessDone)
        }
        
    }
    
    func checkUserAccForAutoLogin() -> Bool{
        if Auth.auth().currentUser != nil{
            return true
            
        } else {
            return false

        }
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}
