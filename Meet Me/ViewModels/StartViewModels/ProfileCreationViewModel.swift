//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import PromiseKit

class ProfileCreationModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest
    private var firestoreFotoMangerUserTest: FirestoreFotoManagerUserTest
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var userId: String = ""
    var name: String = "Name"
    var birthdayDate: Date = Date()
    var gender: String = "Gender"
    var searchingFor: String = ""
    var startProcessDone: Bool = true
    
    let storage = Storage.storage()
    
    
    init() {
        firestoreManagerUserTest = FirestoreManagerUserTest()
        firestoreFotoMangerUserTest = FirestoreFotoManagerUserTest()
    }
    
//    func saveUserSettings() {
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        let userModel = UserModel(userId: currentUser.uid, name: name, birthdayDate: birthdayDate, gender: gender, startProcessDone: startProcessDone, searchingFor : searchingFor)
//        firestoreManagerUser.saveUser(userModel: userModel){ result in
//            switch result {
//            case .success(let userModel):
//                DispatchQueue.main.async {
//                    self.saved = userModel == nil ? false: true
//                }
//            case .failure(_):
//                DispatchQueue.main.async {
//                    self .message = ErrorMessages.userSaveFailed
//                }
//
//
//            }
//        }
//    }
    
    func createUser(originalImage: UIImage, bDate: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        self.birthdayDate = convertStringToDate(date: bDate)
        
        let userModel = UserModel(userId: currentUser.uid, name: name, birthdayDate: birthdayDate, gender: gender, startProcessDone: startProcessDone, searchingFor : searchingFor)
        
        firstly {
            self.firestoreManagerUserTest.saveUser(userModel: userModel)
        }.then { userModel in
            self.firestoreFotoMangerUserTest.resizeImage(originalImage: originalImage)
        }.then { picture in
            self.firestoreFotoMangerUserTest.uploadUserPhoto(data: picture)
        }.then { url in
            self.firestoreFotoMangerUserTest.savePhotoUrlToFirestore(url: url)
        }.done {
            print("DEBUG: done, User Creation erfolgreich")
        }.catch { error in
            print("DEBUG: catch, fehler in event creation \(error)")
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_DE")
        dateFormatter.dateFormat = "dd/MM/y"
        
        let date = dateFormatter.date(from: date)!
        return date
    }

}
