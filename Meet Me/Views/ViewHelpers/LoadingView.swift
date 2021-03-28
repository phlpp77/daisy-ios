//
//  LoadingView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 18.02.21.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var showLoadingScreen: Bool
    
    var body: some View {
        
        if showLoadingScreen {
            LottieView(filename: "pacman-loading", loopMode: .loop)
                .frame(width: 150, height: 150, alignment: .center)
                .padding()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(showLoadingScreen: .constant(true))
    }
}
