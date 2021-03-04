//
//  ChatListView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct ChatListView: View {
    
    @ObservedObject var chatListVM: ChatListViewModel = ChatListViewModel()
    
    
    @State var chatTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                
                ScrollView {
                    ForEach(chatListVM.matches.indices, id: \.self) { matchNumber in
                        
                        VStack {
                            
                            Color.clear
                            
                            NavigationLink(
                                
                                destination: MessagesView(chatId: $chatListVM.matches[matchNumber].chatId),
                                isActive: $chatTapped
                            )
                            {
                                ChatListRowView(user: $chatListVM.matches[matchNumber].user, event: $chatListVM.matches[matchNumber].event, chatTapped: $chatTapped)
                            }
                            
                            
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }.onAppear {
            chatListVM.getMatches()
        }
        
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
