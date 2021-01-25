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
    
    // var for the birthday date of the profile owner
    @State var birthdayDate = ""
    
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
                    ScrollView {
                        // view to fill in the name
                        NameLineView(name: $name)
                        
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        GenderLineView(gender: $gender)
                        
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .rotation3DEffect(
                                Angle(degrees: 180),
                                axis: (x: 0, y: 1.0, z: 0.0)
                            )
                        
                        BirthdayLineView(birthdayDate: $birthdayDate)
                        
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        
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
            TextField("", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 35)
            Text("Name")
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

struct BirthdayLineView: View {
    
    // Binding from main View
    @Binding var birthdayDate: String
    
    var body: some View {
        HStack {
            TextField("", text: $birthdayDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 35)
            Text("Birthday")
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .leading)
    }
}
