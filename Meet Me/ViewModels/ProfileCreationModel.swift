//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation

class ProfileCreationModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var userId: String = ""
    var name: String = "Name"
    var birthdayDate: String = "Birthday"
    var gender: String = "Gender"
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func save() {
        
        let userModel = UserModel( userId: userId, name: name, birthdayDate: birthdayDate, gender: gender)
        firestoreManager.saveUser(userModel: userModel){ result in
            switch result {
            case .success(let userModel):
                DispatchQueue.main.async {
                    self.saved = userModel == nil ? false: true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self .message = ErrorMessages.userSaveFailed
                }
                
            
            }
        }
    }
}
