//
//  YouProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 13.02.21.
//

import SwiftUI

struct YouProfileView: View {
    
    var id: String
    var name: String
    var birthdayDate: Date
    var gender: String
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct YouProfileView_Previews: PreviewProvider {
    static var previews: some View {
        YouProfileView(id: "1", name: "Philipp", birthdayDate: Date(), gender: "Male")
    }
}
