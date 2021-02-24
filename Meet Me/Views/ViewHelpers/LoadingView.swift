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
            LottieView(filename: "planet-loading", loopMode: .loop)
                .frame(width: 100, height: 100, alignment: .center)
        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(showLoadingScreen: .constant(true))
    }
}
