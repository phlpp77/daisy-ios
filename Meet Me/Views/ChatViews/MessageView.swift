//
//  MessageView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

enum MessageStyle {
    case creator
    case receiver
}

struct MessageView: View {
    
    @Binding var messageText: String
    @Binding var messageStyle: MessageStyle
    
    var body: some View {
        VStack {
            Text(messageText)
                .padding()
                .background(messageStyle == .receiver ? Color.gray : Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
        }
        .frame(maxWidth: .infinity, alignment: messageStyle == .receiver ? .leading : .trailing)
        .padding()
        // on appear to get MessageStyle
        .onAppear {
        //
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(messageText: .constant("Test Message.."), messageStyle: .constant(.creator))
    }
}
