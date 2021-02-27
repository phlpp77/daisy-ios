//
//  ChatListView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct ChatListView: View {
    
    @Binding var users: [UserModel]
    @Binding var events: [EventModel]
    
    @State var chatTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                
                ScrollView {
                    ForEach(users.indices) { userNumber in
                        
                        VStack {
                            
                            Color.clear
                            
                            NavigationLink(
                                destination: MessagesView(),
                                isActive: $chatTapped
                            )
                                {
                                ChatListRowView(user: $users[userNumber], event: $events[userNumber], chatTapped: $chatTapped)
                            }
                            
                            
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(users: .constant([stockUser, stockUser2]), events: .constant([stockEvent]))
    }
}
