//
//  MeEventLinieViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 18.02.21.
//

import Foundation

class MeEventLineViewModel: ObservableObject {
    
    private var firestoreManagerEvent = FireStoreManagerEvent()
    private var firestoreFotoManager: FirestoreFotoManager = FirestoreFotoManager()
    @Published var meEvents: [EventModelObject] = []
    

    
    
    func getMeEvents() {
        firestoreManagerEvent.firebaseGetMeEvents(completionHandler: { success in
            if success {
                DispatchQueue.main.async {
                self.meEvents = self.firestoreManagerEvent.getMeEvents()
                }
            } else {
                print("error by downloading ME events")
                // ohh, no picture
                
            }
            
        }
        )
    }
    
}
    

