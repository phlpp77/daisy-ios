//
//  PickerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.01.21.
//

import SwiftUI

struct PickerView: View {
    
    @State var lastSelectedIndex = ""
    
    var body: some View {
        VStack {
            PickerTextField(data: ["1", "2", "Albert"], placerholder: "Select item", selectedOutput: $lastSelectedIndex)
            Text(lastSelectedIndex)
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
