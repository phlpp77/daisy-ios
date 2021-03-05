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
    
    
    
    func deleteMatchandEventCompletely(match: AllMatchInformationModel) {
        firstly {
            self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: match.chatId)
        }.then {
            self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: match.chatId, matchedUserId: match.user.userId)
        }.then {
            self.firestoreManagerMatches.deleteChat(chatId: match.chatId)
        }.then {
            self.firestoreManagerMatches.deleteEvent(eventId: match.event.eventId)
        }.done {
            print("DEBUG: delete event erfolgreich")
        }.catch { error in
            print("DEGUB: error in deleteMatch complete, error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
        
    }
    
    func deleteMatchAndBackToPool(match: AllMatchInformationModel) {
        firstly {
            self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: match.chatId)
        }.then {
            self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: match.chatId, matchedUserId: match.user.userId)
        }.then {
            self.firestoreManagerMatches.deleteChat(chatId: match.chatId)
        }.then {
            self.firestoreManagerMatches.deleteAllLikedUserFromEvent(eventId: match.event.eventId)
        }.then {
            self.firestoreManagerEventTest.createLikedUserArray(eventId: match.event.eventId)
        }.then {
            self.firestoreManagerMatches.setLikedUserAndMatchedUserToFalse(eventId: match.event.eventId)
        }.done {
            print("DEBUG: delete match erfolgreich")
        }.catch { error in
            print("DEGUB: error in deleteMatch complete, error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
    }

    
    
    
}
