//
//  StartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct StartView: View {
    
    // animation to show the second line of text after the used read the first line
    @State var showSecondLine = false
    
    var body: some View {
        
        ZStack {
            
            // apply backgroundcolor
            StartBackgroundView()
            
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Text("Hallo, ")
                    Text("Namenloser")
                        .foregroundColor(.accentColor)
                    Text(".")
                }
                .font(.title)
                // animation starts with a time delay
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showSecondLine = true
                    }
                }
                Text(showSecondLine ? "Willst du neue Leute kennenlernen?" : "")
                    .multilineTextAlignment(.leading)
                    
            }
            .padding()
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(25)
            .shadow(color: Color("BackgroundSecondary").opacity(0.3), radius: 20, x: 10, y: 10)
            .animation(.easeInOut(duration: 1.0))
        }
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
