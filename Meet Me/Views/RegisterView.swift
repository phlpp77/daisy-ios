//
//  RegisterView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email = ""
    @State var password = ""
    @State var password2 = ""
    
    @State var showSecondPasswordTextField = false
    
    var body: some View {
        ZStack {
//            StartBackgroundView()
            
            VStack {
                VStack(alignment: .leading) {
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
                        SecureField("Suche dir ein Passwort aus", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                showSecondPasswordTextField = true
                            }
                            
                    }
                    .padding(.top, 3)
                    
                    Divider().opacity(showSecondPasswordTextField ? 1 : 0)
                        .padding(.leading, 32)
                    
                    // retype password textField
                    HStack(spacing: 12) {
                        Image(systemName: "goforward")
                        SecureField("Wiederhole dein Passwort", text: $password2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(height: showSecondPasswordTextField ? 40 : 0)
                    .opacity(showSecondPasswordTextField ? 1 : 0)
                    
                    // have account button
                    Button(action: {
                        // type "have account" func here -> to login screen
                        
                    }) {
                        Text("Ich habe schon einen Account")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 32)
                    
                }
                .font(.subheadline)
                .foregroundColor(.accentColor)
                .padding()
                .modifier(FrozenWindowModifier())
                .animation(.easeInOut)
                .frame(maxHeight: .infinity)
                .frame(width: screen.width - 40)

                Spacer()
                
                // register button
                Button(action: {
                    // important: check if both passwords are the same
                    
                    
                    // type register func here
                    
                    
                }, label: {
                    HStack {
                        Text("Registrieren!")
                            .foregroundColor(.primary)
                        Image(systemName: "person.badge.plus")
                    }
                })
                .padding()
                .modifier(FrozenWindowModifier())
//                .offset(y: 200)
            }
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
