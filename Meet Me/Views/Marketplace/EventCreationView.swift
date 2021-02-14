//
//  EventCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.02.21.
//

import SwiftUI
import URLImage

struct EventCreationView: View {
    
    // vars to show in the screen
    @State private var category: String = "Café"
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date() + 60*30
    @State private var pictureURL: URL = stockURL
    
    // image handling
    @State private var image: Image? = Image("cafe")
    @State private var uiImage: UIImage? = UIImage(named: "cafe")
    
    // animation of alertboxes
    @State private var showAlertBox: Bool = false
    @State private var pathNumber: Int = 0
    @State private var accepted: Bool = false
    // legacy handling of date as a string
    @State private var dateAsString = ""
    @State private var startTimeAsString = ""
    @State private var endTimeAsString = ""
    
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "d. MMM yyyy"
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
            ZStack {
                // Main image as a backgrond of the event
                Image(uiImage: uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250, alignment: .center)
                .onTapGesture {
                    self.showAlertBox = true
                    self.pathNumber = 99
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
            .background(
                  GeometryReader { proxy in
                    Color.clear
                      
                  }
            )
            
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
                case 99:
                    ImagePicker(isShown: $showAlertBox, image: $image, originalImage: $uiImage, sourceType: .photoLibrary)
                    
                default:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", output: $category, show: $showAlertBox, accepted: $accepted)
                }
            }
            
        }
        
    }
}

struct EventCreationView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationView()
    }
}