//
//  EventCreationView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.02.21.
//

import SwiftUI

struct EventCreationView: View {
    
    // vars to show in the screen
    @State private var category: String = "Café"
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date() + 60*30
    @State private var pictureURL: URL = stockURL
    
    // animation of alertboxes
    @State private var showAlertBox: Bool = false
    @State private var pathNumber: Int = 0
    @State private var accepted: Bool = false
    // legacy handling of date as a string
    @State private var dateAsString = ""
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
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
            // Main image as a backgrond of the event
            Image(uiImage: #imageLiteral(resourceName: "cafe"))
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(category)
                        .onTapGesture {
                            self.showAlertBox = true
                            self.pathNumber = 0
                        }
                    
                    Spacer()
                    Divider()
                    
                    Text(dateFormatter.string(from: date))
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
                        Text(timeFormatter.string(from: startTime))
                            .foregroundColor(.accentColor)
                        Text("until")
                        Text(timeFormatter.string(from: endTime))
                    }
                    .font(.headline)
//                        .padding(.horizontal, 20)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .frame(width: 250)
                .background(BlurView(style: .systemUltraThinMaterial))
            }
            
            if showAlertBox {
                switch pathNumber {
                
                // AlertBox to define the category
                case 0:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", output: $category, show: $showAlertBox, accepted: $accepted)
                
                // AlertBox to define the date
                case 1:
                    AlertBoxView(title: "Choose a date", placeholder: dateFormatter.string(from: date), defaultText: dateFormatter.string(from: date), output: $dateAsString, show: $showAlertBox, accepted: $accepted)
                    
                default:
                    AlertBoxView(title: "Choose a category", placeholder: "Café", defaultText: "Café", output: $category, show: $showAlertBox, accepted: $accepted)
                }
            }
        }
//        .frame(width: 250, height: 250, alignment: .center)
        .frame(width: 400, height: 500, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 15)
        .background(
              GeometryReader { proxy in
                Color.clear
                  
              }
            )
    }
}

struct EventCreationView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationView()
    }
}
