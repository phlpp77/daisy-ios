//
//  ChatEventView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 06.03.21.
//

import SwiftUI

struct ChatEventView: View {
    
    @Binding var event: EventModel
    @Binding var showChatEventView: Bool
    @State var events: [EventModel] = []
    
    var body: some View {
        
        ZStack {
            
            // MARK: Tab-able background
            Color.black.opacity(0.0001)
                .onTapGesture {
                    withAnimation(.default) {
                        showChatEventView.toggle()
                    }
                }
            
            
            VStack {
                // MARK: Show Event on top
                YouEventNView(events: $events, eventIndex: 0, currentEvent: event, dragAllowed: false)
                    .scaleEffect(1.2)
                
                // xmark symbol to show the user how to dismiss the view
                Image(systemName: "xmark")
                    .foregroundColor(Color("BackgroundSecondary").opacity(0.7))
                    .font(.system(size: 30))
                    .padding(.top, 55)
            }
        }
        .onAppear {
            events.append(event)
        }
    }
}

struct ChatEventView_Previews: PreviewProvider {
    static var previews: some View {
        ChatEventView(event: .constant(stockEvent), showChatEventView: .constant(true))
    }
}
