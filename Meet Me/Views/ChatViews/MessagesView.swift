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
    var id: String = "08470AAA-128F-46A3-9D23-1CD48C528938"
   
    
    //@State var chat: ChatModel = ChatModel(chatId: "", eventCreatorId: "", matchedUserId: "", eventId: "", messages: [MessageModel(userId: "", timeStamp: Date(), messageText: "TestmsGG")])
    
    // message which needs to be uploaded
    @State var newMessage: String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                                
                // MARK: Message area
                ScrollView {
                    ForEach(messagesVM.chat.messages.indices, id: \.self) { messageNumber in
                        MessageView(message: $messagesVM.chat.messages[messageNumber])
                    }
                }
                
                // MARK: Send and type area
                HStack {
                    TextField("type new message here...", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        
                        messagesVM.UploadChat(chatId: id, messageText: newMessage)
                        
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
            messagesVM.downloadChat(chatId: id)
//            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
//                chat = messagesVM.chat
//            }
        }
        
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatId: .constant("08470AAA-128F-46A3-9D23-1CD48C528938"))
    }
}
