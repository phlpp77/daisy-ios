//
//  test.swift
//  Meet Me
//
//  Created by Lukas Dech on 18.02.21.
//

import Foundation
import Firebase

struct test {

    func tesefst() {
        print("TTTTEEEESSSSTT")
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("current user not exist")
            return
        }
        Firestore.firestore().collection("users").document(currentUser).getDocument { snapshot, error in
            print("DEBUG: \(String(describing: snapshot?.data())) ")
        }
    }
}

