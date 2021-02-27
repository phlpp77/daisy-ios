//
//  YouProfilViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.02.21.
//

import Foundation

class YouProfilViewModel: ObservableObject {
    private var firestoreManagerUser: FirestoreManagerUserTest = FirestoreManagerUserTest()
    
    
    func getYouProfil(eventModel: EventModel) {
        
        firstly {
            firestoreManagerUser.getUserWhichCreatedEvent(eventModel: eventModel)
        }
        
    }
    
}
