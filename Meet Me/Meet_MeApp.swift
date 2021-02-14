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
//    private var Meet_MeAppVM: Meet_MeAppViewModel = Meet_MeAppViewModel()

    
    init() {
        FirebaseApp.configure()

    }

    
    var body: some Scene {
        
        WindowGroup {
            //ProfileCreationView(profileCreationFinished: .constant(false))
            
//            Copy into if for autologin
//            ||  autoLogin()
            if startProcessDone {

                MainControllerView()

            } else {
                StartView(startProcessDone: $startProcessDone)
                    .ignoresSafeArea(.keyboard, edges: .bottom)

            }

            //PickerView()
        }
    }
    

    
    
    
}
  
