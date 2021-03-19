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
            
            BlurView(style: .systemUltraThinMaterialDark)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showChatEventView.toggle()
                    }
                }
            
//            YouEventView(eventModelObject: event, eventIndex: 0, dragPossible: false, eventArray: .constant([stockEvent]))
            YouEventNView(events: $events, eventIndex: 0, currentEvent: event, dragAllowed: false)
                .scaleEffect(1.2)
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
