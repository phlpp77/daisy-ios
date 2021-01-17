//
//  StartBackgroundView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct StartBackgroundView: View {
    
//    // states for animation
    @State var showAnimation = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundSecondary"), Color("BackgroundSecondary").opacity(0.7)]), startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea()
                .onAppear {
                    showAnimation = true
                }
            
            // Circle animation
            ZStack {
                Circle()
                    .foregroundColor(.accentColor)
                    .blendMode(.softLight)
                    .scaleEffect(showAnimation ? 1.2 : 0.8)
                    .offset(x: showAnimation ? 130 : 0, y: showAnimation ? 300 : -20)
                
                Circle()
                    .foregroundColor(Color("BackgroundOptional")).opacity(0.6)
                    .scaleEffect(showAnimation ? 1.2 : 1)
                    .offset(x: showAnimation ? -130 : 100, y: showAnimation ? -60 : 100)
            }
            .animation(Animation.linear(duration: 30).repeatForever())
        }
    }
}

struct StartBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        StartBackgroundView()
    }
}
