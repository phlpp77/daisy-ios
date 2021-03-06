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
    @State var matchTapped: AllMatchInformationModel = AllMatchInformationModel(chatId: "", user: stockUser, event: stockEvent)
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                
                // MARK: Header of the chat part
                HStack(spacing: 0.0) {
                    Text("Chat ")
                    Text("ME")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.accentColor)
                    Text(" Area")
                }
                .font(.largeTitle)
                .padding(.vertical, 12)
                
                // chatListView is not created when there is no match
                if !chatListVM.matches.isEmpty {
                    
                    ScrollView {
                        ForEach(chatListVM.matches.indices, id: \.self) { matchNumber in
                            
                            VStack {
                                
                                Color.clear
                                
                                NavigationLink(
                                    destination: MessagesView(match: $matchTapped),
                                    isActive: $chatTapped
                                )
                                {
                                    ChatListRowView(match: $chatListVM.matches[matchNumber], chatTapped: $chatTapped, matchTapped: $matchTapped)
                                }
                                
                                
                            }
                        }
                        
                    }
                } else {
                    
                    Spacer()
                    
                    Text("Drag Events and Match!")
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            
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
