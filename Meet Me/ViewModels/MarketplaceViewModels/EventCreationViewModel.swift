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


class EventCreationViewModel: ObservableObject {
    

    @Published var saved: Bool = false
    @Published var message: String = ""
    
    private var firestoreFotoManagerEventTest: FirestoreFotoManagerEventTest
    private var firestoreManagerEventTest: FirestoreManagerEventTest
    private var firestoreManagerUserTest: FirestoreManagerUserTest
    
    
    var userId: String = "111"
    var name: String = "Nice Event"
    var eventId: String = "222"
    var category: String = "Café"
    var date: Date = Date()
    var startTime: Date = Date ()
    var endTime: Date = Date() + 30 * 60
    var pictureURL: String = ""
    let storage = Storage.storage()
    

    init() {
        firestoreFotoManagerEventTest = FirestoreFotoManagerEventTest()
        firestoreManagerEventTest = FirestoreManagerEventTest()
        firestoreManagerUserTest = FirestoreManagerUserTest()
    }


    func saveEvent(uiImage: UIImage) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let eventId = UUID().uuidString
        var eventModel = EventModel(eventId: eventId, userId: currentUser.uid, name: name, category: category, date: date, startTime: startTime, endTime: endTime, pictureURL:"", profilePicture: "")
        

            firstly{
                self.firestoreManagerUserTest.getCurrentUser()
            }.map { userModel in
                eventModel.profilePicture = userModel.userPhotos[1]!
            }.then {
                self.firestoreManagerEventTest.saveEvent(eventModel: eventModel, eventId: eventId)
            }.then {
                self.firestoreManagerEventTest.createLikedUserArray(eventId: eventId)
            }.then {
                self.firestoreFotoManagerEventTest.resizeImage(originalImage: uiImage)
            }.then { picture in
                self.firestoreFotoManagerEventTest.uploadEventPhoto(data: picture)
            }.then { url in
                self.firestoreFotoManagerEventTest.saveEventPhotoUrlToFirestore(url: url, eventId: eventId)
            }.done {
                print("DEGUB: done, EventCreationChain erfolgreich")
            }.catch { error in
                print("DEBUG: catch, Fehler in EventCreationChain\(error)")
                print(error.localizedDescription)
            }
        
        
    }
}





