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
    
    var body: some View {
        ZStack {
//            StartBackgroundView()
            
            VStack {
                VStack {
                    HStack(spacing: 12) {
                        Image(systemName: "envelope")
                        TextField("Gebe deine E-Mail Adresse ein", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.bottom, 3)
                    
                    Divider()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "lock.shield")
                        SecureField("Suche dir ein Passwort aus", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.top, 3)
                }
                .font(.subheadline)
                .foregroundColor(.accentColor)
                .padding()
                .modifier(FrozenWindowModifier())
                .frame(maxHeight: .infinity)
                .frame(width: screen.width - 40)
                
                Spacer()
                
                Button(action: {
                    
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
