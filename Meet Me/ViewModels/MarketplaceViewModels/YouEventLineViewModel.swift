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
    @Published var eventArray: [EventModelObject] = []

    func getYouEvents(){
            firstly {
                self.firestoreManagerUserTest.getAllLikedEvents()
            }.then { likedEvents in
                self.firestoreManagerEventTest.firebaseGetYouEvents(likedEvents: likedEvents)
            }.done { events in
                self.eventArray = events
            }.catch { error in
                print("DEBUG: error in getYouEvents error: \(error)" )
                print("DEBUG: error localized: \(error.localizedDescription)")
            }
        }
    }
    






