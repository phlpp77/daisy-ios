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
    
    // default value to check if the user made correct input
    var defaultText: String
    
    // design the alertBox to have a textField input possibility
    var textFieldInput = false
    
    // design the alertBox to have a Picker input possibility
    var pickerInput = false
    
    // array which is shown in the picker view
    var pickerInputArray = [""]
    
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
    
    @State var lastSelectedIndex: Int?
    
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
                
                // only show textField if it defined
                if textFieldInput {
                    // texfield
                    TextField(placeholder, text: $output)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                }
                
                // only show Picker if it defined
                if pickerInput {
                    // picker
                    
                    // THE BINDING OF THE OUTPUT STRING THROWS AN ERROR - OUTPUT IS NOT SHOWING CORRECTLY
                    VStack {
                        PickerTextField(data: pickerInputArray, placerholder: placeholder, lastSelectedIndex: $lastSelectedIndex)
                            .frame(height: 35)
                            .padding(.horizontal, 20)
//                        PickerTextField(data: ["pert", "schoko"], placerholder: "placeholder", lastSelectedIndex: $lastSelectedIndex, selectedOutput: $pickerOutput)
//                            .frame(height: 35)
//                        Text("Output: \(lastSelectedIndex ?? 0)")
//                            .font(.largeTitle)
                    }
                }
                
                
                Divider()
                    .padding(.horizontal, 20)
                
                HStack {
                    
                    // button to cancel the action
                    Button(action: {
                        output = ""
                        withAnimation(.spring()) {
                            self.show.toggle()
                            
                            accepted = false
                        }
                    }) {
                        Text(cancelButton)
                            .frame(width: 108)
                    }
                    
                    Divider()
                        .frame(height: 25)
                    
                    // button to confirm the action
                    Button(action: {
                        withAnimation(.spring()) {
                            self.show.toggle()
                            
                            // check if the picker was used then the pickeroutput needs to be assigned to the normal output
                            if pickerInput {
                                output = pickerInputArray[lastSelectedIndex ?? 0]
                            }
                            
                            // check if output is useful
                            if output != defaultText && output != "" {
                                accepted = true
                            } else {
                                accepted = false
                            }
                            
                        }
                        
                    }) {
                        Text(confirmButton)
                            .frame(width: 108)
                    }
                }
            }
            .padding()
            .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .modifier(FrozenWindowModifier())
        }
    }
}

struct AlertBoxView_Previews: PreviewProvider {
    static var previews: some View {
        AlertBoxView(title: "Alert", placeholder: "Text here..", defaultText: "Name", output: .constant(""), show: .constant(true), accepted: .constant(false))
    }
}
