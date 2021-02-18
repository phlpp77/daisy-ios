//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation


class MeProfileViewModel: ObservableObject {
    private var firestoreManagerUser: FirestoreManagerUser = FirestoreManagerUser()
    private var firestoreFotoManager: FirestoreFotoManager = FirestoreFotoManager()
    var user: [UserModelObject] = []
    @Published var userModel: UserModel = testUser
    @Published var userPictureURL: URL = stockURL
    


    func getUserProfilePictureURL() {
        firestoreFotoManager.getAllPhotosFromUser(completionHandler: { success in
            if success {
                // yeah picture
                print(self.firestoreFotoManager.photoModel)
                print(URL(string: self.firestoreFotoManager.photoModel[0].url)!)
                let url = URL(string: self.firestoreFotoManager.photoModel[0].url)!
                self.userPictureURL = url
                print("\(self.userPictureURL) USER URL")
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
                        print("user to variable success")
                        self.userModel = self.firestoreManagerUser.getCurrentUserModel()
                    }
                } else {
                    print("Download User Failed")
                }
            }
            )
        }
}
    



