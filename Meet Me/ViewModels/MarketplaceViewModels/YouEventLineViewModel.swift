//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 16.02.21.
//

import Foundation
import PromiseKit

class YouEventLineViewModel: ObservableObject {
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()

    func getYouEvents() -> Promise<[EventModelObject]>{
        return Promise { seal in
            firstly {
                self.firestoreManagerUserTest.getAllLikedEvents()
            }.then { likedEvents in
                self.firestoreManagerEventTest.firebaseGetYouEvents(likedEvents: likedEvents)
            }.done { events in
                seal.fulfill(events)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
}





