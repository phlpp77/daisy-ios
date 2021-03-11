//
//  FirestoreFotoManagerUserTest.swift
//  Meet Me
//
//  Created by Lukas Dech on 22.02.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import URLImage
import PromiseKit


class FirestoreFotoManagerUserTest: ObservableObject {
    
    let storage = Storage.storage()
    private var db: Firestore
    //@Published var photoModel: [PhotoModelObject] = []
//    var stockPhotoModel: PhotoModel = PhotoModel()
//    var url: URL?
    
    
    init() {
        db = Firestore.firestore()
    }
    
    
    // MARK: - Functions to save User Photos to Storage and the URL to Firestore
    

    
    
    func resizeImage(originalImage: UIImage?) -> Promise<Data> {
        return Promise { seal in
            if let originalImage = originalImage {
                    if let resizedImage = originalImage.resized(width: 360) {
                        if let data = resizedImage.pngData() {
                            seal.fulfill(data)
                        }
                    }
                }
            }
            
        }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func uploadUserPhoto(data: Data) -> Promise<URL> {
        return Promise { seal in

//            guard let currentUser = Auth.auth().currentUser else {
//                return
//            }
            
            let imageName = UUID().uuidString
            let storageRef = storage.reference()
            let photoRef = storageRef.child("UserImages/\(imageName).png")
            
            photoRef.putData(data, metadata: nil) { metadata, error in
                
                if let err = error {
                    seal.reject(err)
                }
                photoRef.downloadURL { (url, error) in
                    
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(url!)
                    }
                }
            }
            }
            
        }

        
    
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func savePhotoUrlToFirestore(url: URL, fotoPlace: Int) ->Promise<Void>{
        return Promise { seal in

            
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
                let _ =  db.collection("users")
                    .document(currentUser.uid).updateData(["userPhotos.\(fotoPlace)" : url.absoluteString])
                seal.fulfill(())
            }

        }
    
    
    func changedProfilPicture(newProfilePicture: URL) ->Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                throw Err("No User Profile")
            }
            db.collection("events").whereField("userId", isEqualTo: currentUser.uid).getDocuments{ (snapshot, error) in
                if let error = error {
                    seal.reject(error)
                } else {
                    let ids: [String]! = snapshot?.documents.compactMap { doc in
                        return doc.documentID
                    }
                    for id in ids {
                        self.db.collection("events").document(id).updateData(["profilePicture" : newProfilePicture.absoluteString])
                    }
                    seal.fulfill(())
                    
                }
            }

        }
        
    }
    
    func deleteImageFromStorage(fotoPlace: Int) ->Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            let storageRef = storage.reference()
            let photoRef = storageRef.child("UserImages/\(currentUser.uid + String(fotoPlace)).png")
            
            photoRef.delete { error in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    
    func deleteImageFromUser(fotoPlace: Int) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            
            let _ = db.collection("users").document(currentUser.uid)
                .updateData(["userPhotos.\(fotoPlace)" : FieldValue.delete()]) { error in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(())
                    }
                }
        }
    }
}
    


        
    
    
    
    
