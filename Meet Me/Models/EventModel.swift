//
//  EventModel.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.02.21.
//

import Foundation
import SwiftUI


// event model to define each event
struct EventModel: Codable {
    
    var eventId: String
    var userId: String
    var name: String
    var category: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var pictureURL: String
    var profilePicture: String
    var likedUser: Bool
    // event has matched user - event is closed
    var eventMatched: Bool
    
}

struct EventModelObject {
    
    let eventModel: EventModel
    
//    var eventId: String {
//        eventModel.eventId
//    }
    var eventId: String {
        eventModel.eventId
    }
    
    var userId: String {
        eventModel.userId
    }
    
    var name: String {
        eventModel.name
    }
    
    var category: String {
        eventModel.category
    }
    
    var date: Date {
        eventModel.date
    }
    
    var startTime: Date {
        eventModel.startTime
    }
    
    var endTime: Date {
        eventModel.endTime
    }
    
    var pictureURL: String {
        eventModel.pictureURL
    }
    
    var profilePicture: String {
        eventModel.profilePicture
    }
    var likedUser: Bool {
        eventModel.likedUser
    }
    var eventMatched: Bool {
        eventModel.eventMatched
    }
    
    
    @Binding var position: CGSize
    
}

