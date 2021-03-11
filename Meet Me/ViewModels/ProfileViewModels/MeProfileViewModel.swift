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
    @Published var genders: [String: Int] = ["Female": 0, "Male": 1, "Other": 2]
    @Published var picked = 0
    
    
    private var gender: [String] = ["Female", "Male", "Other"]
    private var url: URL = stockURL
    private var db: Firestore
    private var listener: ListenerRegistration?
    
    
    
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
        listener = db.collection("users").document(currentUser.uid).addSnapshotListener { snapshot, error in
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
            self.picked = self.genders[self.userModel.searchingFor]!
        }
    }

    func changedSearchingFor(searchingFor: Int){
        firstly {
            self.firestoreManagerUserTest.setSearchingForUserProfile(searchingFor: self.gender[searchingFor])
        }.then {
            self.firestoreManagerUserTest.setSearchingForEvents(searchingFor: self.gender[searchingFor])
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
//        firstly {
//            self.firestoreFotoManagerUserTest.deleteImageFromStorage(storageId: self.userModel.userPhotosId[position])
        firstly {
            self.firestoreFotoManagerUserTest.resizeImage(originalImage: image)
        }.then { picture in
            self.firestoreFotoManagerUserTest.uploadUserPhoto(data: picture)
        }.map { url in
            self.url = url
        }.then {
            self.firestoreFotoManagerUserTest.savePhotoUrlToFirestore(url: self.url, fotoPlace: position)
        }.done {
            _ = self.firestoreFotoManagerUserTest.saveStorageIds(fotoPlace: position)
        }.catch { error in
            print(error )
        }
        if position == 0 {
            print("eventChange aufgerufen")
            firstly {
                firestoreFotoManagerUserTest.changedProfilPicture(newProfilePicture: self.url)
            }.catch { error in
                print(error)
            }
        }
    }
    
    func deletePhoto(position: Int) {
        firstly {
            self.firestoreFotoManagerUserTest.deleteImageFromStorage(storageId: self.userModel.userPhotosId[position]!)
        }.then  {
            self.firestoreFotoManagerUserTest.deleteImageFromUser(fotoPlace: position)
        }.catch { error in
            print("DEBUG: error in deletePhoto error: \(error)")
            print("DEBUG: error localized: \(error.localizedDescription)")
        }
    }
    //eventModel.profilePicture = userModel.userPhotos[0]!
    
    func stopListening(){
        listener?.remove()
    }
}
       
            

        
 
