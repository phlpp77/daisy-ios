//
//  MainChatView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainChatView: View {
    
    @State var showInformation: Bool = false
    
    var body: some View {
        
        
        ZStack {
            
            // MARK: List with chats available to the user
            ChatListView()
                .opacity(showInformation ? 0.1 : 1)
            
            // MARK: InformationCard which is shown on first use
            if showInformation {
                InformationCard(goToNextView: $showInformation, goToLastView: $showInformation, sliderArray: [InformationCardModel(headerText: "Chat Area", highlight: true, footerText: "", image: "chat", sfSymbol: "bubble.left.and.bubble.right.fill", buttonText: "OK!", subtext: "Here you can chat with the people you matched. You can dissolve a match or delete the whole event with a long-press on each chat.")])
            }
            
        }
        .onAppear {
            showInformation = true
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
