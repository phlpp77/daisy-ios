////
////  LoginViewModel.swift
////  Meet Me
////
////  Created by Lukas Dech on 20.01.21.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//import PromiseKit
//
//class LoginViewModel: ObservableObject {
//    
//    
//    private var db: Firestore = Firestore.firestore()
//    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
//    var email: String = ""
//    var password: String = ""
//    var errorMessage: String = ""
//    
//    func login(completion: @escaping () -> Void) {
//        
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//                print(error.localizedDescription)
//            } else {
//                completion()
//            }
//            
//        }
//        
//    }
//    
//    func checkErrors() -> Bool {
//        
//        if self.errorMessage != "" {
//            return true
//        } else {
//            return false
//        }
//        
//    }
////Check if user has a UserModel
//    func checkUserAcc() -> Promise<Bool> {
//        return Promise { seal in
//            firstly {
//                firestoreManagerUserTest.getCurrentUser()
//            }.done { userModel in
//                seal.fulfill(userModel.startProcessDone)
//            }.catch { error in
//                seal.reject(error)
//            }
//        }
//        
//    }
//
//}
//
