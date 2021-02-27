//
//  MessageModel.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import Foundation
import SwiftUI

struct MessageModel: Codable {
    var messageId: UUID = UUID()
    var creator: String = "CreatoRR"
    var receiver: String = "ReceiveRR"
    var text: String = "Test Message!"
}
