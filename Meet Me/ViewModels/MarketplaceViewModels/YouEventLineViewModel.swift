//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 16.02.21.
//

import Foundation
import PromiseKit

class YouEventLineViewModel: ObservableObject {
    
    private var firestoreManagerEventTest: FireStoreManagerEventTest = FireStoreManagerEventTest()
    @Published var youEvents: [EventModelObject] = []
    
  
    func getYouEvents() {
        firstly {
            self.firestoreManagerEventTest.firebaseGetYouEvents()
        }.done { events in
            self.youEvents = events
        }.catch { error in
            print("DEBUG: error in GetYouEventChain: \(error)")
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
}



