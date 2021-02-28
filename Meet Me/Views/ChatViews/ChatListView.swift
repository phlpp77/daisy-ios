//
//  ChatListView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct ChatListView: View {
    
    @StateObject var chatListVM: ChatListViewModel = ChatListViewModel()
    
    
    @State var matches: [AllMatchInformationModel] = [AllMatchInformationModel(chatId: "egal", user: stockUser, event: stockEvent), AllMatchInformationModel(chatId: "egal", user: stockUser2, event: stockEvent2)]
    
    @State var chatTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                
                ScrollView {
                    ForEach(chatListVM.matches.indices) { matchNumber in
                        
                        VStack {
                            
                            Color.clear
                            
                            NavigationLink(
                                destination: MessagesView(chatId: $matches[matchNumber].chatId),
                                isActive: $chatTapped
                            )
                                {
                                ChatListRowView(user: $matches[matchNumber].user, event: $matches[matchNumber].event, chatTapped: $chatTapped)
                            }
                            
                            
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }.onAppear {
            chatListVM.getMatches()
            print("getMatches aufgerufen")
        }
        
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
