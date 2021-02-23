//
//  Err.swift
//  Meet Me
//
//  Created by Lukas Dech on 23.02.21.
//

import Foundation

struct Err: Error {
    let message: String
    init(_ message: String) {
    self.message = message
    }
}
