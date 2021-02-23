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
    
    // function is called inside the main code
    //in dem Paramter collection wird ein Document mit Url und User Id erstellt
    //paramter childfolder lädt das dokument in den Storage

    
    
    
    
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
    func savePhotoUrlToFirestore(url: URL) ->Promise<Void>{
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            
            do {
                let _ = try db.collection("users")
                    .document(currentUser.uid)
                    .collection("UserPhotos")
                    .addDocument(from: PhotoModel(url: url.absoluteString, userId: currentUser.uid))
                seal.fulfill(())
            } catch let error {
                seal.reject(error)
            }
        }
        
        
    }
    
    
    
    // MARK: - Functions to update Photos in the Storage
    
    
    
    
    // MARK: - Functions to dowload fotos or Url from Storage or firebase
    
    func getProfilePhoto() -> Promise<PhotoModel> {
        return Promise { seal in
            
        }
    }
    
    
    
    
    
    func getAllPhotosFromCurrentUser() ->Promise<[PhotoModelObject]> {
        return Promise { seal in
            
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
            db.collection("users")
            .document(currentUser.uid)
            .collection("UserPhotos")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { (snapshot,error) in
                if let error = error {
                    print(error.localizedDescription)
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        let photoModel: [PhotoModelObject] = snapshot.documents.compactMap { doc in
                            var photoModel = try? doc.data(as: PhotoModel.self)
                            photoModel?.id = doc.documentID
                            if let photoModel = photoModel {
                                return PhotoModelObject(photoModel: photoModel)
                            }
                            return nil
                            
                        }
                        DispatchQueue.main.async {
                            seal.fulfill(photoModel)
                            
                        }
                    }
                }
            }
        }
                        
    }
    
    func getAllPhotosFromEventUser(eventModel: EventModel) ->Promise<[PhotoModelObject]> {
        return Promise { seal in
            
            db.collection("users")
                .document(eventModel.userId)
            .collection("UserPhotos")
                .whereField("userId", isEqualTo: eventModel.userId)
            .getDocuments { (snapshot,error) in
                if let error = error {
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        let photoModel: [PhotoModelObject] = snapshot.documents.compactMap { doc in
                            var photoModel = try? doc.data(as: PhotoModel.self)
                            photoModel?.id = doc.documentID
                            if let photoModel = photoModel {
                                return PhotoModelObject(photoModel: photoModel)
                            }
                            return nil
                            
                        }
                        DispatchQueue.main.async {
                            seal.fulfill(photoModel)
                            
                        }
                    }
                }
            }
        }
                        
    }
}
