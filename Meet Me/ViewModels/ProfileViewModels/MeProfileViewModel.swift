//
//  MeProfileModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.02.21.
//

import Foundation
import PromiseKit
import SwiftUI
import Firebase



class MeProfileViewModel: ObservableObject {
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    private var firestoreFotoManagerUserTest: FirestoreFotoManagerUserTest = FirestoreFotoManagerUserTest()
    @Published var userModel: UserModel = stockUser
    @Published var userPictureURL: URL = stockURL
    private var url: URL = stockURL
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    

    
//    func getUserProfile() {
//            firstly {
//                self.firestoreManagerUserTest.getCurrentUser()
//            }.done { user in
//                self.userModel = user
//                self.userPictureURL = URL(string: user.userPhotos[1] ?? stockUrlString)!
//            }.catch { error in
//                print("DEBUG: error in getUserProfileChain \(error)")
//                print("DEBUG: \(error.localizedDescription)")
//            }
//        }
    
    func getCurrentUser() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection("users").document(currentUser.uid).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshot = snapshot {
                    let userModel = try? snapshot.data(as: UserModel.self)
                    DispatchQueue.main.async {
                        if userModel != nil {
                            self.userModel = userModel!
                        }else {
                            print(Err("cant get userProfil"))
                        }
                    }
                    
                    
                }
            }
            
        }
        
        
    }

    func changedSearchingFor(searchingFor: String){
        firstly {
            firestoreManagerUserTest.setSearchingFor(searchingFor: searchingFor)
        }.catch { error in
            print("DEBUG: Error in chagedSerachingFor: \(error)")
            print("DEBUG: Error localized in: \(error.localizedDescription)")
        }
    }

    func changedRange(radius: Double){
        firstly {
            firestoreManagerUserTest.setRadius(radius: radius)
        }.catch { error in
            print("DEBUG: Error in changedRadius: \(error)")
            print("DEBUG: Error localized in: \(error.localizedDescription)")

        }
    }
    
    func addPhotoInPosition(image: UIImage, position: Int) {
        firstly {
            self.firestoreFotoManagerUserTest.resizeImage(originalImage: image)
        }.then { picture in
            self.firestoreFotoManagerUserTest.uploadUserPhoto(data: picture, fotoPlace: position)
        }.map { url in
            self.url = url
        }.then {
            self.firestoreFotoManagerUserTest.savePhotoUrlToFirestore(url: self.url, fotoPlace: position)
        }.catch { error in
            print(error )
        }
        if position == 1 {
            firstly {
                firestoreFotoManagerUserTest.changedProfilPicture(newProfilePicture: self.url)
            }.catch { error in
                print(error)
            }
        }
        
    }
    
    func deletePhoto(position: Int) {
        firstly {
            self.firestoreFotoManagerUserTest.delteImageFromUser(fotoPlace: position)
        }.then {
            self.firestoreFotoManagerUserTest.deleteImageFromStorage(fotoPlace: position)
        }.catch { error in
            print("DEBUG: error in deletePhoto error: \(error)")
            print("DEBUG: error localized: \(error.localizedDescription)")
        }
    }
    
}
       
            

        
 
