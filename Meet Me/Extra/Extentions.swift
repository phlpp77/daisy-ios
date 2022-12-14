//
//  Extentions.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import Foundation
import SwiftUI

// MARK: Extension to add a gradient as a foreground (the actual shape of a view), works with Text as well
extension View {
    public func gradientForeground(gradient: LinearGradient) -> some View {
        self.overlay(gradient)
            .mask(self)
    }
}

// MARK: Extension to add a tap Gesture to a Spacer
extension Spacer {
    public func onTapGesture(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        ZStack {
            Color.black.opacity(0.001).onTapGesture(count: count, perform: action)
            self
        }
    }
}
