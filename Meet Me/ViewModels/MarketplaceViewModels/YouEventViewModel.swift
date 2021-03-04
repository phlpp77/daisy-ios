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
    
    
    init(){
        firestoreManagerUserTest = FirestoreManagerUserTest()
        firestoreManagerEventTest = FirestoreManagerEventTest()
    }
    

    

    func addLikeToEvent(eventId: String){
        firstly {
            self.firestoreManagerUserTest.addLikeToEventArray(eventId: eventId)
        }.then {
            self.firestoreManagerEventTest.addLikeToEventArray(eventId: eventId)
        }.then {
            self.firestoreManagerEventTest.setLikedUserToTrue(eventId: eventId)
        }.catch { error in
            print("DEBUG: error in getUserModelChain \(error)")
            print("DEBUG \(error.localizedDescription)")
        }
    }
}



