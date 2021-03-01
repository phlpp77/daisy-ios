//
//  ChatListView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct ChatListView: View {
    
    @ObservedObject var chatListVM: ChatListViewModel = ChatListViewModel()
    
    @State var matches: [AllMatchInformationModel] = [AllMatchInformationModel(chatId: "egal", user: stockUser, event: stockEvent)]
    
    @State var chatTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                
                ScrollView {
                    ForEach(matches.indices) { matchNumber in
                        
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
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                
                print("matches after 3 sec \(matches.count)")
                print(chatListVM.matches.indices)
                matches = chatListVM.matches
            }
            print("getMatches aufgerufen")
        }
        
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
