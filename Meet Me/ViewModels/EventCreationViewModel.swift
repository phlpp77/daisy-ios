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
    
    private var fireStoreManagerEvent: FireStoreManagerEvent
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    
    var userId: String
    var name: String
    var eventId: String
    var category: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var pictureURL: URL
    let storage = Storage.storage()
    
    
    init() {
        fireStoreManagerEvent = FireStoreManagerEvent()
    }
    
    func saveEventSettings() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let eventModel = EventModel(eventId: eventId, userId: currentUser.uid, name: name, category: category, date: date, startTime: startTime, endTime: endTime, pictureURL: pictureURL)
        fireStoreManagerEvent.saveEvent(eventModel: eventModel){ result in
            switch result {
            case .success(let eventModel):
                DispatchQueue.main.async {
                    self.saved = eventModel == nil ? false: true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self .message = ErrorMessages.EventSaveFailed
                }
                
            
            }
        }
    }

}



