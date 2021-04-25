//
//  UpdateAppScreen.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 25.04.21.
//

import SwiftUI

struct UpdateAppScreen: View {
    
    @Binding var newVersion: String
    
    var body: some View {
        VStack {
            VStack {
                Text("DAISY")
                    .gradientForeground(gradient: secondaryGradient)
                Text("New version available!")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 20))
            }
            .font(.system(size: 75))
            
            Text("Update now to version \(newVersion) to get the latest features. Just check the AppStore for the Update.")
                .font(.body)
                .padding(.bottom, 40)
                .padding(.top, 20)
            
            LoadingView(showLoadingScreen: .constant(true))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundMain"))
        .ignoresSafeArea()
    }
}


struct UpdateAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdateAppScreen(newVersion: .constant("1.3"))
    }
}
