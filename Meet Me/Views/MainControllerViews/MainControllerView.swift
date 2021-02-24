//
//  MainControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainControllerView: View {
    
    @Binding var startProcessDone: Bool
    
    var body: some View {
        
        if startProcessDone {
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
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView(startProcessDone: .constant(true))
    }
}
