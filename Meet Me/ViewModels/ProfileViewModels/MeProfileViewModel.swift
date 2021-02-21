//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation


class MeProfileViewModel: ObservableObject {
    private var firestoreManagerUser: FirestoreManagerUser = FirestoreManagerUser()
    private var firestoreFotoManagerUser: FirestoreFotoManagerUser = FirestoreFotoManagerUser()
    var user: [UserModelObject] = []
    @Published var userModel: UserModel = stockUser
    @Published var userPictureURL: URL = stockURL
    


    func getUserProfilePictureURL() {
        firestoreFotoManagerUser.getAllPhotosFromUser( completionHandler: { success in
            if success {
                // yeah picture


                let url = URL(string: self.firestoreFotoManagerUser.photoModel[0].url)!
                self.userPictureURL = url

            } else {
                // ohh, no picture
                self.userPictureURL = stockURL
            }
            
        })
    }
    
    func getUserModel(){
        firestoreManagerUser.downloadCurrentUserModel(completion: { success in
                if success {
                    DispatchQueue.main.async {
                        self.userModel = self.firestoreManagerUser.getCurrentUserModel()
                    }
                } else {
                    print("Download User Failed")
                }
            }
            )
        }
}
    



