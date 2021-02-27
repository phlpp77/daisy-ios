//
//  SwiftUIView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Wenn Budni nicht wieder saufen würde, könnte hier jetzt >Gute Nacht< geschrieben werden..")
            .frame(width: 200, height: 200, alignment: .center)
            .padding()
            .modifier(FrozenWindowModifier())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
