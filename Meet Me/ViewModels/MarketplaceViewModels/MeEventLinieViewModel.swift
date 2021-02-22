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
   
    

    func getMeEvents() -> Promise<[EventModelObject]>{
        return Promise { seal in
            firstly {
                self.firestoreManagerEventTest.firebaseGetMeEvents()
            }.done { events in
                seal.fulfill(events)
            }.catch { error in
                seal.reject(error)
            }
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
    

