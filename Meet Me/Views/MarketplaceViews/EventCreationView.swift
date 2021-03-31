//
//  EventCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.02.21.
//

import SwiftUI
import URLImage

struct EventCreationView: View {
    //@StateObject private var youEventLineVM = YouEventLineViewModel()
    @StateObject private var eventCreationVM = EventCreationViewModel()
    @StateObject private var firestoreFotoMangerUserTest = FirestoreFotoManagerUserTest()
    // binding for presentation
    @Binding var presentation: Bool
    // binding for updating the array
    @Binding var eventArray: [EventModel]
    
    // vars to show in the screen
    @State private var category: String = "Café"
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date() + 60*30
    @State private var duration: Duration = .medium
    @State private var pictureURL: String = ""
    
    
    // get nearest quarter as start
    
    let roundedDate = { () -> Date in
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        
        // Round down to nearest date eg. every 15 minutes
        let minuteGranuity = 15
        let roundedMinute = minute - (minute % minuteGranuity)
        
        return calendar.date(bySettingHour: hour,
                             minute: roundedMinute,
                             second: 0,
                             of: now)!
    }()
    
    
    // image handling with PhPicker
    @State private var images: [UIImage] = [UIImage(named: "cafe")!]
    @State private var showImagePicker: Bool = false
    
    // animation of alert-boxes
    @State private var showAlertBox: Bool = false
    @State private var pathNumber: Int = 0
    @State private var accepted: Bool = false
    // legacy handling of date as a string
    @State private var dateAsString = ""
    @State private var startTimeAsString = ""
    @State private var endTimeAsString = ""
    
    // animation of custom button
    @State private var buttonPressed: Bool = false
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
    
    var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    var body: some View {
        ZStack {
            
            // background
            Color.black.opacity(0.0001)
                .onTapGesture {
                    presentation = false
                }
            
            VStack {
                
                
                
                ZStack {
                    // Main image as a background of the event
                    
                    // event image
                    Image(uiImage: images.last!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250, alignment: .center)
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(category)
                                .onTapGesture {
                                    self.showAlertBox = true
                                    self.pathNumber = 0
                                }
                            
                            Spacer()
                            Divider()
                            
                            Text(dateAsString)
                                .onAppear {
                                    self.dateAsString = dateFormatter.string(from: Date())
                                }
                                .onTapGesture {
                                    self.showAlertBox = true
                                    self.pathNumber = 1
                                }
                            
                        }
                        .padding(.horizontal, 8)
                        .frame(width: 250, height: 30)
                        .background(BlurView(style: .systemThickMaterial))
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            
                            // time
                            HStack {
                                
                                HStack {
                                    Text("Start")
                                    Text(startTimeAsString)
                                        .foregroundColor(.accentColor)
                                    
                                }
                                .onAppear {
                                    self.startTimeAsString = timeFormatter.string(from: startTime)
                                }
                                .onTapGesture {
                                    self.showAlertBox = true
                                    self.pathNumber = 2
                                }
                                
                                HStack {
                                    Text("duration")
                                    Text(duration.rawValue)
                                        .foregroundColor(.accentColor)
                                    
                                }
                                .onAppear {
                                    self.endTimeAsString = timeFormatter.string(from: endTime)
                                }
                                .onTapGesture {
                                    self.showAlertBox = true
                                    self.pathNumber = 3
                                }
                            }
                            .font(.headline)
                            //                        .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 8)
                        .frame(width: 250)
                        .background(BlurView(style: .systemUltraThinMaterial))
                    }
                    
                    
                }
                .frame(width: 250, height: 250, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 15)
                
                // update button
                HStack {
                    Text("Create event")
                        .foregroundColor(.accentColor)
                    Image(systemName: "checkmark.circle")
                }
                .opacity(buttonPressed ? 0.5 : 1)
                
                .padding()
                .modifier(FrozenWindowModifier())
                .padding(.bottom, 16)
                .scaleEffect(buttonPressed ? 0.8 : 1)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                .padding(.top, 20)
                .onTapGesture {
                    
                    // update handling
                    prepareUpload()
                    //youEventLineVM.getYouEvents()
                    eventCreationVM.saveEvent(uiImage: images.last!)
                    // button animation start
                    buttonPressed.toggle()
                    // haptic feedback when button is tapped
                    hapticPulse(feedback: .rigid)
                    
                    // update event array
                    eventArray.append(createUpdateEvent())
                    
                    // close view
                    presentation = false
                    
                }
                
                // xmark symbol to show the user how to dismiss the view
                Image(systemName: "xmark")
                    .foregroundColor(Color("BackgroundSecondary").opacity(0.7))
                    .font(.system(size: 30))
                    .padding(.top, 10)
                
            }
            .scaleEffect(1.3)
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(images: $images, showPicker: $showImagePicker, limit: 1, didFinishPicking: {_ in})
            })
            .onAppear {
                
                // standard start time is the next quarter to the actual time
                startTime = roundedDate
                startTimeAsString = timeFormatter.string(from: roundedDate)
                
                // standard end time is the next quarter to the actual time plus 1 hour
                endTime = roundedDate + 60 * 60
                endTimeAsString = timeFormatter.string(from: roundedDate + 60 * 60)
            }
            
            
            if showAlertBox {
                switch pathNumber {
                
                // AlertBox to define the category
                case 0:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", categoryPicker: true, selectedDuration: .constant(.medium), output: $category, show: $showAlertBox, accepted: $accepted)
                    
                // AlertBox to define the date
                case 1:
                    AlertBoxView(title: "Choose a date", placeholder: dateFormatter.string(from: date), defaultText: dateFormatter.string(from: date), datePicker: true, selectedDuration: .constant(.medium), output: $dateAsString, show: $showAlertBox, accepted: $accepted)
                    
                // AlertBox to define the startTime of the event
                case 2:
                    AlertBoxView(title: "Choose your start time", placeholder: timeFormatter.string(from: startTime), defaultText: timeFormatter.string(from: startTime), timePicker: true, selectedDuration: .constant(.medium), dateFormat: "HH:mm", output: $startTimeAsString, show: $showAlertBox, accepted: $accepted)
                    
                // AlertBox to define the endTime of the event
                case 3:
                    AlertBoxView(title: "Choose the duration", placeholder: timeFormatter.string(from: endTime), defaultText: timeFormatter.string(from: endTime), startTime: startTimeAsString, durationPicker: true, selectedDuration: $duration, dateFormat: "HH:mm", output: $endTimeAsString, show: $showAlertBox, accepted: $accepted)
                    
                default:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", selectedDuration: .constant(.medium), output: $category, show: $showAlertBox, accepted: $accepted)
                }
            }
            
//            Image(systemName: "xmark.circle")
//                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                .padding(10)
//                .background(BlurView(style: .systemMaterial))
//                .clipShape(Circle())
//                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
//                .scaleEffect(buttonPressed ? 0.8 : 1)
//                .opacity(buttonPressed ? 0.5 : 1)
//                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
//                .onTapGesture {
//                    // button animation start
//                    buttonPressed.toggle()
//
//                    // haptic feedback when button is tapped
//                    hapticPulse(feedback: .rigid)
//
//                    // close view
//                    presentation = false
//                }
//                .offset(x: 130, y: -320)
            
        }
        
    }
    
    func createUpdateEvent() -> EventModel {
        let event = EventModel(eventId: "", userId: "", category: category, date: date, startTime: startTime, endTime: endTime, pictureURL: pictureURL, profilePicture: "", likedUser: false,eventMatched: false, latitude: 0.0, longitude: 0.0, hash: "", distance: 0, searchingFor: "", genderFromCreator: "", birthdayDate: Date(), covidPreferences: "")
        
        //let eventObject = EventModel(eventModel: event, position: .constant(.zero))
        
        
        return event
    }
    
    // function to convert strings into dates for upload into the database
    func prepareUpload() {
        eventCreationVM.category = category
        eventCreationVM.pictureURL = pictureURL
        eventCreationVM.date = dateFormatter.date(from: dateAsString) ?? Date()
        eventCreationVM.startTime = timeFormatter.date(from: startTimeAsString) ?? Date()
        eventCreationVM.endTime = timeFormatter.date(from: endTimeAsString) ?? Date()
        print("DEBUG: Duration which is in the string \(duration)")
        print("DEBUG: Date which gets uploaded \(eventCreationVM.date)")
    }
}

struct EventCreationView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationView(presentation: .constant(true), eventArray: .constant([stockEvent]))
    }
}
