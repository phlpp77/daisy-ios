//
//  LoginViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 20.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class LoginViewModel: ObservableObject {
    
    
    private var db: Firestore = Firestore.firestore()
    var email: String = ""
    var password: String = ""
    var errorMessage: String = ""
    
    func login(completion: @escaping () -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
            } else {
                completion()
            }
            
        }
        
    }
    
    func checkErrors() -> Bool {
        
        if self.errorMessage != "" {
            return true
        } else {
            return false
        }
        
    }

    func checkUserAcc() -> Bool {
        guard let _ = Auth.auth().currentUser?.uid else {
            return false
        }
        return true
        
        
    }

    
}

