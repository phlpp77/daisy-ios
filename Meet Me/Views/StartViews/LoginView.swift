//
//  RegisterView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct LoginView: View {
    
    
    //Sobald login gedrückt wurde und Erfolgreich war wird die Variable True
    @State var isActive: Bool = false
    @ObservedObject private var loginVM = LoginViewModel()
    
    // change the var for the main animation
    @Binding var userIsLoggedIn: Bool
    
    
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
                        TextField("Gebe deine E-Mail Adresse ein", text: $loginVM.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                    }
                    .padding(.bottom, 3)
                    
                    Divider()
                    
                    // main password textField
                    HStack(spacing: 12) {
                        Image(systemName: "lock.shield")
                        SecureField("Gebe dein Passwort ein", text: $loginVM.password)
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
                    loginVM.login {
                        isActive = true
                        print("Login erfolgreich \(isActive)")
                        userIsLoggedIn = true
                        
                    }
                    
                    
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
        LoginView(userIsLoggedIn: .constant(false))
    }
}
