//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 16.02.21.
//

import Foundation

class YouEventLineViewModel: ObservableObject {
    
    private var firestoreManagerEvent = FireStoreManagerEvent()
    @Published var youEvents: [EventModelObject] = []
    
    
    func getYouEvents() {
        firestoreManagerEvent.firebaseGetYouEvents(completionHandler: { success in
            if success {
                DispatchQueue.main.async {
                self.youEvents = self.firestoreManagerEvent.getYouEvents()
                }
            } else {
                //print("error by downloading YOU events")
                // ohh, no picture
                
            }
            
        }
        )
    }
}
//URL(string: self.pictureURL)!


