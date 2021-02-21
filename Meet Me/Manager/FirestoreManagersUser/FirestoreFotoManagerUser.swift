//
//FirestoreFotoManager.swift
//Meet Me
//
//Created by Lukas Dech on 11.02.21.
//
//
//Funktions Beschreibung
//
//- savePhoto()
// saved ein Event Model zur collection User
// wird aufgerufen in --> EventCreationViewModel

//- UploadUserPhoto()
// ladet alle Events des aktuellen Nutzers herunter und speichert alle im Array meEvents vom Typ EventModelObject
// wird aufgerufen in --> YouEventViewModel

//- savePhotoUrlToFirestore()
// return das Array meEvents welches von getMeEvent() objekte bekommt
// wird aufgerufen in --> YouEventViewModel

//- getAllPhotosFromUser()
// return das Array meEvents welches von getMeEvent() objekte bekommt
// wird aufgerufen in --> YouEventViewModel


import Foundation
import Firebase
import FirebaseFirestoreSwift
import URLImage


class FirestoreFotoManagerUser: ObservableObject {
    
    let storage = Storage.storage()
    private var db: Firestore
    @Published var photoModel: [PhotoModelObject] = []
    var stockPhotoModel: PhotoModel = PhotoModel()
    var url: URL?

     
    init() {
          db = Firestore.firestore()
    }
    

    
    
    // MARK: - Functions to save User Photos to Storage and the URL to Firestore

    // function is called inside the main code
    //in dem Paramter collection wird ein Document mit Url und User Id erstellt
    //paramter childfolder lädt das dokument in den Storage
    func savePhoto(originalImage: UIImage?, completion: @escaping (Bool) -> Void) {
        var completionFlag = false
        
        if let originalImage = originalImage {
            if let resizedImage = originalImage.resized(width: 360) {
                if let data = resizedImage.pngData() {
                    uploadUserPhoto(data:data) { (url) in
                        if let url = url {
                            self.savePhotoUrlToFirestore(url: url) { error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    completion(completionFlag)
                                } else {
                                    completionFlag = true
                                    completion(completionFlag)
                                }
                                
                                
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func uploadUserPhoto(data: Data, completion: @escaping (URL?) -> Void) {
        
        let imageName = UUID().uuidString
        let storageRef = storage.reference()
        let photoRef = storageRef.child("UserImages/\(imageName).png")
        
        photoRef.putData(data, metadata: nil) { metadata, error in
            
            if let err = error {
                print(err.localizedDescription)
            }
            photoRef.downloadURL { (url, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    completion(url)
                }
            }
        }
        
    }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func savePhotoUrlToFirestore(url: URL, completion: (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        do {
            let _ = try db.collection("users")
                .document(currentUser.uid)
                .collection("UserPhotos")
                .addDocument(from: PhotoModel(url: url.absoluteString, userId: currentUser.uid))
                completion(nil)
        } catch let error {
            completion(error)
        }
        
        
    }
    

    
    // MARK: - Functions to update Photos in the Storage
    
    
    
    
    // MARK: - Functions to dowload fotos or Url from Storage or firebase
    
    
    
    
    
    func getAllPhotosFromUser(completionHandler: @escaping (Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var flag = false
        db.collection("users")
            .document(currentUser.uid)
            .collection("UserPhotos")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { (snapshot,error) in
                if let error = error {
                    print(error.localizedDescription)
                    flag = false
                } else {
                    if let snapshot = snapshot {
                        let photoModel: [PhotoModelObject] = snapshot.documents.compactMap { doc in
                            var photoModel = try? doc.data(as: PhotoModel.self)
                            photoModel?.id = doc.documentID
                            if let photoModel = photoModel {
                                print(photoModel)
                                flag = true
                                return PhotoModelObject(photoModel: photoModel)
                            }
                            flag = false
                            return nil
                            
                        }
                        DispatchQueue.main.async {
                            self.photoModel = photoModel
                            completionHandler(flag)
                            
                        }
                    }
                }
            }
        
        
        
    }
 


}