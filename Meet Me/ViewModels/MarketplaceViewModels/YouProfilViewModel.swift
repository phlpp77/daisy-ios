//
//  YouProfilViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.02.21.
//

import Foundation
import PromiseKit

class YouProfilViewModel: ObservableObject {
    private var firestoreManagerUser: FirestoreManagerUserTest = FirestoreManagerUserTest()
    @Published var userModel : UserModel = stockUser
    @Published var userPictureUrl: URL = stockURL
    
    func getYouProfil(eventModel: EventModel) {
        
        firstly {
            firestoreManagerUser.getUserWhichCreatedEvent(eventModel: eventModel)
        }.done { user in
            self.userModel = user
            self.userPictureUrl = URL(string: user.userPhotos[1] ?? stockUrlString)!
        }.catch { error in
            print("DEBUG: Error in getYouProfil Chain error: \(error)")
            print("DEBUG: error localized: \(error.localizedDescription)")
        }
        
    }
    
}
