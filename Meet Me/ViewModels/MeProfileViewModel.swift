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
    


    func getUser(){
        firestoreManagerUser.getAllUsers { result in
            switch result {
            case .success(let user):
                if let user = user {
                    DispatchQueue.main.async {
                        self.user = user.map(UserModelObject.init)
                        self.userModel = self.convertModels(userArray: self.user)


                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func convertModels(userArray: [UserModelObject]) -> UserModel {

        var user: UserModel = testUser

            user.name = userArray[0].name
            user.gender = userArray[0].gender
            user.startProcessDone = userArray[0].startProcessDone
            user.searchingFor = userArray[0].searchingFor
            user.url = userArray[0].url
            user.userId = userArray[0].userId
            user.birthdayDate = userArray[0].birthdayDate

        return user


    }

    func getUserProfilePictureURL() {
        firestoreFotoManager.getAllPhotosFromUser(completionHandler: { success in
            if success {
                // yeah picture
                print(self.firestoreFotoManager.photoModel)
                print(URL(string: self.firestoreFotoManager.photoModel[0].url)!)
                let url = URL(string: self.firestoreFotoManager.photoModel[0].url)!
                self.userPictureURL = url
            } else {
                // ohh, no picture
                self.userPictureURL = stockURL
            }
            
        })
    }
    
    func getUserModel(){
        firestoreManagerUser.downloadcurrentUserModel(completion: { success in
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
    




//@ObservedObject private var UserListVM = UserListModel()
//UserListVM.getUser


