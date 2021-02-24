//
//  MainControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI
import FirebaseAuth

struct MainControllerView: View {
    
    @Binding var startProcessDone: Bool
    
    var body: some View {
        
        if startProcessDone ||  checkUserAccForAutoLogin() {
            TabView {
                MainSettingsView(startProcessDone: $startProcessDone).tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                
                MainExploreView().tabItem {
                    Image(systemName: "circle.dashed")
                    Text("Marketplace")
                }
                
                MainChatView().tabItem {
                    Image(systemName: "paperplane.circle")
                    Text("Chats")
                }
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
        MainControllerView(startProcessDone: .constant(true))
    }
}
