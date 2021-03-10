//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation
import PromiseKit
import SwiftUI



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
//
//
//
//    func changedOrderOfPictures(changed: Bool) {
//        firstly {
//        firestoreFotoManagerUserTest.savePhotoUrlToFirestore(url1: URL(string: userModel.userPhotos[1]!),
//                                                             url2: URL(string: userModel.userPhotos[2]!),
//                                                             url3: URL(string: userModel.userPhotos[3]!))
//        }.catch { error in
//            print("DEBUG: Error in changeOrderOfPictures, error: \(error)")
//            print("DEBUG: Error localized in: \(error.localizedDescription)")
//        }
//    }
//
//    func changedProfilPicture(newUrl: URL) {
//        firstly {
//            //Update all Events
//            firestoreFotoManagerUserTest.changedProfilPicture(newProfilePicture: newUrl)
//        }.catch { error in
//            print("DEBUG: Error in changedProfilPicture, error: \(error)")
//            print("DEBUG: Error localized in: \(error.localizedDescription)")
//        }
//
//
//    }
//
//    func addNewPicture(images: [UIImage]){
//        firstly{
//            self.firestoreFotoManagerUserTest.resizeImage(originalImages: images)
//        }.then { picture in
//            self.firestoreFotoManagerUserTest.uploadUserPhoto(data: picture)
//        }.then { urls in
//            self.firestoreFotoManagerUserTest.savePhotoUrlToFirestore(url1: urls[0], url2: nil, url3: nil)
//        }.catch { error in
//            print("DEBUG: catch, fehler in event creation \(error)")
//            print(error.localizedDescription)
//        }
//    }
//
//
//    func changedSearchingFor(searchingFor: String){
//        firstly {
//            firestoreManagerUserTest.setSearchingFor(searchingFor: searchingFor)
//        }.catch { error in
//            print("DEBUG: Error in chagedSerachingFor: \(error)")
//            print("DEBUG: Error localized in: \(error.localizedDescription)")
//        }
//    }
//
//    func changedRange(radius: Double){
//        firstly {
//            firestoreManagerUserTest.setRadius(radius: radius)
//        }.catch { error in
//            print("DEBUG: Error in changedRadius: \(error)")
//            print("DEBUG: Error localized in: \(error.localizedDescription)")
//
//        }
//    }
//}
       
            

        
 
