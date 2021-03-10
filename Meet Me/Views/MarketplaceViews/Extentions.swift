//
//  Extentions.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import Foundation
import SwiftUI

extension View {
    public func gradientForeground(gradient: LinearGradient) -> some View {
        self.overlay(gradient)
            .mask(self)
    }
}
