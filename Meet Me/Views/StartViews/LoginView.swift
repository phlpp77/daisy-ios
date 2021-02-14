//
//  RegisterView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct LoginView: View {
    
    // needed to get keyboard height when keyboard is shown
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    //Sobald login gedrückt wurde und Erfolgreich war wird die Variable True
    @State var isActive: Bool = false
    @ObservedObject private var loginVM = LoginViewModel()
    
    // change the var for the main animation
    @Binding var userIsLoggedIn: Bool
    
    // if a problem happens during the login process a message can be shown
    @State var problemAccured = false
    
    // message to present the user when error happend
    @State var problemMessage = "Wrong password"
    
    var body: some View {
        ZStack {
            //            StartBackgroundView()
                VStack {
                    
                    Spacer()
//                        .frame(height: 150)
                    
                    // stack with textfields
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
                            TextField("Enter your email address here", text: $loginVM.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                        }
                        .padding(.bottom, 3)
                        
                        Divider()
                        
                        // main password textField
                        HStack(spacing: 12) {
                            Image(systemName: "lock.shield")
                            SecureField("Enter your password here", text: $loginVM.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }
                        .padding(.top, 3)
                        
                        
                    }
                    .font(.subheadline)
                    .foregroundColor(.accentColor)
                    .padding()
                    
                    .modifier(FrozenWindowModifier())
//                    .animation(.easeInOut)
//                    .frame(maxHeight: .infinity)
                    .frame(width: screen.width - 40)
                    // animation when keyboard is shown or not
//                    .position(x: screen.width/2, y: screen.height/2)
//                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .offset(y: keyboardHandler.keyboardHeight/10)
                    .animation(.easeInOut(duration: 0.3))
                    
                    
                    Spacer()
                    
                    // login button
                    Button(action: {
                        // haptic feedback when button is tapped
                        hapticPulse(feedback: .rigid)
                        loginVM.login {
                            isActive = true
                            print("Login succeeded \(isActive)")
                            userIsLoggedIn = true
                            
                        }
                        //Show textfield if checkErrors is true
                        problemAccured = loginVM.checkErrors()
                        //Set Problem Message to ErrorMessage
                        problemMessage = loginVM.errorMessage
                        
                        
                        
                    }, label: {
                        HStack {
                            Text("Login!")
                                .foregroundColor(.primary)
                            Image(systemName: "person.fill.checkmark")
                        }
                    })
                    .padding()
                    
                    .modifier(FrozenWindowModifier())
                    // animation when keyboard is shown or not
                    .padding(.bottom, keyboardHandler.keyboardHeight)
                    .animation(.easeInOut(duration: 0.3))
                    
                    
                }
                
                
                
            }
        
            
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userIsLoggedIn: .constant(false))
    }
}
