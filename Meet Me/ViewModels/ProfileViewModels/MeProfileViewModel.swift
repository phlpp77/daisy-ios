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
    var user: [UserModelObject] = []
    @Published var userModel: UserModel = stockUser
    @Published var userPictureURL: URL = stockURL

    

    
    func getUserProfileAndPicture() {
        firstly {
            when(fulfilled: self.firestoreManagerUserTest.downloadCurrentUserModel(), self.firestoreFotoManagerUserTest.getAllPhotosFromUser())
        }.done { userModel, allPhotos in
            self.userModel = userModel
            self.userPictureURL = URL(string: allPhotos[0].url)!
        }.catch { error in
                print("DEBUG: error in getUserProfileChain \(error)")
                print("DEBUG: \(error.localizedDescription)")
        }
    }
}
            
            

        
 
