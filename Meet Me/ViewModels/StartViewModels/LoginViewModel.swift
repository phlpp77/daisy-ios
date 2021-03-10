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
    @Published var startProcessDone: Bool = false
    
    
    
    
    //login
    
    func login() -> Promise<Void>{
        return Promise { seal in
            firstly {
                loginAuth()
            }.then {
                self.checkUserAcc()
            }.done { acc in
                //True wenn erfolgreich
                self.startProcessDone = acc
                seal.fulfill(())
                print(self.email)
                print(self.password)
                print(acc)
            }.catch { error in
                self.errorMessage = error.localizedDescription
            }
        }
    }
        
    
    func checkUserAcc() -> Promise<Bool> {
        return Promise { seal in
            firstly {
                firestoreManagerUserTest.getCurrentUser()
            }.done { userModel in
                seal.fulfill(userModel.startProcessDone)
            }.catch { error in
                seal.reject(error)
            }
        }
        
    }
    
    func loginAuth() ->Promise<Void>{
        return Promise { seal in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
            
        }
        
    }
    
    
    //register
    func register() ->Promise<Void>{
        return Promise { seal in
            firstly {
                self.checkErrorsRegister()
            }.then {
                self.registerAuth()
            }.done {
                seal.fulfill(())
            }.catch { error in
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    
    
    
    
    func registerAuth() -> Promise<Void> {
        return Promise{ seal in
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    
    
    
    
    
    
    func checkErrorsRegister() ->Promise<Void>{
        return Promise { seal in
            
            if self.errorMessage != "" {
                seal.fulfill(())
            }
            if password != password2 && password != "" {
                seal.fulfill(())
            } else {
                self.errorMessage = "Passwords are not the same"
                seal.reject(Err("Passwords are not the same"))
            }
        }
        
    }
    
    
    
    
}


