//
//  MeMatchCardView.swift
//  Meet Me
//
//  Created by Lukas Dech on 23.02.21.
//

import Foundation
import PromiseKit

class MeMatchCardViewModel: ObservableObject {
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    
    
    func addMatch(eventModel: EventModel, userModel: UserModel) ->Promise<Bool> {
        return Promise { seal in
            firstly {
                self.firestoreManagerUserTest.addMatchToCurrentUser(userModel: userModel)
            }.then { 
                self.firestoreManagerUserTest.addMatchToMatchedUser(userModel: userModel)
            }.then {
                self.firestoreManagerUserTest.deleteLikedUser(eventModel: eventModel, userModel: userModel)
            
            }.done {
                seal.fulfill(true)
            }.catch { error in
                print("DEBUG: Fehler in addMatchChain Error: \(error)")
                print("DEBUG: Error in addMatchChain localized: \(error.localizedDescription)")
            }
    }
}
        
    
    func deleteLikedUser(eventModel : EventModel, userModel: UserModel) ->Promise<Bool> {
        return Promise { seal in
            firstly {
                firestoreManagerUserTest.deleteLikedUser(eventModel: eventModel, userModel: userModel)
            }.done {
                seal.fulfill(true)
            }.catch { error in
                print("DEBUG: Fehler in deleteLikedUser Error: \(error)")
                print("DEBUG: Error in deleteLikedUser localized: \(error.localizedDescription)")
            }
        }
    }
}
