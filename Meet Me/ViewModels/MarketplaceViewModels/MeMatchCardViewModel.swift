//
//  MeMatchCardView.swift
//  Meet Me
//
//  Created by Lukas Dech on 23.02.21.
//

import Foundation
import PromiseKit

class MeMatchCardViewModel: ObservableObject {
    private var firestoreManagerMatches: FirestoreManagerMatches = FirestoreManagerMatches()
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()

    
    func addMatch(eventModel: EventModelObject, userModel: UserModelObject) {
        let chatId = UUID().uuidString
            firstly {
                self.firestoreManagerMatches.addMatchToCurrentUser(userModel: userModel, eventModel: eventModel, chatId: chatId)
            }.then { 
                self.firestoreManagerMatches.addMatchToMatchedUser(userModel: userModel, eventModel: eventModel, chatId: chatId)
            }.then {
                self.firestoreManagerMatches.createChatRoom(userModel: userModel, eventModel: eventModel, chatId: chatId)
            }.then {
                self.firestoreManagerEventTest.setEventMatchedToTrue(eventId: eventModel.eventId)
            }.catch { error in
                print("DEBUG: Fehler in addMatchChain Error: \(error)")
                print("DEBUG: Error in addMatchChain localized: \(error.localizedDescription)")
            }
    }

        
    
    func deleteLikedUser(eventModel : EventModelObject, userModel: UserModelObject){
            firstly {
                firestoreManagerMatches.deleteLikedUser(eventModel: eventModel, userModel: userModel)
            }.catch { error in
                print("DEBUG: Fehler in deleteLikedUser Error: \(error)")
                print("DEBUG: Error in deleteLikedUser localized: \(error.localizedDescription)")
            }
        }
    
    func setLikedUserToFalse(eventId: String) {
        firstly {
            firestoreManagerMatches.setLikedUserAndMatchedUserToFalse(eventId: eventId)
        }.catch { error in
            print("DEBUG: Fehler in deleteLikedUser Error: \(error)")
            print("DEBUG: Error in deleteLikedUser localized: \(error.localizedDescription)")
        }
    }
}
    

