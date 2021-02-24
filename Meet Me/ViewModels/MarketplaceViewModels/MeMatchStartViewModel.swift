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
                self.firestoreManagerUserTest.getAllMatchedUsers(eventId: eventId)
            }.done { likes in
                seal.fulfill(likes)
                print("DEBUG: done, GetLikedUsers Chain erfolgreich")
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}

