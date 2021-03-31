//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 19.02.21.
//

import Foundation
import PromiseKit

class YouEventViewModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest
    private var firestoreManagerEventTest: FirestoreManagerEventTest
    private var currentUserModel: UserModel = stockUser
    let sender = PushNotificationSender()
    
    init(){
        firestoreManagerUserTest = FirestoreManagerUserTest()
        firestoreManagerEventTest = FirestoreManagerEventTest()
    }
    

    

    func addLikeToEvent(eventModel: EventModel){
        firstly {
            when(fulfilled: self.firestoreManagerUserTest.addLikeToEventArray(eventId: eventModel.eventId),
                 self.firestoreManagerEventTest.addLikeToEventArray(eventId: eventModel.eventId),
                 self.firestoreManagerEventTest.setLikedUserToTrue(eventId:eventModel.eventId))
        }.then {
            self.firestoreManagerUserTest.getUserWhichCreatedEvent(eventModel: eventModel)
        }.done { user in
            self.sender.sendPushNotification(to: user.token, title: "New Like", body: "someone new want to join your event")
        }.catch { error in
            print("DEBUG: error in getUserModelChain \(error)")
            print("DEBUG \(error.localizedDescription)")
        }
    }
}



