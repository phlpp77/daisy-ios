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
                    ForEach(matches.indices) { matchNumber in
                        
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {matches = chatListVM.matches
                print(matches)
                print(chatListVM.matches)
            })
            print("getMatches aufgerufen")
        }
        
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
