//
//  RegisterView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
//            StartBackgroundView()
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    Image("login")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 20)
                        .padding(.leading, 80)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "envelope")
                        TextField("Gebe deine E-Mail Adresse ein", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                    }
                    .padding(.bottom, 3)
                    
                    Divider()
                    
                    // main password textField
                    HStack(spacing: 12) {
                        Image(systemName: "lock.shield")
                        SecureField("Gebe dein Passwort ein", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                    }
                    .padding(.top, 3)
                    
                }
                .font(.subheadline)
                .foregroundColor(.accentColor)
                .padding()
                .modifier(FrozenWindowModifier())
                .animation(.easeInOut)
                .frame(maxHeight: .infinity)
                .frame(width: screen.width - 40)

                Spacer()
                
                // login button
                Button(action: {
                    // haptic feedback when button is tapped
                    hapticPulse(feedback: .rigid)
                    // type login function here
                    
                    
                }, label: {
                    HStack {
                        Text("Login!")
                            .foregroundColor(.primary)
                        Image(systemName: "person.fill.checkmark")
                    }
                })
                .padding()
                .modifier(FrozenWindowModifier())
//                .offset(y: 200)
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
