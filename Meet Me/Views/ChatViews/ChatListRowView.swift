//
//  ChatListRowView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI
import URLImage

struct ChatListRowView: View {
    
    @Binding var match: AllMatchInformationModel
    
    @Binding var chatTapped: Bool
    @Binding var matchTapped: AllMatchInformationModel
    
    @State var firstPartString: String = ""
 
    // to configure the date which is showing in the second line of the row
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "EEEE, d MMM"
        return formatter
    }()
    var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        
        // MARK: RowView of one line in the list
        ZStack {
            HStack {
                
                // profile picture
                URLImage(url: URL(string: match.user.userPhotos[1] ?? stockUrlString)!) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.9), Color.gray]), startPoint: .topTrailing, endPoint: .bottomLeading),
                                    lineWidth: 4
                                )
                        )
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading) {
                    
                    // first row with event-type
                    HStack(spacing: 0.0) {
                        Text(firstPartString)
                        Text(" \(match.user.name)")
                            .foregroundColor(.accentColor)
                    }
                    .font(.system(size: 22))
                    
                    // second row with event date
                    HStack(spacing: 0.0) {
                        Text(dateFormatter.string(from: match.event.date))
                        Text(" at ")
                        Text(timeFormatter.string(from: match.event.startTime))
                    }
                    .font(.subheadline)
                }
                .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .modifier(FrozenWindowModifier())
            .padding(.horizontal, 10)
            
            // show soon when Event is in the next 12 hours
            if Date().distance(to: match.event.date) < 43200 {
                Text(Date().distance(to: match.event.date) < 0 ? "EVENTover" : "Soon!")
                    .padding(4)
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .mask(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
                    .offset(x: -60, y: -35)
            }
            
        }
        // tapping on the item
        .onTapGesture {
            print("event \(match.event) with user \(match.user) tapped")
            matchTapped = match
            chatTapped = true
        }

        // on appear
        .onAppear {
            switch match.event.category {
            case "Café":
                firstPartString = "Drinking coffee with"
            default:
                firstPartString = "Event with"
            }
    }
    }
}

struct ChatListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListRowView(match: .constant(AllMatchInformationModel(chatId: "", user: stockUser, event: stockEvent)), chatTapped: .constant(false), matchTapped: .constant(AllMatchInformationModel(chatId: "", user: stockUser, event: stockEvent)))
    }
}
