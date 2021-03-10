//
//  LoginNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.03.21.
//

import SwiftUI
import PromiseKit

struct LoginNView: View {
    
    @ObservedObject var loginVM: LoginViewModel = LoginViewModel()
    
    @Binding var nextPosition: StartPosition
    @Binding var startUpDone: Bool
    
    //@State var emailFieldOutput: String = ""
    //@State var passwordField1Output: String = ""
    //@State var passwordField2Output: String = ""
    
    @State var passwordField1WasEdited: Bool = false
    @State var showPresentTermsAndConditionsSheet: Bool = false
    @State var loginMode: Bool = false
    @State var problemOccurred: Bool = false
    
    var body: some View {
        
        
        GeometryReader { bounds in
            ZStack {
                
                
                VStack {
                    
                    // MARK: Header
                    VStack(alignment: .leading, spacing: 0.0) {
                        if !loginMode {
                            Text("Register now for ")
                        }
                        Text("_APP_NAME_")
                            .foregroundColor(.accentColor)
                    }
                    .font(.title)
                    
                    // MARK: Terms and Conditions
                    Button(action: {
                        showPresentTermsAndConditionsSheet.toggle()
                    }, label: {
                        Text("By continuing, you agree to our friendly Terms and Conditions.")
                            .font(.caption)
                            .foregroundColor(.primary)
                    })
                    .sheet(isPresented: $showPresentTermsAndConditionsSheet) {
                        Text("AGBs sind langweilig.")
                    }
                    
                    // MARK: Error-message can be presented here
                    if problemOccurred {
                        Text("Errormessage")
                            .foregroundColor(.accentColor)
                            .font(.caption)
                    }
                    
                    // MARK: Input for Registration
                    TextField("E-Mail", text: $loginVM.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                    TextField("Password", text: $loginVM.password) { (editingChanged) in
                        withAnimation(.easeInOut) {
                            passwordField1WasEdited = true
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if passwordField1WasEdited && !loginMode {
                        TextField("Repeat password", text: $loginVM.password2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // MARK: Button to switch between login and register mode
                    Button(action: {
                        withAnimation(.easeInOut) {
                            loginMode.toggle()
                        }
                    }, label: {
                        Text(loginMode ? "Don't have an account? Create one" : "I already have an account")
                            .font(.caption)
                    })
                    
                    // MARK: Button to Login/register
                    HStack {
                        Button(action: {
                            
                            // if button shows login
                            if loginMode {
                                self.loginVM.login().done {
                                    
                                    if self.loginVM.startProcessDone {
                                        // switches view to main app
                                        self.startUpDone = true
                                    } else {
                                        // switches view to profileCreation
                                        self.nextPosition = .profileCreation
                                    }
                                    
                                }.catch { error in
                                    print(error)
                                }
                            }
                            // if button shows register
                            else {
                                print("button gedrückt")
                                self.loginVM.register().done {
                                    print("register done")
                                    // switches view to the profile Creation
                                    self.nextPosition = .profileCreation
                                }.catch { error in 
                                    print(error)
                                }
                            }
                                
                            
                            
                        }, label: {
                            Text(loginMode ? "Login" : "Register")
                                .padding(.horizontal, 50)
                                .padding(.vertical, 8)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .modifier(offWhiteShadow(cornerRadius: 18))
                .padding(.horizontal, 44)
                
                
                // MARK: - Top-layer
                ZStack {
                    
                    // MARK: Background behind the Symbol
                    BlurView(style: .systemThinMaterial)
                        .frame(width: 71, height: 71)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                                            .init(color: Color(#colorLiteral(red: 0.7791666388511658, green: 0.7791666388511658, blue: 0.7791666388511658, alpha: 0.949999988079071)), location: 0),
                                                            .init(color: Color(#colorLiteral(red: 0.7250000238418579, green: 0.7250000238418579, blue: 0.7250000238418579, alpha: 0)), location: 1)]),
                                        startPoint: UnitPoint(x: 0.9016393067273221, y: 0.10416647788375455),
                                        endPoint: UnitPoint(x: 0.035519096038869824, y: 0.85416653880629)),
                                    lineWidth: 0.5
                                )
                        )
                        .clipShape(
                            Circle()
                        )
                    
                    // MARK: Symbol which shows the eventStatus
                    Image(systemName: loginMode ? "person.fill" : "person.fill.badge.plus")
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .offset(x: bounds.size.width / 2 - 44, y: -bounds.size.height / 2 + bounds.size.height * 0.33)
                
            }
            .padding(.top, bounds.size.height * 0.33)
        }
        
    }
}

struct LoginNView_Previews: PreviewProvider {
    static var previews: some View {
        LoginNView(nextPosition: .constant(.registerLogin), startUpDone: .constant(true))
    }
}
