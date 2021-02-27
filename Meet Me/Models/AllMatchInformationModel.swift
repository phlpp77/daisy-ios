//
//  AllMatchInformationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.02.21.
//

import Foundation

struct AllMatchInformationModel: Codable {

//All User Informations
    var userId: String
    var name: String
    var birthdayDate: Date = Date()
    var gender: String
    var searchingFor: String
    var userPhotos: [Int: String]
    
 //All Event Informations
    var eventId: String
    var category: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var pictureURL: String
    var profilePicture: String
}

