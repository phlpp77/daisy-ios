//
//  MessageViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 28.02.21.
//

//Load Chat 
import Foundation
import PromiseKit

class MessagesViewModel: ObservableObject {
    private var firestoreManagerChat: FirestoreManagerChat = FirestoreManagerChat()
    @Published var chat: ChatModel = stockChat
    
    
    func downloadChat(chatId: String) {
        firstly {
            self.firestoreManagerChat.downloadChat(chatId: chatId)
        }.done { chatModel in
            self.chat = chatModel
        }.catch { error in
            print("DEBUG: error in MessageDownloadChain error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
    }
    
    func UploadChat(chatId: String, messageText: String) {
        firstly {
            self.firestoreManagerChat.uploadMessage(messageText: messageText, chatId: chatId)
        }.done {
            self.downloadChat(chatId: chatId)
            print("Upload erfolgreich")
        }.catch { error in
            print("DEBUG: error in MessageUploadChain error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
            
        }
    }
}
