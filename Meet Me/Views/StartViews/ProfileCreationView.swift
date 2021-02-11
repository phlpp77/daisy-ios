//
//  ProfileCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 24.01.21.
//

import SwiftUI



enum SourceType {
    case photoLibrary
    case camera
}

struct ProfileCreationView: View {
    
    
    @StateObject private var addProfileCreationVM = ProfileCreationModel()
    
    // binding to show the main controller that the proccess is finished
    @Binding var profileCreationFinished: Bool
    
    // MARK: - state vars
    
    // var for the birthday date of the profile owner in the date format
    @State var birthdayDate: Date = Date()
    
    // user is searching for..
    @State var searchingFor: String = "Searching for"
    
    // user accepts the location usage - NEEDS TO BE CHANGED TO BOOL
    @State var acceptLocation: String = "True"
    
    // picture text which will change when picture is uploaded - does not need to go into the database
    @State var pictureText: String = "Picture upload"
    
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
    @State var accpetedAction = [false, false, false, false, false, false]
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var originalImage: UIImage? = nil
    @State private var name: String = ""
    @State private var showActionSheet: Bool = false
    @State private var sourceType: SourceType = .photoLibrary
    
    
    
    var body: some View {
        ZStack {
            // background with animation - for testing background is handled in the main startView
//            StartBackgroundView()
            
            // box where all items are in with fixed size
            ZStack {
                Color.clear
                    .frame(width: 340, height: 620, alignment: .center)
                    .modifier(FrozenWindowModifier())
                
                VStack {
                    VStack {
                        Text("Let's follow the completion path!")
                            .font(.largeTitle)
                            .padding(.top, 16)
                    }
                    ScrollView {
                        
                        // view to fill in the name
                        VStack {
                            NameLineView(name: $addProfileCreationVM.name, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction[0] ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction[0] ? .constant("Clear") : .constant("BackgroundMain"))
                            
                            // create image for the first to second step pathway
                            Image("Pathway-ProfileCreation")
                                .resizable()
                                .frame(width: 268.58, height: 92.92, alignment: .center)
                            
                            // get the gender of the user
                            GenderLineView(gender: $addProfileCreationVM.gender, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction[1] ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction[1] ? .constant("Clear") : .constant("BackgroundMain"))
                            
                            // create image for the second to the third step of the pathway
                            Image("Pathway-ProfileCreation")
                                .resizable()
                                .frame(width: 268.58, height: 92.92, alignment: .center)
                                .rotation3DEffect(
                                    Angle(degrees: 180),
                                    axis: (x: 0, y: 1.0, z: 0.0)
                                )
                        }
                        
                        // get the birthday date of the user
                        BirthdayLineView(birthday: $addProfileCreationVM.birthdayDate, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction[2] ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction[2] ? .constant("Clear") : .constant("BackgroundMain"))
                        
                        // create image for the third to the fourth step of the pathway
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: .center)
                        
                        // get for what the user is searching (women, men, both)
                        SearchingLineView(searchingFor: $searchingFor, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction[3] ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction[3] ? .constant("Clear") : .constant("BackgroundMain"))
                        
                        // create image for the fourth to the fifth step of the pathway
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: .center)
                            .rotation3DEffect(
                                Angle(degrees: 180),
                                axis: (x: 0, y: 1.0, z: 0.0)
                            )
                        
                        // get the user permission to use the current position
                        LocationLineView(acceptLocation: $acceptLocation, pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: accpetedAction[4] ? .constant("checkmark.circle") : .constant("pencil.circle"), backgroundColor: accpetedAction[4] ? .constant("Clear") : .constant("BackgroundMain"))
                        
                        // create image for the fifth to the sixth step of the pathway
                        Image("Pathway-ProfileCreation")
                            .resizable()
                            .frame(width: 268.58, height: 92.92, alignment: .center)
                        
                        // upload image to database
                        PictureLineView(pictureText: accpetedAction[5] ? .constant("You look good today") : .constant("No picture"), pathwayStep: $pathwayStep, showAlertBox: $showAlertBox, iconName: $iconName, backgroundColor: $backgroundColor)
                        
                        // create image for the end pathway to the update profile button
                        VStack(alignment: .trailing) {
                            
                            HStack {
                                Spacer()
                                Image("Endway-ProfileCreation")
                                    .resizable()
                                    .frame(width: 137.58, height: 47.6, alignment: .trailing)
                            }
                                                        
                        }
                        .frame(width: 268.58)
                        
                        // button is disabled until the user set at least the name, the gender and the birthday
                        let enoughInformation = !(accpetedAction[0] && accpetedAction[1] && accpetedAction[2])
                        
                        // update button
                        Button(action: {
                            addProfileCreationVM.save()
                            // haptic feedback when button is tapped
                            hapticPulse(feedback: .rigid)
                            
                            // process is done
                            //profileCreationFinished = true
                            
                        }, label: {
                            HStack {
                                Text("Update profile")
                                    .foregroundColor(.primary)
                                Image(systemName: "checkmark.circle")
                            }
                        })
                        .padding()
                        .modifier(FrozenWindowModifier())
                        .padding(.bottom, 16)
                        .opacity(enoughInformation ? 1 : 0.7)
                        .disabled(enoughInformation)
                        
                        .onChange(of: addProfileCreationVM.saved, perform: { value in
                            if value {
                                //if save succssful
                                profileCreationFinished = true
                                print("saveddddd")
                            } else {
                                //if profile settings didnt uploded
                                print("Problems")
                            }
                        })
                        
                        
                        
                    }
                    .padding(.bottom, 16)

                }
                .padding(.horizontal, 16)
                // bring the content VStack to the same size as the background shade
                .frame(width: 340, height: 620, alignment: .center)
                
                
                // creating pop-up alertboxes
                if showAlertBox {
                    
                    // switch case to show the correct alertbox for each step in the pathway
                    switch pathwayStep {
                    
                    // case 0 is the first step -> name creation
                    case 0:
                        AlertBoxView(title: "Type in your Name", placeholder: "Type here..", defaultText: "Name", textFieldInput: true, output: $addProfileCreationVM.name, show: $showAlertBox, accepted: $accpetedAction[0])
                            // z index 1 == the top layer -> this is needed due to animation processes
                            .zIndex(1.0)
                    
                    // case 1 is the second step -> gender creation
                    case 1:
                        AlertBoxView(title: "Choose your gender", placeholder: "Tap here to choose..", defaultText: "Gender", pickerInput: true, pickerInputArray: ["Male", "Female", "Other"], output: $addProfileCreationVM.gender, show: $showAlertBox, accepted: $accpetedAction[1])
                            .zIndex(1.0)
                        
                    // case 2 is the third step -> birthday date
                    case 2:
                        AlertBoxView(title: "Select your birthday date", placeholder: "Tap here to choose..", defaultText: "Birthday", dateInput: true, output: $addProfileCreationVM.birthdayDate, show: $showAlertBox, accepted: $accpetedAction[2], date: birthdayDate)
                            .zIndex(1.0)
                        
                    // case 3 is the fourth step -> searching for creation
                    case 3:
                        AlertBoxView(title: "Choose for whom you are searching", placeholder: "Tap here to choose..", defaultText: "Searching for", pickerInput: true, pickerInputArray: ["Male", "Female", "Both"], output: $searchingFor, show: $showAlertBox, accepted: $accpetedAction[3])
                            .zIndex(1.0)
                        
                    case 4:
                        // add alertbox to ask user for location services
                        AlertBoxView(title: "Allow app to use your current location", placeholder: "", defaultText: "", output: $acceptLocation, show: $showAlertBox, accepted: $accpetedAction[4])
                        
                    case 5:
                        AlertBoxView(title: "Choose a picture of yourself", placeholder: "", defaultText: "", output: $acceptLocation, show: $showAlertBox, accepted: $accpetedAction[4])
                    
                    // the default is 0 which is the first step in the pathway -> name creation
                    default:
                        AlertBoxView(title: "Type in your Name", placeholder: "Type here..", defaultText: "Name", output: $outputAlertBox, show: $showAlertBox, accepted: $accpetedAction[2])
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
        ProfileCreationView(profileCreationFinished: .constant(false))
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
            
            Text(gender)
            
            Button(action: {
                // configure which step it is in the pathway
                pathwayStep = 1
                showAlertBox = true
            }) {
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
    @Binding var birthday: String

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
                pathwayStep = 2
                showAlertBox = true
            }) {
                Image(systemName: iconName)
                    .font(.title)
                    .padding(4)
                    .background(Color(backgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            
            Text(birthday)
            
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .leading)
    }
}



struct SearchingLineView: View {
    
    // Binding from main View
    @Binding var searchingFor: String

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
            
            Text(searchingFor)
            
            Button(action: {
                // configure which step it is in the pathway
                pathwayStep = 3
                showAlertBox = true
            }) {
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

struct LocationLineView: View {
    
    // Binding from main View
    @Binding var acceptLocation: String

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
                pathwayStep = 4
                showAlertBox = true
            }) {
                Image(systemName: iconName)
                    .font(.title)
                    .padding(4)
                    .background(Color(backgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            
            Text("Location")
            
        }
        .padding(.horizontal, 16)
        .frame(width: 340, alignment: .leading)
    }
}

struct PictureLineView: View {
    
    // Binding from main View
    @Binding var pictureText: String

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
            
            Text(pictureText)
            
            Button(action: {
                // configure which step it is in the pathway
                pathwayStep = 5
                showAlertBox = true
            }) {
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

