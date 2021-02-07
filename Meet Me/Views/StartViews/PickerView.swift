//
//  PickerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.01.21.
//

import SwiftUI

struct PickerView: View {
    
    @State var date: Date = Date()
    @State var lastIndex: Int?
    
    var body: some View {
        VStack {
            DateTextField(date: $date)
            Text(String(lastIndex ?? 0))
                .font(.largeTitle)
        }
        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PickerView()
                
        }
    }
}
