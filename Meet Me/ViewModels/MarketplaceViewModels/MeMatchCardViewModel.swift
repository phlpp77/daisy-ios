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
    let sender = PushNotificationSender()
    
    func addMatch(eventModel: EventModel, userModel: UserModel) {
        let chatId = UUID().uuidString
            firstly {
                when(fulfilled:
                self.firestoreManagerMatches.addMatchToCurrentUser(userModel: userModel, eventModel: eventModel, chatId: chatId),
                self.firestoreManagerMatches.addMatchToMatchedUser(userModel: userModel, eventModel: eventModel, chatId: chatId),
                self.firestoreManagerMatches.createChatRoom(userModel: userModel, eventModel: eventModel, chatId: chatId),
                self.firestoreManagerEventTest.setEventMatchedToTrue(eventId: eventModel.eventId))
            }.done { 
                self.sender.sendPushNotification(to: userModel.token, title: "Neues Match", body: "Du Hast ein neues Match")
            }.catch { error in
                print("DEBUG: Fehler in addMatchChain Error: \(error)")
                print("DEBUG: Error in addMatchChain localized: \(error.localizedDescription)")
            }
    }

        
    
    func deleteLikedUser(eventModel : EventModel, userModel: UserModel){
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
    

