////
////  FirestoreFotoManager.swift
////  Meet Me
////
////  Created by Lukas Dech on 11.02.21.
////
//
import Foundation
import Firebase
import FirebaseFirestoreSwift
//
//enum LoadingState {
//    case idle
//    case loading
//    case success
//    case failure
//}
//
//
class FirestoreFotoManager: ObservableObject {
    
    
     private var showImagePicker: Bool = false
//     private var image: Image? = nil
     private var originalImage: UIImage? = nil
     private var name: String = ""
     private var showActionSheet: Bool = false
     private var sourceType: SourceType = .photoLibrary
//
   let storage = Storage.storage()
//    let db = Firestore.firestore()
//    @Published var fungi: [ProfileCreationModel] = []
//    @Published var loadingState: LoadingState = .idle
//
//
//
//    func getAllFungiForUser(){
//
//        DispatchQueue.main.async {
//            self.loadingState = .loading
//        }
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        db.collection("users")
//            .whereField("userId", isEqualTo: currentUser.uid)
//            .getDocuments { [weak self] (snapshot, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    DispatchQueue.main.async {
//                        self?.loadingState = .failure
//                    }
//                } else {
//                    if let snapshot = snapshot {
//                        let fungi: [ProfileCreationModel] = snapshot.documents.compactMap { doc in
//                            var fungi = try? doc.data(as: UserModel.self)
//                            fungi?.id = doc.documentID
//                            if let fungi = fungi {
//                                return FungiViewModel(fungi: fungi)
//                            }
//                            return nil
//                        }
//                        DispatchQueue.main.async {
//                            self?.fungi = fungi
//                            self?.loadingState = .success
//
//                        }
//                    }
//                }
//            }
//
//    }
//
//    func save(name: String, url: URL, completion: (Error?) -> Void) {
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        do {
//            let _ = try  db.collection("users")
//                .addDocument(from: UserModel(name: name, url: url.absoluteString, userId: currentUser.uid))
//                completion(nil)
//        } catch let error {
//            completion(error)
//        }
//
//    }
  func uploadPhoto(data: Data, completion: @escaping (URL?) -> Void) {
        //create unique image names
       let imageName = UUID().uuidString
        //reference to Storage
        let storageRef = storage.reference()
        //access to photo ref
        let photoRef = storageRef.child("UserImages/\(imageName).png")
        
       //Upload the data and get the url
       photoRef.putData(data, metadata: nil) { metadata, error in
            photoRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                   completion(url)
                }
            }
        }

    }

//    private func savePhoto() {
//
//        DispatchQueue.main.async {
//            fungiListVM.loadingState = .loading
//        }
//
//
//        if let originalImage = originalImage {
//            if let resizedImage = originalImage.resized(width: 1024) {
//                if let data = resizedImage.pngData() {
//                    fungiListVM.uploadPhoto(data: data) { (url) in
//                        if let url = url {
//                            fungiListVM.save(name: name, url: url) {error in
//                                if let error = error {
//                                    print(error.localizedDescription)
//                                } else {
//                                    DispatchQueue.main.async {
//                                        fungiListVM.loadingState = .success
//                                    }
//                                    fungiListVM.getAllFungiForUser()
//                                }
//                                image = nil
//                            }
//                        }
//
//                    }
//                }
//
//            }
//        }
//    }
//
//}
}
