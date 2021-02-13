//
//  PickerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.01.21.
//

import SwiftUI

struct PickerView: View {
    
    @State var position: CGSize = .zero
    
    var body: some View {
        List {
            ForEach(0 ..< 5) { item in
                YouEventView(dragPosition: $position)
//                Text("Test")
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PickerView()
                
        }
    }
}
