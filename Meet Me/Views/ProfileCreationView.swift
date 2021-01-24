//
//  ProfileCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 24.01.21.
//

import SwiftUI

struct ProfileCreationView: View {
    
    // MARK: - state vars
    @State var name = ""
    
    
    var body: some View {
        ZStack {
            // background with animation
            StartBackgroundView()
            
            // box where all items are in with fixed size
            ZStack {
                Color.clear
                    .frame(width: 340, height: 620, alignment: .center)
                    .modifier(FrozenWindowModifier())
                
                VStack {
                    Text("Verrate uns doch ein paar Infos über dich.")
                        .font(.largeTitle)
                    HStack {
                        Text("Name")
                        TextField("Name hier eingeben", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.horizontal, 16)
                // bring the content VStack to the same size as the background shade
                .frame(width: 340, height: 620, alignment: .center)
            }
        }
    }
}

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationView()
//            .previewDevice("iPhone 8")
    }
}
