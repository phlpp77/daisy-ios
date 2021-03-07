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
    @Binding var eventArray: [EventModelObject]
//    @State private var event: EventModelObject = stockEventObject

    // vars to show in the screen
    @State private var category: String = "Café"
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date() + 60*30
    @State private var pictureURL: String = ""
    
    // image handling
    @State private var image: Image? = Image("cafe")
    @State private var uiImage: UIImage? = UIImage(named: "cafe")
    
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
        formatter.dateFormat = "dd/mm/yy"
        formatter.dateStyle = .medium
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
            BlurView(style: .systemMaterial)
                .ignoresSafeArea()
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
                            Image(uiImage: #imageLiteral(resourceName: "Philipp"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60, alignment: .center)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.9), lineWidth: 5)
                                )
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            
                            Spacer()
                            
                            
                            // time
                            HStack {
                                Text(startTimeAsString)
                                    .foregroundColor(.accentColor)
                                    .onAppear {
                                        self.startTimeAsString = timeFormatter.string(from: startTime)
                                    }
                                    .onTapGesture {
                                        self.showAlertBox = true
                                        self.pathNumber = 2
                                    }
                                Text("until")
                                Text(endTimeAsString)
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
                
            }
            .scaleEffect(1.3)
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(images: $images, showPicker: $showImagePicker, limit: 1)
            })
            .onAppear {

            }
            
            
            if showAlertBox {
                switch pathNumber {
                
                // AlertBox to define the category
                case 0:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", pickerInput: true, pickerInputArray: ["Café", "Sport", "Other"], output: $category, show: $showAlertBox, accepted: $accepted)
                    
                // AlertBox to define the date
                case 1:
                    AlertBoxView(title: "Choose a date", placeholder: dateFormatter.string(from: date), defaultText: dateFormatter.string(from: date), dateInput: true, output: $dateAsString, show: $showAlertBox, accepted: $accepted)
                    
                // AlertBox to define the startTime of the event
                case 2:
                    AlertBoxView(title: "Choose the starttime of your event", placeholder: timeFormatter.string(from: startTime), defaultText: timeFormatter.string(from: startTime), dateInput: true, dateFormat: "HH:mm", output: $startTimeAsString, show: $showAlertBox, accepted: $accepted)
                    
                // AlertBox to define the endTime of the event
                case 3:
                    AlertBoxView(title: "Choose the endtime of your event", placeholder: timeFormatter.string(from: endTime), defaultText: timeFormatter.string(from: endTime), dateInput: true, dateFormat: "HH:mm", output: $endTimeAsString, show: $showAlertBox, accepted: $accepted)
                
                // AlertBox to define the picture
//                case 99:
//                    showImagePicker = true
//                    ImagePicker(isShown: $showAlertBox, isDone: $accepted, image: $image, originalImage: $uiImage, sourceType: .photoLibrary)
                    
                default:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", output: $category, show: $showAlertBox, accepted: $accepted)
                }
            }
            
            Image(systemName: "xmark.circle")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(10)
                .background(BlurView(style: .systemMaterial))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                .scaleEffect(buttonPressed ? 0.8 : 1)
                .opacity(buttonPressed ? 0.5 : 1)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                .onTapGesture {
                    // button animation start
                    buttonPressed.toggle()
                    
                    // haptic feedback when button is tapped
                    hapticPulse(feedback: .rigid)
                    
                    // close view
                    presentation = false
                }
                .offset(x: 130, y: -320)
            
        }
        
    }
    
    func createUpdateEvent() -> EventModelObject {
        let event = EventModel(eventId: "", userId: "", name: "", category: category, date: date, startTime: startTime, endTime: endTime, pictureURL: pictureURL, profilePicture: "", likedUser: false,eventMatched: false)
        
        let eventObject = EventModelObject(eventModel: event, position: .constant(.zero))

        return eventObject
    }
    
    // function to convert strings into dates for upload into the database
    func prepareUpload() {
        eventCreationVM.category = category
        eventCreationVM.pictureURL = pictureURL
        eventCreationVM.date = dateFormatter.date(from: dateAsString) ?? Date()
        eventCreationVM.startTime = timeFormatter.date(from: startTimeAsString) ?? Date()
        eventCreationVM.endTime = timeFormatter.date(from: endTimeAsString) ?? Date()
        
    }
}

struct EventCreationView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationView(presentation: .constant(true), eventArray: .constant([stockEventObject]))
    }
}
