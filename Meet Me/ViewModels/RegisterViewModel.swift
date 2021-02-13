//
//  RegisterViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 20.01.21.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    var password2: String = ""
    var errorMessage: String = ""
    
    func register(completion: @escaping () -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                completion()
            }
        }
        
        
    }
    

    
    
    func checkErrors() -> Bool {
        
        if self.errorMessage != "" {
            return true
        }
        if password != password2 && password != "" {
            self.errorMessage = "Passwords are not the same"
            return true
        } else {
            return false
        }
        
    }
    
    
    
    
}


