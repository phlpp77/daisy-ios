//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation
import PromiseKit



class MeProfileViewModel: ObservableObject {
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    private var firestoreFotoManagerUserTest: FirestoreFotoManagerUserTest = FirestoreFotoManagerUserTest()
    //var user: [UserModelObject] = []
    @Published var userModel: UserModel = stockUser
    @Published var userPictureURL: URL = stockURL

    

    
    func getUserProfile() {
            firstly {
                self.firestoreManagerUserTest.getCurrentUser()
            }.done { user in
                self.userModel = user
                self.userPictureURL = URL(string: user.userPhotos[1] ?? stockUrlString)!
            }.catch { error in
                print("DEBUG: error in getUserProfileChain \(error)")
                print("DEBUG: \(error.localizedDescription)")
            }
        }
    }

       
            

        
 
