//
//  ProfileCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 24.01.21.
//

import SwiftUI

struct ProfileCreationView: View {
    
    // MARK: - state vars
    
    // var for the name of the profile owner
    @State var name = ""
    
    // var for the gender of the profile owner
    @State var gender = ""
    
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
                    VStack {
                        Text("Verrate uns doch ein paar Infos über dich.")
                            .font(.largeTitle)
                    }
                    VStack {
                        // view to fill in the name
                        NameLineView(name: $name)
                        
                        Spacer()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        GenderLineView(gender: $gender)
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

struct NameLineView: View {
    
    // Binding from main View
    @Binding var name: String
    
    var body: some View {
        HStack {
            Text("Name")
            TextField("", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 35)
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .leading)
    }
}

struct GenderLineView: View {
    
    // Binding from main View
    @Binding var gender: String
    
    var body: some View {
        HStack {
            Text("Gender")
            TextField("", text: $gender)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 35)
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .trailing)
    }
}
