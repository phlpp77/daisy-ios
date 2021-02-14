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

class Meet_MeAppViewModel: ObservableObject {
    var firestoreManagerUser: FirestoreManagerUser = FirestoreManagerUser()




    func CheckUserAccForAutoLogin() -> Bool{
        if Auth.auth().currentUser != nil && getUser() {
            return true
            
        } else {
            return false

        }
    }

    func getUser() -> Bool {
        var userStartProcessDone = false
            firestoreManagerUser.getUserModel { result in
            switch result {
            case .success(let user):
                if let user = user {
                    userStartProcessDone = user.startProcessDone
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return userStartProcessDone
    }


}
