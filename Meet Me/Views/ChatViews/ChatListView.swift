//
//  ChatListView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct ChatListView: View {
    
    @ObservedObject var chatListVM: ChatListViewModel = ChatListViewModel()
    
    //@State var matches: [AllMatchInformationModel] = [AllMatchInformationModel(chatId: "egal", user: stockUser, event: stockEvent)]
    
    @State var chatTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            
            // chatListView is not created when there is no match
            if !chatListVM.matches.isEmpty {
                NavigationView {
                    ScrollView {
                        ForEach(chatListVM.matches.indices, id: \.self) { matchNumber in
                            
                            VStack {
                                
                                Color.clear
                                
                                NavigationLink(
                                    
                                    destination: MessagesView(match: $chatListVM.matches[matchNumber]),
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
            } else {
                Text("Drag Events and Match!")
            }
            
        }
        .onAppear {
            chatListVM.getMatches()
        }
        
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
