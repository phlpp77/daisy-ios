//
//  Meet_MeAppViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 14.02.21.
//
//
import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class Meet_MeAppViewModel: ObservableObject {
    var firestoreManagerUser: FirestoreManagerUser = FirestoreManagerUser()


    func CheckUserAccForAutoLogin() -> Bool{
        if Auth.auth().currentUser != nil{
            return true
            
        } else {
            return false

        }
    }

//    func getUser() -> Bool {
//        var userStartProcessDone = false
//            firestoreManagerUser.currentUserModel{ result in
//            switch result {
//            case .success(let user):
//                if let user = user {
//                    if user.startProcessDone != nil {
//                        userStartProcessDone = true
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        return userStartProcessDone
//    }
//
//
//}
}
