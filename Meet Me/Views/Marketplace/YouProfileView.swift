//
//  YouProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 13.02.21.
//

import SwiftUI

struct YouProfileView: View {
    
    private var id: String
    private var name: String
    private var birthdayDate: Date
    private var gender: String
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct YouProfileView_Previews: PreviewProvider {
    static var previews: some View {
        YouProfileView(id: "1", name: "Philipp", birthdayDate: Date(), gender: "Male")
    }
}
