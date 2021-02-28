//
//  MessagesView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct MessagesView: View {
    
    // chatModel from the ViewModel with MatchModel.chatId
    
    @State var messages: [MessageModel] = [MessageModel()]
    @State var newMessage: String = "Test here"
    
    @State var budni: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                                
                // MARK: Message area
                ScrollView {
                    ForEach(messages.indices) { messageNumber in
                        MessageView(messageText: $newMessage, messageStyle: .constant(.creator))
                    }
                }
                
                // MARK: Send and type area
                HStack {
                    TextField("type new message here...", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        budni.toggle()
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .padding()
                    })
                }
                .padding()
                .modifier(FrozenWindowModifier())
            }
            
            if budni {
                SwiftUIView()
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
