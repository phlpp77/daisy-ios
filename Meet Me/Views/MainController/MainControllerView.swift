//
//  MainControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainControllerView: View {
    var body: some View {
        TabView {
            MainSettingsView().tabItem {
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
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}
