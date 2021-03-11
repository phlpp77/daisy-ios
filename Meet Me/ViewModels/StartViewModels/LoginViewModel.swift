//
//  LoginViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 20.01.21.
//

import Foundation
import Firebase
import PromiseKit

class LoginViewModel: ObservableObject {
    
    private var db: Firestore = Firestore.firestore()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var password2: String = ""
    @Published var errorMessage: String = ""
    private var newErrorMessage: String = ""
    @Published var startProcessDone: Bool = false
    
    
    
    
    //login
        
    
    func checkUserAcc() -> Promise<Bool> {
        return Promise { seal in
            firstly {
                self.firestoreManagerUserTest.getCurrentUser()
            }.done { userModel in
                seal.fulfill(true)
            }.catch { error in
                seal.fulfill(false)
            }
        }
    }
    
    func loginAuth() ->Promise<Void>{
        return Promise { seal in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
            
        }
        
    }
    
    

    
    func register() -> Promise<Void> {
        return Promise{ seal in
            if self.password == self.password2 {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("VMCatch1")
                        seal.reject(error)
                    } else {
                        seal.fulfill(())
                    }
                }
            }else {
                seal.reject(Err("passwords are not the same"))
            }
        }
    }
}
    



