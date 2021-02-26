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

    

    
    func getUserProfile() -> Promise<UserModel>{
        return Promise { seal in
            
            firstly {
                self.firestoreManagerUserTest.getCurrentUser()
            }.done { userModel in
                seal.fulfill(userModel)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
    
//    func getUserPicture() -> Promise<URL> {
//        return Promise { seal in
//
//            firstly {
//                self.firestoreFotoManagerUserTest.getAllPhotosFromCurrentUser()
//            }.done { allPhotos in
//                if allPhotos != nil {
//                    seal.fulfill(URL(string: allPhotos![0].url)!)
//                } else {
//                    seal.fulfill(stockURL)
//                }
//            }.catch { error in
//                seal.reject(error)
//            }
//        }
//    }
//}
            
            

        
 
