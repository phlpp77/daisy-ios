//
//  AlertBoxView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 25.01.21.
//

import SwiftUI

struct AlertBoxView: View {
    
    // MARK: - Parameter to configure the alert
    
    // title of alert box
    var title: String
    
    // placeholder for textfield
    var placeholder: String
    
    // cancel button per default
    var cancelButton = "Cancel"
    
    // confirmButton per default
    var confirmButton = "OK"
    
    // MARK: - Bindings
    
    // output of the alert input textfield
    @Binding var output: String
    
    // show/hide param
    @Binding var show: Bool
    
    // accepted param to give the information back
    @Binding var accepted: Bool
    
    
    var body: some View {
        ZStack {
            
            // background
            BlurView(style: .systemUltraThinMaterial)
                .opacity(0.9)
                .ignoresSafeArea()
            
            // main window
            VStack {
                
                // title text
                Text(title)
                    .font(.title2)
                    .bold()
                
                // texfield
                TextField(placeholder, text: $output)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                Divider()
                    .padding(.horizontal, 20)
                
                HStack {
                    
                    // button to cancel the action
                    Button(action: {
                        output = ""
                        show = false
                        accepted = false
                    }) {
                        Text(cancelButton)
                            .frame(width: 108)
                    }
                    
                    Divider()
                    
                    // button to confirm the action
                    Button(action: {
                        show = false
                        accepted = true
                    }) {
                        Text(confirmButton)
                            .frame(width: 108)
                    }
                }
            }
            .padding()
            .frame(width: 300, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .modifier(FrozenWindowModifier())
        }
    }
}

struct AlertBoxView_Previews: PreviewProvider {
    static var previews: some View {
        AlertBoxView(title: "Alert", placeholder: "Text here..", output: .constant(""), show: .constant(true), accepted: .constant(false))
    }
}
