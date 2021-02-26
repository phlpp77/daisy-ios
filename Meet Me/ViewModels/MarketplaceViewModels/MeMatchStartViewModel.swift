//
//  MeMatchStartViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 21.02.21.
//

import Foundation
import PromiseKit

class MeMatchStartViewModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    
    func getLikedUsers (eventId: String) -> Promise<[UserModelObject]> {
        return Promise { seal in
            firstly{
                self.firestoreManagerUserTest.getAllLikedUserDocument(eventId: eventId)
            }.then { likedUser in
                self.firestoreManagerUserTest.getAllLikedUserModels(likedUser: likedUser)
            }.done { userModels in
                seal.fulfill(userModels)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
}

