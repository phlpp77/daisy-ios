//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class EventCreationViewModel: ObservableObject {
    
    private var firestoreFotoManager: FirestoreFotoManager = FirestoreFotoManager()
    private var fireStoreManagerEvent: FireStoreManagerEvent
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    
    var userId: String = "111"
    var name: String = "Nice Event"
    var eventId: String = "222"
    var category: String = "Café"
    var date: Date = Date()
    var startTime: Date = Date ()
    var endTime: Date = Date() + 30 * 60
    var pictureURL: URL = stockURL
    let storage = Storage.storage()
    

    init() {
        fireStoreManagerEvent = FireStoreManagerEvent()
    }
    
    func saveEventSettings() {
        
        //get foto url for Event
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        firestoreFotoManager.getAllPhotosFromUser(collection:"EventPhotos", completionHandler: { success in
            if success {
                // yeah picture
                
                
                let url = URL(string: self.firestoreFotoManager.photoModel[0].url)!
                //print("PHOTO: right url load by savin event URL: \(url)")
                
                
                self.pictureURL = url
                //print("PHOTO: pictureURL at the moment: \(self.pictureURL)")
                
            } else {
                //print("stockUrl load by saving event")
                self.pictureURL = stockURL
            }
            
        })
        
        
        
        
        //Start to Save Event
        let eventModel = EventModel(eventId: eventId, userId: currentUser.uid, name: name, category: category, date: date, startTime: startTime, endTime: endTime, pictureURL: pictureURL)
        
        fireStoreManagerEvent.saveEvent(eventModel: eventModel){ result in
            switch result {
            case .success(let eventModel):
                DispatchQueue.main.async {
                    
                    //print("PHOTO: in eventModel \(self.pictureURL)")
                    self.saved = eventModel == nil ? false: true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self .message = ErrorMessages.eventSaveFailed
                }
                
            
            }
        }
    }

}
//
//    func getEventPictureURL() -> URL{
//        firestoreFotoManager.getAllPhotosFromUser(collection:"EventPhotos", completionHandler: { success in
//            if success {
//                // yeah picture
//
//
//                let url = URL(string: self.firestoreFotoManager.photoModel[0].url)!
//                return url
//
//            } else {
//                // ohh, no picture
//                return stockURL
//            }
//
//        })
//    }
//}






