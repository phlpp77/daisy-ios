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
    //@ObservedObject private var meet_MeAppVM: Meet_MeAppViewModel = Meet_MeAppViewModel()

    
    init() {
        FirebaseApp.configure()

    }

    
    var body: some Scene {
        
        WindowGroup {
            
            //ProfileCreationView(profileCreationFinished: .constant(false))
            //meet_MeAppVM.CheckUserAccForAutoLogin()
//            Copy into if for autologin
//            ||  autoLogin()
            if startProcessDone || checkUserAccForAutoLogin() {

                MainControllerView()

            } else {
                StartView(startProcessDone: $startProcessDone)
                    .ignoresSafeArea(.keyboard, edges: .bottom)

            }

            //PickerView()
        }
    }
    
    func checkUserAccForAutoLogin() -> Bool{
        if Auth.auth().currentUser != nil{
            return true
            
        } else {
            return false

        }
    }
    

    
    
    
}
  
