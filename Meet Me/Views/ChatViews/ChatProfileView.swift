//
//  ChatProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 05.03.21.
//

import SwiftUI

struct ChatProfileView: View {
    
    @Binding var event: EventModel
    @Binding var showChatProfileView: Bool
    
    var body: some View {
        
        ZStack {
            
            // MARK: Tab-able Background
            Color.black.opacity(0.0001)
                .onTapGesture {
                    withAnimation(.default) {
                        showChatProfileView = false
                    }
                }
            
            // MARK: Profile on top
            YouProfileNView(showYouProfileView: $showChatProfileView, event: $event)
            
        }
    }
}

struct ChatProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChatProfileView(event: .constant(stockEvent), showChatProfileView: .constant(true))
    }
}

