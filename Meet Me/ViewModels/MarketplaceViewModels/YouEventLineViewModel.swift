//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 16.02.21.
//

import Foundation
import PromiseKit
import MapKit
import GeoFire
import Firebase

class YouEventLineViewModel: ObservableObject {
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    private var userModel: UserModel = stockUser
    


    func getYouEvents(region: MKCoordinateRegion) -> Promise<[EventModel]> {
        return Promise { seal in
            firstly{
                firestoreManagerUserTest.getCurrentUser()
            }.map { user in
                self.userModel = user
            }.then {
                 self.firestoreManagerUserTest.getAllLikedEvents()//, self.getLocation())
            }.then { likedEvents in
                self.firestoreManagerEventTest.queryColletion(center: region.center, user: self.userModel).map { ($0, likedEvents) }
            }.then { queries, likedEvents in
                self.firestoreManagerEventTest.querysInEvent(likedEvents: likedEvents , queries: queries, center: region.center, user: self.userModel)
            }.done { events in
                seal.fulfill(events)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
    
    


