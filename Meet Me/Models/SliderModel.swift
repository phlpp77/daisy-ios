//
//  SliderModel.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.03.21.
//

import Foundation
import SwiftUI

struct SliderModel: Codable {
    
    var headerText: String = "Do you know that?"
    var highlight: Bool = false
    var footerText: String = ""
    var image: String = "Chat-Boring"
    var sfSymbol: String = "bubble.left.and.bubble.right.fill"
    var buttonText: String = "YES"
    
}
