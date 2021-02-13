//
//  UserModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 25.01.21.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    var id: String?
    var userId: String?
    var name: String
    var birthdayDate: Date
    var gender: String
    var startProcessDone: Bool = true
    var searchingFor: String
    var url: String = ""
    
    

}
