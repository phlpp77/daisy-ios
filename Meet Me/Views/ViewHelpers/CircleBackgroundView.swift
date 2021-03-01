//
//  CircleBackgroundView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 28.02.21.
//

import SwiftUI

struct CircleBackgroundView: View {
    
    @State var showAnimation = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundOptional"), Color("BackgroundSecondary")]), startPoint: .trailing, endPoint: .top)
            
            Image("Circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .position(x: screen.width / 2, y: 500)
                
                .frame(width: 1000, height: 1000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(showAnimation ? .zero : .degrees(360))
//                .animation(
//                    Animation.linear(duration: 5)
//                        .repeatForever(autoreverses: false)
//                )
            
//            LinearGradient(gradient: Gradient(colors: [Color("BackgroundOptional"), Color("BackgroundSecondary")]), startPoint: .trailing, endPoint: .top)
//                .frame(width: screen.width, height: screen.height * 0.8, alignment: .bottom)
//                .frame(maxHeight: .infinity, alignment: .bottom)
            
//            Circle()
//                .background(Color.blue)
//                .frame(width: 100, height: 100, alignment: .center)
            
            // Test
            Text("Dies ist ein Test")
                .frame(width: screen.width, height: screen.height, alignment: .top)
                .padding()
                .background(Color.white.opacity(0.2))
                .background(BlurView(style: .systemUltraThinMaterial))
//                .background(Color.white.opacity(0.4)
//                                .blur(radius: 0.5, opaque: false))
                
                .overlay(
                    RoundedRectangle(cornerRadius: 18.0, style: .continuous)
                        .stroke(Color.white.opacity(0.6), lineWidth: 1)
                )
                // new shape to RoundedRectangle
                .clipShape(RoundedRectangle(cornerRadius: 18.0, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            
            Text("This is a damn test")
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .onAppear {
            showAnimation = true
        }
    }
}

struct CircleBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CircleBackgroundView()
    }
}
