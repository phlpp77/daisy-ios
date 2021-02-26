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
    private var firestoreManagerEventTest: FireStoreManagerEventTest
    private var currentUserModel: UserModel = stockUser
    
    
    init(){
        firestoreManagerUserTest = FirestoreManagerUserTest()
        firestoreManagerEventTest = FireStoreManagerEventTest()
    }
    

    

    func addLikeToEvent(eventId: String){
        firstly {
            self.firestoreManagerUserTest.downloadCurrentUserModel()
        }.then { userModel in
            self.firestoreManagerEventTest.addLikeToEventArray(eventId: eventId, userModel: userModel)
        }.catch { error in
            print("DEBUG: error in getUserModelChain \(error)")
            print("DEBUG \(error.localizedDescription)")
        }
    }
}



