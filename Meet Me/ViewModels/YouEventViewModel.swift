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
        firestoreManagerEvent.getMeEvents(completionHandler: { success in
            if success {
                DispatchQueue.main.async {
                self.event = self.firestoreManagerEvent.getEvents()
                }
            } else {
                print("error by downloading events")
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

