//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 16.02.21.
//

import Foundation
import PromiseKit
import MapKit

class YouEventLineViewModel: ObservableObject {
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    private var locationManager: LocationManager = LocationManager()
    @Published var region = MKCoordinateRegion.defaultRegion
    
   

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
    
    func getLocation() {
        _ = locationManager.$location.sink { location in
            self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 200, longitudinalMeters: 200)
            
            print("LocationInManager: \(self.region.center)")


        }
    }
    
}





