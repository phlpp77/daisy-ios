//
//  LogoutView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 24.02.21.
//

import SwiftUI
import FirebaseAuth
import PromiseKit

struct LogoutView: View {
    @ObservedObject var logoutVM: LogoutViewModel = LogoutViewModel()
    @ObservedObject private var firstActions = FirstActions()
    var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    @Binding var startProcessDone: Bool
    @Binding var showCheck: Bool
    
    var body: some View {
        
        Button(action: {
            firstActions.firstViews["FirstEventShuffle"] = false
            firstly {
                self.firestoreManagerUserTest.deletePushNotificationTokenFromUser()
            }.then {
                logoutVM.authSignOut()
            }.done {
                print("logout database done")
                
                startProcessDone = false
                print("startProcessDone changed to: \(startProcessDone)")
                
                showCheck = true
            }.catch { error in
                print(error)
            }
            
        }, label: {
            Text("Logout")
                .padding()
                .modifier(FrozenWindowModifier())
        })
    }
}


struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(startProcessDone: .constant(true), showCheck: .constant(true))
    }
}
