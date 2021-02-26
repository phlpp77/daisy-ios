//
//  LogoutView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 24.02.21.
//

import SwiftUI
import FirebaseAuth

struct LogoutView: View {
    
    @Binding var startProcessDone: Bool
    
    var body: some View {
        Button("Logout") {
            
            
            do {
                try Auth.auth().signOut()
            } catch { let error = error
                print(error.localizedDescription)
            }
            startProcessDone = false
            
        }
        .padding()
        .modifier(FrozenWindowModifier())
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(startProcessDone: .constant(true))
    }
}
