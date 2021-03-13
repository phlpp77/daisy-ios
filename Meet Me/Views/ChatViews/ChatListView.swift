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
    @State var matchLongPressed: AllMatchInformationModel = AllMatchInformationModel(chatId: "", user: stockUser, event: stockEvent)
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                
                HeaderView(text1: "Chat ", text2: " Area", highlightText: "ME")
                
                // chatListView is not created when there is no match
                if !chatListVM.matches.isEmpty {
                    
                    ScrollView {
                        
                        Spacer()
                        
                        ForEach(chatListVM.matches.indices, id: \.self) { matchNumber in
                            VStack(spacing: 15.0) {
                                
                                
                                
                                NavigationLink(
                                    destination: MessagesView(match: $matchTapped),
                                    isActive: $chatTapped
                                )
                                {
                                    ChatListRowView(match: $chatListVM.matches[matchNumber], chatTapped: $chatTapped, matchTapped: $matchTapped, matchLongPressed: $matchLongPressed)
                                        
                                }
                                .contextMenu {
                                    
                                        Button {
                                print(self)
                                        } label: {
                                            Label("Dissolve Match", systemImage: "person.crop.circle.badge.minus")
                                        }
                                
                                        Button {
                                
                                        } label: {
                                            Label("Dissolve Match and delete Event", systemImage: "minus.circle")
                                        }
                                    
                                }
                                
                                
                                

                                
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                    }
                } else {
                    
                    Spacer()
                    
                    Text("Drag Events and Match!")
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .background(Image("background"))
            
            
        }
        .onAppear {
            chatListVM.getMatches()
        }
        .onChange(of: matchLongPressed.chatId, perform: { value in
            print("longpressed")
        })
        
    }
    
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}


//.contextMenu {
//        Button {
//
//        } label: {
//            Label("Dissolve Match", systemImage: "person.crop.circle.badge.minus")
//        }
//
//        Button {
//
//        } label: {
//            Label("Dissolve Match and delete Event", systemImage: "minus.circle")
//        }
//    }
