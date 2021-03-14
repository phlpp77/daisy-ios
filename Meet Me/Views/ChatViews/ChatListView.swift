//
//  ChatListView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct ChatListView: View {
    
    @ObservedObject var chatListVM: ChatListViewModel = ChatListViewModel()
    @ObservedObject var deleteMatchVM: DeleteMatchViewModel = DeleteMatchViewModel()
    
    @State var chatTapped: Bool = false
    @State var matchTapped: AllMatchInformationModel = AllMatchInformationModel(chatId: "", user: stockUser, event: stockEvent)
    @State var matchLongPressed: AllMatchInformationModel = AllMatchInformationModel(chatId: "", user: stockUser, event: stockEvent)
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                
                HeaderView(text1: "Chat ", text2: " Area", highlightText: "ME")
                
                // chatListView is not created when there is no match
                if !chatListVM.matches.isEmpty {
                    
                    ScrollView {
                        VStack {
                            
                            // space to push the view a bit more down
                            Color.clear.frame(height: 15)
                            
                            // listing chats inside view
                            ForEach(chatListVM.matches.indices, id: \.self) { matchNumber in
                                VStack(spacing: 15.0) {
                                    
                                    NavigationLink(
                                        destination: MessagesView(match: $matchTapped),
                                        isActive: $chatTapped
                                    )
                                    {
                                        ChatListRowView(match: $chatListVM.matches[matchNumber], chatTapped: $chatTapped, matchTapped: $matchTapped, matchLongPressed: $matchLongPressed)
                                        
                                    }
                                    // menu to dissolve match or delete and dissolve match
                                    .contextMenu {
                                        
                                        Button {
                                            deleteMatchVM.deleteMatchAndBackToPool(match: chatListVM.matches[matchNumber])
                                        } label: {
                                            Label("Dissolve Match", systemImage: "person.crop.circle.badge.minus")
                                        }
                                        
                                        Button {
                                            deleteMatchVM.deleteMatchAndEventCompletely(match: chatListVM.matches[matchNumber])
                                        } label: {
                                            Label("Dissolve Match and delete Event", systemImage: "minus.circle")
                                        }
                                        
                                    }
                                    
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
            .frame(maxWidth: .infinity)
            .background(
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            
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
