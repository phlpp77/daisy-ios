//
//  ChangeMeEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 10.03.21.
//

import Foundation
import PromiseKit


class ChangeMeEventViewModel: ObservableObject {
    
    @Published var event: EventModel = stockEvent
    private var firestoreManagerMatches: FirestoreManagerMatches = FirestoreManagerMatches()
    private var chatModel: ChatModel = stockChat
    
    func changeMeEventSettings(eventModel: EventModel) {
        event.likedUser = eventModel.likedUser
        event.eventMatched = eventModel.eventMatched
        event.eventId = eventModel.eventId
        event.userId = eventModel.userId
        event.hash = eventModel.hash
        event.latitude = eventModel.latitude
        event.longitude = event.longitude
        event.profilePicture = eventModel.profilePicture
        
        
        
        
        
        
        
    }
    
    func deleteMeEvent(eventModel: EventModel) {
        firstly {
            firestoreManagerMatches.deleteEvent(eventId: eventModel.eventId)
        }.catch { error in
            print("DEBUG: error in deleteMeEvent, error \(error)")
            print("DEBUG: error localized: \(error.localizedDescription)")
        }
        
        if eventModel.eventMatched == true {
            firstly{
                firestoreManagerMatches.getChatWithEventId(eventId: eventModel.eventId)
            }.map { chat in
                self.chatModel = chat
            }.then {
                when(fulfilled:
                     self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: self.chatModel.chatId),
                     self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: self.chatModel.chatId, matchedUserId: self.chatModel.matchedUserId),
                     self.firestoreManagerMatches.deleteChat(chatId: self.chatModel.chatId))
            }.catch { error in
                print("DEBUG: error in deleteMeEvent, error \(error)")
                print("DEBUG: error localized: \(error.localizedDescription)")
            }
            
            
        }
        
        
    }
}
    


    
    
