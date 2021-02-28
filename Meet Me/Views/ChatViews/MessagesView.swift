//
//  MessagesView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct MessagesView: View {
    
    @StateObject var messagesVM : MessagesViewModel = MessagesViewModel()
    // chatModel from the ViewModel with MatchModel.chatId from the view above
    @Binding var chatId: String
    
    @State var chat: ChatModel = stockChat
    
    // message which needs to be uploaded
    @State var newMessage: String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                                
                // MARK: Message area
                ScrollView {
                    ForEach(messagesVM.chat.messages.indices) { messageNumber in
                        MessageView(message: $chat.messages[messageNumber])
                    }
                }
                
                // MARK: Send and type area
                HStack {
                    TextField("type new message here...", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        messagesVM.UploadChat(chatId: chatId, messageText: newMessage)
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .padding()
                    })
                }
                .padding()
                .modifier(FrozenWindowModifier())
            }
            
        }
        
        // TODO: @budni onAppear for you to play with
        .onAppear {
            messagesVM.downloadChat(chatId: chatId)
        }
        
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatId: .constant("chadIDDD"))
    }
}
