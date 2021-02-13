//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation


class UserListModel: ObservableObject {
    private var firestoreManager: FirestoreManager
    @Published var user: [MeProfileModel] = []
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func getUser() {
        firestoreManager.getUserItem { result in
            switch result {
            case .success(let user):
                if let user = user {
                    DispatchQueue.main.async {
                        self.user = user.map(MeProfileModel.init)
                        
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    }
}


//@ObservedObject private var UserListVM = UserListModel()
//UserListVM.getUser


