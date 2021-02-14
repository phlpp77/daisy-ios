//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ProfileCreationModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var userId: String = ""
    var name: String = "Name"
    var birthdayDate: Date = Date()
    var gender: String = "Gender"
    var searchingFor: String = ""
    var startProcessDone: Bool = true
    
    let storage = Storage.storage()
    
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func saveUserSettings() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userModel = UserModel(userId: currentUser.uid, name: name, birthdayDate: birthdayDate, gender: gender, startProcessDone: startProcessDone, searchingFor : searchingFor)
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
