//
//  MatchModelTest.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import Foundation
import SwiftUI

struct MatchModelTest: Codable {
    var matchId: UUID = UUID()
    
    var users: [UserModel] = [stockUser, stockUser2]
    
    var events: [EventModel] = [stockEvent, stockEvent]
}
