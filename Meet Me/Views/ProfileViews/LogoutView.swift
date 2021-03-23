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
    
    @Binding var startProcessDone: Bool
    
    var body: some View {
        
        Button(action: {
            logoutVM.authSignOut().done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                print("now logout")
                startProcessDone = false
                }
            }.catch { error in
                print("DEBUG: error by Logout error: \(error)")
        }
        }, label: {
            Text("Logout")
        })
        .padding()
        .modifier(FrozenWindowModifier())
            
        }
        
    }


struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(startProcessDone: .constant(true))
    }
}
