//
//  ChatListRowView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI
import URLImage

struct ChatListRowView: View {
    
    @Binding var user: UserModel
    @Binding var event: EventModel
    
    @Binding var chatTapped: Bool
    
    @State var firstPartString: String = ""
    
    var body: some View {
        
        // MARK: RowView of one line in the list
        HStack {
            
//            URLImage(url: URL(string: user.userPhotos[0]!) ?? stockURL) { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 36, height: 36)
//            }
            Image("Philipp")
                .resizable()
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
            
            HStack(spacing: 0.0) {
                Text(firstPartString)
                Text(" \(user.name)")
                    .foregroundColor(.accentColor)
            }
            .font(.system(size: 22))
            
        
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .modifier(FrozenWindowModifier())
        .padding(.horizontal, 10)
        
        // on appear
        .onAppear {
            switch event.category {
            case "Café":
                firstPartString = "Drinking coffee with"
            default:
                firstPartString = "Event with"
            }
        }
        
        // tapping on the item
        .onTapGesture {
            print("event \(event) with user \(user) tapped")
            chatTapped = true
        }
    }
}

struct ChatListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListRowView(user: .constant(stockUser), event: .constant(stockEvent2), chatTapped: .constant(false))
    }
}
