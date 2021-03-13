//
//  MainChatView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainChatView: View {
    
    
    
    var body: some View {
        
        
            VStack {
                
                HeaderView(text1: "Chat ", text2: " Area", highlightText: "ME")
                
                // MARK: List with chats available to the user
                ChatListView()
            }
        
        
    }
}

struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            MainChatView()
        }
    }
}
