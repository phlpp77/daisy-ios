//
//  MessagesView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI
import URLImage

struct MessagesView: View {
    
    @ObservedObject var messagesVM : MessagesViewModel = MessagesViewModel()
    @Binding var match: AllMatchInformationModel
    
    // message which needs to be uploaded
    @State var newMessage: String = ""
    
    @State var firstPartString: String = ""
    @State var showYouProfileView: Bool = false
    
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
                        
                        messagesVM.UploadChat(chatId: match.chatId, messageText: newMessage)
                        newMessage = ""
                        
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .padding()
                    })
                }
                .padding()
                .modifier(FrozenWindowModifier())
            }
            
            if showYouProfileView {
                
                // FIXME: YouProfile needs to be rewritten to take a user and show the profile
                YouProfileView(showYouProfileView: $showYouProfileView, tappedYouEvent: .constant(EventModelObject(eventModel: match.event, position: .constant(.zero))))
            }
            
        }
        
        // MARK: - Top area (inside the toolbar)
        .toolbar {
            // MARK: Showing the user
            ToolbarItem {
                HStack {
                    
                    // event "name" based on category
                    Text(firstPartString)
                    
                    // user clickable
                    
                    Button(action: {
                        showYouProfileView = true
                    }, label: {
                        HStack {
                            // username
                            Text(match.user.name)
                            
                            // profile image of user
                            URLImage(url: URL(string: match.user.userPhotos[1] ?? stockUrlString)!) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(
                                                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.9), Color.gray]), startPoint: .topTrailing, endPoint: .bottomLeading),
                                                lineWidth: 4
                                            )
                                    )
                                    .clipShape(Circle())
                            }
                        }
                    })
                }
            }
            
        }
        
        .onAppear {
            messagesVM.downloadChat(chatId: match.chatId)
            switch match.event.category {
            case "Café":
                firstPartString = "Drinking coffee with"
            default:
                firstPartString = "Event"
            }
        }
        
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(match: .constant(AllMatchInformationModel(chatId: "08470AAA-128F-46A3-9D23-1CD48C528938", user: stockUser, event: stockEvent)))
    }
}
