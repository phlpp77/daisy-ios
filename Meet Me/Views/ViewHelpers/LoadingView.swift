//
//  LoadingView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 18.02.21.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        LottieView(filename: "planet-loading", loopMode: .loop)
            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
