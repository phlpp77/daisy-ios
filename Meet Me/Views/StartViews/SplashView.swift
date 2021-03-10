//
//  SplashView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.03.21.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var currentPosition: StartPosition
    
    var body: some View {
        
        VStack {
            HStack(spacing: 0) {
                Text("Hello, ")
                Text("Nameless")
                    .foregroundColor(.accentColor)
                Text(".")
            }
            .font(.title)
            
            Text("Do you want to meet new people?")
                .font(.subheadline)
        }
        .padding()
        .modifier(offWhiteShadow(cornerRadius: 12))
        .onTapGesture {
            
            // FIXME: Change this to .onbaording when the onboarding process is implemented
            self.currentPosition = .registerLogin
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(currentPosition: .constant(.splash))
    }
}
