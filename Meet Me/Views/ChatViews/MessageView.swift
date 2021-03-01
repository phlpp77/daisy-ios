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
    
    @Binding var message: MessageModel
    @State var messageStyle: MessageStyle = .creator
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "HH:mm dd/MM/yy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0.0) {
//            Text(dateFormatter.string(from: Date(timestamp: message.timeStamp))
//                .font(.footnote)
//                .foregroundColor(.accentColor)
//                .padding(.top, 8)
//                .frame(maxWidth: 250, alignment: .trailing)
//                .padding(.horizontal, 8)
//                .fixedSize(horizontal: true, vertical: false)

            
            Text(message.messageText)
                .padding(.horizontal)
                .padding(.bottom)
                .frame(maxWidth: 250, alignment: messageStyle == .receiver ? .leading : .trailing)
                .fixedSize(horizontal: true, vertical: false)
        }
        .background(messageStyle == .receiver ? Color.gray : Color.green)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .frame(maxWidth: .infinity, alignment: messageStyle == .receiver ? .leading : .trailing)
        .padding()
        
        // on appear to change MessageStyle
        .onAppear {
        //
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: .constant(stockChat.messages[0]))
    }
}
