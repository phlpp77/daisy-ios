//
//  DeleteMatchViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 05.03.21.
//

import Foundation
import PromiseKit

class DeleteMatchViewModel: ObservableObject {
    private var firestoreManagerMatches: FirestoreManagerMatches = FirestoreManagerMatches()
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    
    
    
    func deleteMatchAndEventCompletely(match: AllMatchInformationModel) {
        firstly {
            when(fulfilled:
                 self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: match.chatId, matchedUserId: match.user.userId),
                 self.firestoreManagerMatches.deleteChat(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteEvent(eventId: match.event.eventId))
        }.catch { error in
            print("DEGUB: error in deleteMatch complete, error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
        
    }
    
    func deleteMatchAndBackToPool(match: AllMatchInformationModel) {
        firstly {
            when(fulfilled:
            self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: match.chatId, matchedUserId: match.user.userId),
                 self.firestoreManagerMatches.deleteChat(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteAllLikedUserFromEvent(eventId: match.event.eventId),
                 self.firestoreManagerEventTest.createLikedUserArray(eventId: match.event.eventId),
                 self.firestoreManagerMatches.setLikedUserAndMatchedUserToFalse(eventId: match.event.eventId))
        }.catch { error in
            print("DEGUB: error in deleteMatch complete, error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
    }
}
