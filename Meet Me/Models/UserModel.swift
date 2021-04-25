//
//  UserModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 25.01.21.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    
    var userId: String = ""
    var name: String = ""
    var birthdayDate: Date = Date()
    var gender: String = ""
    var startProcessDone: Bool = true
    var searchingFor: String = ""
    var userPhotos: [Int: String]
    var userPhotosId: [Int: String]
    var radiusInKilometer: Double
    var refreshCounter: Int
    var userStatus: String
    var reports: Int
    var loginToken: String
    var lastLogin: String
    
}


