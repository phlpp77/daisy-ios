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
            //ProfileCreationView(profileCreationFinished: .constant(false))
            
//            Copy into if for autologin
//            ||  autoLogin()
            if startProcessDone ||  autoLogin() {

                MainControllerView()

            } else {
                StartView(startProcessDone: $startProcessDone)
                    .ignoresSafeArea(.keyboard, edges: .bottom)

            }

            //PickerView()
        }
    }
    
    func autoLogin() -> Bool{
        if Auth.auth().currentUser != nil {
            print("login successfully")
            return true
            
            
        } else {
            print("no user")
            return false
        }
    }
    
    
    
}
  
