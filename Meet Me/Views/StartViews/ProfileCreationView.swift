//
//  ProfileCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 24.01.21.
//

import SwiftUI

struct ProfileCreationView: View {
    
    // MARK: - state vars
    
    // var for the name of the profile owner
    @State var name = "Name"
    
    // var for the gender of the profile owner
    @State var gender = ""
    
    // var for the birthday date of the profile owner
    @State var birthdayDate = ""
    
    // show the alertbox
    @State var showAlertBox = false
    
    // state var to catch what the user has handed into the textfield of the alertbox
    @State var outputAlertBox = ""
    
    // var to check at which step the user wants to hand in data
    @State var pathwayStep = 0
    
    // icon name changes after the value is set
    @State var iconName = "pencil.circle"
    
    // background color changes after the value is set
    @State var backgroundColor = "BackgroundMain"
    
    // var to see if the action in the alert was accepted or not
    @State var accpetedAction = false
    
    
    var body: some View {
        ZStack {
            // background with animation
            StartBackgroundView()
            
            // box where all items are in with fixed size
            ZStack {
                Color.clear
                    .frame(width: 340, height: 620, alignment: .center)
                    .modifier(FrozenWindowModifier())
                
                VStack {
                    VStack {
                        Text("Verrate uns doch ein paar Infos über dich!")
                            .font(.largeTitle)
                            .padding(.top, 16)
                    }
                    ScrollView {
                        // view to fill in the name
                        NameLineView(name: $name, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction ? .constant("") : .constant("BackgroundMain"))
                        
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        GenderLineView(gender: $gender, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction ? .constant("") : .constant("BackgroundMain"))
                        
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .rotation3DEffect(
                                Angle(degrees: 180),
                                axis: (x: 0, y: 1.0, z: 0.0)
                            )
                        
                        BirthdayLineView(birthdayDate: $birthdayDate)
                        
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        
                    }
                }
                .padding(.horizontal, 16)
                // bring the content VStack to the same size as the background shade
                .frame(width: 340, height: 620, alignment: .center)
                
                if showAlertBox {
                    
                    // switch case to show the correct alertbox for each step in the pathway
                    switch pathwayStep {
                    
                    // case 0 is the first step -> name creation
                    case 0:
                        AlertBoxView(title: "Type in your Name", placeholder: "Type here..", defaultText: "Name", textFieldInput: true, output: $name, show: $showAlertBox, accepted: $accpetedAction)
                            // z index 1 == the top layer -> this is needed due to animation processes
                            .zIndex(1.0)
                    
                    // case 1 is the second step -> gender creation
                    case 1:
                        AlertBoxView(title: "Choose your gender", placeholder: "Tap here to choose..", defaultText: "", textFieldInput: true, output: $gender, show: $showAlertBox, accepted: $accpetedAction)
                    
                    // the default is 0 which is the first step in the pathway -> name creation
                    default:
                        AlertBoxView(title: "Type in your Name", placeholder: "Type here..", defaultText: "Name", output: $outputAlertBox, show: $showAlertBox, accepted: $accpetedAction)
                            // z index 1 == the top layer -> this is needed due to animation processes
                            .zIndex(1.0)
                    }
                    
                }
                
                
            }
            .animation(.spring(blendDuration: 0.15))
            
        }
    }
}

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationView()
//            .previewDevice("iPhone 8")
    }
}

struct NameLineView: View {
    
    // Binding from main View
    @Binding var name: String
    
    // binding for pathway change
    @Binding var pathwayStep: Int
    
    // binding for show/hide of alertBox
    @Binding var showAlertBox: Bool
    
    // icon name changes after the value is set
    @Binding var iconName: String
    
    // background color changes after the value is set
    @Binding var backgroundColor: String
    
    var body: some View {
        HStack {
            Button(action: {
                // configure which step it is in the pathway
                pathwayStep = 0
                showAlertBox = true
            }) {
                Image(systemName: iconName)
                    .font(.title)
                    .padding(4)
                    .background(Color(backgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            
            Text(name)
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .leading)
    }
}

struct GenderLineView: View {
    
    // Binding from main View
    @Binding var gender: String
    
    // binding for pathway change
    @Binding var pathwayStep: Int
    
    // binding for show/hide of alertBox
    @Binding var showAlertBox: Bool
    
    // icon name changes after the value is set
    @Binding var iconName: String
    
    // background color changes after the value is set
    @Binding var backgroundColor: String
    
    var body: some View {
        HStack {
            Button(action: {
                // configure which step it is in the pathway
                pathwayStep = 1
                showAlertBox = true
            }) {
                Text(gender)
                
                Image(systemName: iconName)
                    .font(.title)
                    .padding(4)
                    .background(Color(backgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            
            
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .trailing)
    }
}








//
//struct GenderXLineView: View {
//
//    // Binding from main View
//    @Binding var gender: String
//
//    var body: some View {
//        HStack {
//            Text("Gender")
//            TextField("", text: $gender)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .frame(width: 35)
//        }
//        .padding(.horizontal, 16)
//        .frame(width: 340, alignment: .trailing)
//    }
//}

struct BirthdayLineView: View {
    
    // Binding from main View
    @Binding var birthdayDate: String
    
    var body: some View {
        HStack {
            TextField("", text: $birthdayDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 35)
            Text("Birthday")
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .leading)
    }
}
