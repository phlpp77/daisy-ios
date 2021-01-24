//
//  Meet_MeApp.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.01.21.
//
//
import SwiftUI
import Firebase

@main
struct Meet_MeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}
