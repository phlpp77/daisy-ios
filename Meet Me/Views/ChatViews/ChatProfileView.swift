//
//  ChatProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 05.03.21.
//

import SwiftUI

struct ChatProfileView: View {
    
    
    @Binding var showChatProfileView: Bool
    @Binding var event: EventModel
//    @Binding var user: UserModel
    
    var body: some View {
        
        ZStack {
            
            // MARK: Tab-able Background
            Color.black.opacity(0.0001)
                .onTapGesture {
                    withAnimation(.default) {
                        showChatProfileView.toggle()
                    }
                }
            
            // MARK: Profile on top
            YouProfileNView(showYouProfileView: $showChatProfileView, event: $event)
            
        }
//        .onAppear {
//            event.userId = user.userId
//
//        }
    }
}

struct ChatProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChatProfileView(showChatProfileView: .constant(true), event: .constant(stockEvent))
    }
}

