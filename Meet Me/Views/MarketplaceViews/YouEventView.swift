//
//  YouEventView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI
import URLImage

struct YouEventView: View {
    
    
    @StateObject var youEventVM = YouEventViewModel()
    // Bindings
    @Binding var eventArray: [EventModelObject]
    var eventIndex: Int
    var dragPossible: Bool = true
    
    // States
    @State var dragPosition: CGSize = .zero
    
    // vars to show in the screen
    private var category: String
    private var date: Date
    private var startTime: Date
    private var endTime: Date
    private var pictureURL: String
    private var profilePictureUrl: String

    init(eventModelObject: EventModelObject, eventIndex: Int, dragPossible: Bool, eventArray: Binding<[EventModelObject]>) {
        
        self._eventArray = eventArray
        self.eventIndex = eventIndex
        self.dragPossible = dragPossible
        
        category = eventModelObject.category
        date = eventModelObject.date
        startTime = eventModelObject.startTime
        endTime = eventModelObject.endTime
        pictureURL = eventModelObject.pictureURL
        profilePictureUrl = eventModelObject.profilePicture
        
    }
    
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
            // Main image as a background of the event
            URLImage(url: URL(string: pictureURL) ?? stockURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250, alignment: .center)
            }
                
            
            VStack(alignment: .leading) {
                HStack {
                    Text(category)
                    
                    Spacer()
                    Divider()
                    
                    Text(dateFormatter.string(from: date))
                    
                }
                .padding(.horizontal, 8)
                .frame(width: 250, height: 30)
                .background(BlurView(style: .systemThickMaterial))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                
                Spacer()
                
                HStack {
                    URLImage(url: URL(string: profilePictureUrl) ?? stockURL) { image in
                        image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60, alignment: .center)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.9), lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    }
                    
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
        }
        .frame(width: 250, height: 250, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 15)
        .offset(x: dragPosition.width, y: dragPosition.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if dragPossible {
                        // drag is not allowed to be higher than 20 upwards
                        if value.translation.height > -20 {
                            self.dragPosition = value.translation
                        }
                        
                    }
                }
                .onEnded { value in
                    if dragPossible {
                        if value.translation.height > 100 {
                            self.dragPosition = .init(width: 0, height: 500)
                            // delete the item at the position from the Array
                            youEventVM.addLikeToEvent(eventId: eventArray[eventIndex].eventId)
                            self.eventArray.remove(at: eventIndex)

                        } else {
                            
                            self.dragPosition = .zero
                        }
                    }
                    
                }
            )
        .animation(.interactiveSpring(), value: dragPosition)
        .onAppear {

        }
    }
    
}

struct YouEventView_Previews: PreviewProvider {
    
    @State var cgsize: CGSize = .zero
    
    static var previews: some View {
        YouEventView(eventModelObject: stockEventObject, eventIndex: 0, dragPossible: false, eventArray: .constant([stockEventObject]))
    }
}
