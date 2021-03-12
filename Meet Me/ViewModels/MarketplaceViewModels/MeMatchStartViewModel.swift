//
//  MeMatchStartViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 21.02.21.
//

import Foundation
import PromiseKit

class MeMatchStartViewModel: ObservableObject {
    
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    
    func getLikedUsers (eventId: String) -> Promise<[UserModel]> {
        return Promise { seal in
            firstly{
                self.firestoreManagerEventTest.getAllLikedUserDocument(eventId: eventId)
            }.then { likedUser in
                self.firestoreManagerEventTest.getAllLikedUserModels(likedUser: likedUser)
            }.done { userModels in
                seal.fulfill(userModels)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
}

