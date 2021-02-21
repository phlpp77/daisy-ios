//
//  MeMatchStartViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 21.02.21.
//

import Foundation
import PromiseKit

class MeMatchStartViewModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    @Published var likedUsers: [UserModel] = []
    
    func getLikedUsers (eventId: String) {
        firstly{
            self.firestoreManagerUserTest.getAllMatchedUsers(eventId: eventId)
        }.done { likes in
            self.likedUsers = likes
            print("DEBUG: done, GetLikedUsers Chain erfolgreich")
        }.catch { error in
            print("DEBUG: catch, Fehler in GetLikedUsers Chain\(error)")
            print(error.localizedDescription)
        }
        
    }
}
