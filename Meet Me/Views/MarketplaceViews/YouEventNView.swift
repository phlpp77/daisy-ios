//
//  YouEventNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.03.21.
//

import SwiftUI

struct YouEventNView: View {
    
    @Binding var events: [EventModel]
    @Binding var eventIndex: Int
    @Binding var currentEvent: EventModel
    
    // to configure the date which is showing in the second line of the row
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "d. MMM"
        return formatter
    }()
    var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        
        ZStack {
            
            // event-picture incl. the white border
            base
            
            // MARK: - Information-Box at the bottom of the Event
            ZStack {
                
                // MARK: Background of the Information-Box
                BlurView(style: .systemUltraThinMaterial)
                    .frame(width: 278, height: 71)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(
                                LinearGradient(
                                            gradient: Gradient(stops: [
                                        .init(color: Color(#colorLiteral(red: 0.7791666388511658, green: 0.7791666388511658, blue: 0.7791666388511658, alpha: 0.949999988079071)), location: 0),
                                        .init(color: Color(#colorLiteral(red: 0.7250000238418579, green: 0.7250000238418579, blue: 0.7250000238418579, alpha: 0)), location: 1)]),
                                            startPoint: UnitPoint(x: 0.9016393067273221, y: 0.10416647788375455),
                                            endPoint: UnitPoint(x: 0.035519096038869824, y: 0.85416653880629)),
                                lineWidth: 0.5
                            )
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
                
                // MARK: Content of Information-Box
                HStack {
                    // Category and the location-indicator
                    VStack(alignment: .leading, spacing: 0.0) {
                        Text(currentEvent.category)
                        HStack {
                            Text("Near")
                            Image(systemName: "location.fill")
                        }
                    }
                    .padding(.horizontal, 8)
                    // Divider and Spacer to separate Category-location and Time-data
                    Spacer()
                    Divider()
                    Spacer()
                    // Time-data in vertical order
                    VStack(alignment: .leading, spacing: 0.0) {
                        Text(dateFormatter.string(from: currentEvent.date))
                        Text(timeFormatter.string(from: currentEvent.startTime))
                            .foregroundColor(.accentColor)
                    }
                    .padding(.horizontal, 8)
                }
                .font(.title3)
                .frame(width: 272, height: 68)
            }
            
        }
        
        // MARK: - OnAppear
        .onAppear {
            //
        }
    }
    
    // MARK: -
    var base: some View {
        // MARK: Base (including picture) of the Event
        ZStack {
            
            // MARK: White Background
            Color("Offwhite")
                .frame(width: 278, height: 278)
                .clipShape(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                )
            
            // MARK: Image downloaded from the Database
            // FIXME: Needs to be changed to URL Image
            Image("cafe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 260 , height: 260)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
        }
    }
    
}

struct YouEventN_Previews: PreviewProvider {
    static var previews: some View {
        YouEventNView(events: .constant([stockEvent]), eventIndex: .constant(0), currentEvent: .constant(stockEvent))
    }
}
