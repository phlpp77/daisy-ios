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
    @State var userIsLoggedIn: Bool = false
    @State var startTab = 2
    
    var body: some View {
        
        // shows the main screen if the startProcess (user-creation) is done OR logged into firebase
        VStack {
            if startProcessDone || userIsLoggedIn {
                TabBarView(startProcessDone: $startProcessDone)

            } else {
                MainStartView(startUpDone: $startProcessDone)
            }
        }
        .onAppear {
            checkUserAccForAutoLogin()
        }
        .onChange(of: startProcessDone, perform: { value in
            checkUserAccForAutoLogin()
        })
        
    }
    
    func checkUserAccForAutoLogin(){
        if Auth.auth().currentUser != nil{
            userIsLoggedIn = true
            
        } else {
            userIsLoggedIn = false

        }
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}


// --- OLD TABBAR
//            TabView(selection: $startTab) {
//                MainSettingsView(startProcessDone: $startProcessDone).tabItem {
//                    Image(systemName: "person.circle")
//                    Text("Profile")
//                }
//                .tag(1)
//
//                MainExploreView().tabItem {
//                    Image(systemName: "circle.dashed")
//                    Text("Marketplace")
//                }
//                .tag(2)
//
//                MainChatView().tabItem {
//                    Image(systemName: "paperplane.circle")
//                    Text("Chats")
//                }
//                .tag(3)
//            }
