//
//  PickerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.01.21.
//

import SwiftUI

struct PickerView: View {
    
    @State var position: String = ""
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                TextField("Test", text: $position)
                    .background(Color.black.opacity(0.6))
                    
            }
        }
        .position(x: screen.width/2, y: screen.height/2)
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PickerView()
                
        }
    }
}
