//
//  YouEventView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI

struct YouEventView: View {
    
    // Bindings
    @Binding var dragPosition: CGSize
    
    // vars to show in the screen
    private var category: String
    private var date: Date
    private var startTime: Date
    private var endTime: Date
    private var pictureURL: URL

    init(dragPosition: Binding<CGSize>, eventModelObject: EventModelObject) {
        
        // binding set (that is why there is a underscore _ in the front
        self._dragPosition = dragPosition
        
        category = eventModelObject.category
        date = eventModelObject.date
        startTime = eventModelObject.startTime
        endTime = eventModelObject.endTime
        pictureURL = eventModelObject.pictureURL
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
            // Main image as a backgrond of the event
            Image(uiImage: #imageLiteral(resourceName: "cafe"))
                .resizable()
                .aspectRatio(contentMode: .fill)
            
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
        }
        .frame(width: 250, height: 250, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 15)
        .background(
              GeometryReader { proxy in
                Color.clear
                  
              }
            )
    }
    
}

//struct YouEventView_Previews: PreviewProvider {
//    
//    @State var cgsize: CGSize = .zero
//    
//    static var previews: some View {
//        YouEventView(dragPosition: $cgsize)
//    }
//}