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
    
    @State var startProcessDone: Bool = false
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if startProcessDone {
                MainControllerView()
            } else {
                StartView(startProcessDone: $startProcessDone)
            }
//            ProfileCreationView()
//            PickerView()
        }
    }
}
