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
    
    var body: some View {
        
        ZStack {
            
            BlurView(style: .systemUltraThinMaterialDark)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showChatEventView.toggle()
                    }
                }
            
            YouEventView(eventModelObject: event, eventIndex: 0, dragPossible: false, eventArray: .constant([stockEvent]))
                .scaleEffect(1.2)
        }
    }
}

struct ChatEventView_Previews: PreviewProvider {
    static var previews: some View {
        ChatEventView(event: .constant(stockEvent), showChatEventView: .constant(true))
    }
}
