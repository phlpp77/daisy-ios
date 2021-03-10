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
    private var images: [Data]?
    //@Published var photoModel: [PhotoModelObject] = []
//    var stockPhotoModel: PhotoModel = PhotoModel()
//    var url: URL?
    
    
    init() {
        db = Firestore.firestore()
    }
    
    
    // MARK: - Functions to save User Photos to Storage and the URL to Firestore
    

    
    
    func resizeImage(originalImages: [UIImage]?) -> Promise<[Data]> {
        return Promise { seal in
            if let originalImages = originalImages {
                for originalImage in originalImages {
                    if let resizedImage = originalImage.resized(width: 360) {
                        if let data = resizedImage.pngData() {
                            images?.append(data)
                        }
                    }
                }
                seal.fulfill(images!)
            }
            
        }
    }
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func uploadUserPhoto(data: [Data]) -> Promise<[URL]> {
        return Promise { seal in
        var urls: [URL] = []
        let imageName = UUID().uuidString
        let storageRef = storage.reference()
        let photoRef = storageRef.child("UserImages/\(imageName).png")
            for ref in data {
                photoRef.putData(ref, metadata: nil) { metadata, error in
                    
                    if let err = error {
                        seal.reject(err)
                    }
                    photoRef.downloadURL { (url, error) in
                        
                        if let error = error {
                            seal.reject(error)
                        } else {
                            urls.append(url!)
                        }
                    }
                }
            }
            seal.fulfill(urls)

        }
        
        
    }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func savePhotoUrlToFirestore(url1: URL?, url2: URL?, url3: URL?) ->Promise<Void>{
        return Promise { seal in
           
            guard let currentUser = Auth.auth().currentUser else {return}
            if  url1 != nil {
                let _ =  db.collection("users")
                    .document(currentUser.uid).updateData(["userPhotos.1" : url1!.absoluteString]){ error in
                        if let error = error {
                            seal.reject(error)
                        }
                    }
            }
            
            if url2 != nil {
                let _ =  db.collection("users")
                    .document(currentUser.uid).updateData(["userPhotos.2" : url2!.absoluteString]){ error in
                        if let error = error {
                            seal.reject(error)
                        }
                    }
            }
            
            if url3 != nil {
                let _ =  db.collection("users")
                    .document(currentUser.uid).updateData(["userPhotos.3" : url3!.absoluteString]){ error in
                        if let error = error  {
                            seal.reject(error)
                        }
                    }
                
                
            }
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
}


        
    
    
    
    
