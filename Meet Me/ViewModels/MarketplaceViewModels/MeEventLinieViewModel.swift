//
//  MeEventLinieViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 18.02.21.
//

import Foundation
import PromiseKit

class MeEventLineViewModel: ObservableObject {
    
    private var firestoreManagerEventTest = FireStoreManagerEventTest()
    private var firestoreFotoManagerEventTest: FirestoreFotoManagerEventTest = FirestoreFotoManagerEventTest()
    @Published var meEvents: [EventModelObject] = []
    

    func getMeEvents() {
        firstly {
            self.firestoreManagerEventTest.firebaseGetMeEvents()
        }.done { events in
            self.meEvents = events
        }.catch { error in
            print("DEBUG: error in GetYouEventChain: \(error)")
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
}
    
//    func getMeEvents() {
//        firestoreManagerEvent.firebaseGetMeEvents(completionHandler: { success in
//            if success {
//                DispatchQueue.main.async {
//                self.meEvents = self.firestoreManagerEvent.getMeEvents()
//                }
//            } else {
//                print("error by downloading ME events")
//                // ohh, no picture
//
//            }
//
//        }
//        )
//    }
//
//}
    

