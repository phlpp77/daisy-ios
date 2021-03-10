//
//  LoginNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.03.21.
//

import SwiftUI

struct LoginNView: View {
    
    
    @State var emailFieldOutput: String = ""
    @State var passwordField1Output: String = ""
    @State var passwordField2Output: String = ""
    
    @State var passwordField1WasEdited: Bool = false
    @State var showPresentTermsAndConditionsSheet: Bool = false
    
    var body: some View {
        
        
        ZStack {
            
            
            VStack {
                
                // MARK: Header
                VStack(alignment: .leading, spacing: 0.0) {
                    Text("Register now for ")
                    Text("_APP_NAME_")
                        .foregroundColor(.accentColor)
                }
                .font(.title)
                
                // MARK: Terms and Conditions
                Button(action: {
                    showPresentTermsAndConditionsSheet.toggle()
                }, label: {
                    Text("By continuing, you agree to our friendly Terms and Conditions")
                        .font(.caption)
                        .foregroundColor(.primary)
                })
                .sheet(isPresented: $showPresentTermsAndConditionsSheet) {
                            Text("AGBs sind langweilig.")
                        }
                
                // MARK: Input for Registration
                TextField("E-Mail", text: $emailFieldOutput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                TextField("Password", text: $passwordField1Output) { (editingChanged) in
                    withAnimation(.easeInOut) {
                        passwordField1WasEdited = true
                    }
                }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if passwordField1WasEdited {
                    TextField("Repeat password", text: $passwordField2Output)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .modifier(offWhiteShadow(cornerRadius: 18))
            .padding(.horizontal, 44)
            
            
        }
        
    }
}

struct LoginNView_Previews: PreviewProvider {
    static var previews: some View {
        LoginNView()
    }
}
