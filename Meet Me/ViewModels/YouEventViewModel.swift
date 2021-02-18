//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 16.02.21.
//

import Foundation

class YouEventViewModel: ObservableObject {
    
   private var firestoreManagerEvent = FireStoreManagerEvent()
    @Published var event: [EventModelObject] = []
    
    
    func getUserEvents() {
        print("hey")
        firestoreManagerEvent.getMeEvents(completionHandler: { success in
            if success {
                // yeah picture
                self.event = self.firestoreManagerEvent.getEvents()
            } else {
                print("else completion")
                // ohh, no picture
                
            }
            
        }
        )
    }
}

//Muss in die View
//@StateObject private var eventCreationVM = EventCreationViewModel()
//am besten dann funktion getUserEvent() über onAppear aufrufen

//danach kann auf das Array auf das array über
//eventCreationVM.event zugegriffen werden

