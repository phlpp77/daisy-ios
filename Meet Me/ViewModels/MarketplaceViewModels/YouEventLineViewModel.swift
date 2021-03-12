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
    private var locationManager: LocationManager = LocationManager()
    @Published var region = MKCoordinateRegion.defaultRegion
    private var userModel: UserModel = stockUser


    func getYouEvents() -> Promise<[EventModel]>{

        return Promise { seal in
            firstly{
                firestoreManagerUserTest.getCurrentUser()
            }.map { user in
                self.userModel = user
            }.then {
                when(fulfilled: self.firestoreManagerUserTest.getAllLikedEvents(), self.getLocation())
            }.then { likedEvents, location in
                self.firestoreManagerEventTest.queryColletion(center: self.region.center, user: self.userModel).map { ($0, likedEvents) }
            }.then { queries, likedEvents in
                self.firestoreManagerEventTest.querysInEvent(likedEvents: likedEvents , queries: queries, center: self.region.center, user: self.userModel)
            }.done { events in
                seal.fulfill(events)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    
    func getLocation() ->Promise<Void>{
        return Promise { seal in
        _ = locationManager.$location.sink { location in
            self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 200, longitudinalMeters: 200)
        }
            print(region.center)
            seal.fulfill(())
        }
        
    }
    
}


//func getYouEvents() -> Promise<[EventModelObject]>{
//    return Promise { seal in
//        firstly {
//            when(fulfilled: self.firestoreManagerUserTest.getAllLikedEvents(), self.getLocation())
//        }.then { likedEvents, location in
//            self.firestoreManagerEventTest.firebaseGetYouEvents(likedEvents: likedEvents)
//        }.done { events in
//            seal.fulfill(events)
//        }.catch { error in
//            seal.reject(error)
//        }
//    }
//}


