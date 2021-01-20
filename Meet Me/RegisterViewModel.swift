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
    
    func register(completion: @escaping () -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion()
            }
            
        }
        
    }
    
}
