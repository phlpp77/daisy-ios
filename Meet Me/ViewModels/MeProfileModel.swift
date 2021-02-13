//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation


class UserListModel: ObservableObject {
    private var firestoreManager: FirestoreManager
    var user: [MeProfileModel] = []
    @Published var userModel: UserModel = testUser

    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func getUser(){
        firestoreManager.getUserItem { result in
            switch result {
            case .success(let user):
                if let user = user {
                    DispatchQueue.main.async {
                        self.user = user.map(MeProfileModel.init)
                        self.userModel = self.convertModels(userArray: self.user)
                        
                        
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func convertModels(userArray: [MeProfileModel]) -> UserModel {
        
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
        
    

    struct MeProfileModel {
        
        let user: UserModel
        
        var name: String {
            user.name
        }
        
        var birthdayDate: Date {
            user.birthdayDate
        }
        
        var gender: String {
            user.gender
        }
        
        var startProcessDone: Bool {
            user.startProcessDone
        }
        
        var searchingFor: String {
            user.searchingFor
        }
        
        var userId: String {
            user.userId
        }
        
        var url: String {
            user.url
        }
        
    }
    
    

}


//@ObservedObject private var UserListVM = UserListModel()
//UserListVM.getUser


