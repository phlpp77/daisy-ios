//
//  RegisterView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct RegisterView: View {
    
    // for animation to loginView
    @Binding var showLoginView: Bool
    
    @Binding var userIsLoggedIn: Bool
    
    //wird nur gebraucht wenn man die View über sheet anzeigt
    //kann man implementieren für das registrieren
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var registerVM = RegisterViewModel()
       
    @State var showSecondPasswordTextField = false
    
    // if a problem happens during the register process a message can be shown
    @State var problemAccured = false
    
    // message to present the user when error happend
    @State var problemMessage = "Passwords are not the same"
    
    
    var body: some View {
        ZStack {
//            StartBackgroundView()
            
            VStack {
                VStack(alignment: .leading) {
                    
                    if problemAccured {
                        Text(problemMessage)
                            .font(.footnote)
                            .padding(.leading, 35)
                        // spring animation not working at this stage -> normal blend animation is used
//                            .scaleEffect(problemAccured ? 1.0 : 0.1)
//                            .animation(.spring(response: 0.6, dampingFraction: 0.4, blendDuration: 5))
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "envelope")
                        TextField("Type your email address here", text: $registerVM.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                    }
                    .padding(.bottom, 3)
                    
                    Divider()
                    
                    // main password textField
                    HStack(spacing: 12) {
                        Image(systemName: "lock.shield")
                        SecureField("Choose a password", text: $registerVM.password)
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
                        SecureField("Repeat your password", text: $registerVM.password2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(height: showSecondPasswordTextField ? 40 : 0)
                    .opacity(showSecondPasswordTextField ? 1 : 0)
                    
                    // have account button
                    Button(action: {
                        
                        // change view to LoginView
                        showLoginView = true
                        
                        // type "have account" func here -> to login screen
                        
                    }) {
                        Text("I have an account")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(3)
                            .padding(.trailing, 58)
                            
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
                    // haptic feedback when button is tapped
                    hapticPulse(feedback: .rigid)
                    
                    // important: check if both passwords are the same
                    
                    // type register func here
                    registerVM.register {
                        //if register was succsesful
                        userIsLoggedIn = true
                        presentationMode.wrappedValue.dismiss()
                    }
                    //Show textfield if checkErrors is true
                    problemAccured = registerVM.checkErrors()
                    //Set Problem Message to ErrorMessage
                    problemMessage = registerVM.errorMessage


                    
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
        RegisterView(showLoginView: .constant(false), userIsLoggedIn: .constant(false))
    }
}
