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
    
    @StateObject var messagesVM: MessagesViewModel = MessagesViewModel()
    @Binding var message: MessageModel
    @State var messageStyle: MessageStyle = .receiver
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_DE")
        formatter.dateFormat = "HH:mm - EEEE"
        return formatter
    }()
    
    var body: some View {
        VStack {
            VStack(alignment: messageStyle == .receiver ? .leading : .trailing, spacing: 5) {
                Text(dateFormatter.string(from: message.timeStamp.dateValue()))
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                
                Text(message.messageText)
            }
            .padding(8)
            .background(messageStyle == .receiver ? Color.gray : Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .frame(width: 250, alignment: messageStyle == .receiver ? .leading : .trailing)
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: messageStyle == .receiver ? .leading : .trailing)
        .padding()
        // on appear to change MessageStyle
        .onAppear {
            // check if the message was received or sent
            if message.userId == messagesVM.userId {
                messageStyle = .creator
            } else {
                messageStyle = .receiver
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: .constant(stockChat.messages[1]))
    }
}
