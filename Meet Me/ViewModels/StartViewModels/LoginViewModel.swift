//
//  LoginViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 20.01.21.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    
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

    

    
}

