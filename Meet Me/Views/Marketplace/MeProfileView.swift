//
//  MeProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 13.02.21.
//

import SwiftUI

struct MeProfileView: View {
    
    private var userId: String?
    private var name: String
    private var birthdayDate: Date
    private var age: Int
    private var gender: String
    private var searchingFor: String
    private var url: String
    
    init(user: UserModel) {
        userId = user.userId
        name = user.name
        birthdayDate = user.birthdayDate
        age = dateToAge(date: birthdayDate)
        gender = user.gender
        searchingFor = user.searchingFor
        url = user.url
        print(user)
    }
    
    var body: some View {
        VStack {
            Text("That's me!")
                .font(.largeTitle)
                .frame(width: 340, alignment: .leading)
            
            Image("Philipp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.9), lineWidth: 15)
                )
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            Spacer()
            
            // lower part
            VStack {
                
                // First Line with data
                HStack {
                    Text(name)
                    
                    Spacer()
                    
                    HStack {
                        Text(String(age))
                            .foregroundColor(.accentColor)
                        Text("Years old")
                    }
                }
                .font(.headline)
                
                Spacer()
                
                // second line with data
                HStack {
                    HStack {
                        Text("I am")
                        Text(gender)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Show me")
                        Text(searchingFor)
                            .foregroundColor(.accentColor)
                        Text("users")
                    }
                }
            }
            .padding()
            .frame(height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            
            
        }
        .frame(width: 340, height: 450, alignment: .center)
    }
}

func dateToAge(date: Date) -> Int {
//    let dateComponents = DateComponents()
    let lifeTime = date.timeIntervalSinceNow
    let years = -lifeTime / 60 / 60 / 24 / 365
    return Int(years)
    
}

struct MeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileView(user: testUser)
    }
}



// test user
let testUser: UserModel = UserModel(userId: "007", name: "Philipp", birthdayDate: createSampleDate(), gender: "Male", searchingFor: "Female")

// date creation for testing
func createSampleDate() -> Date {
    
    var dateComponents = DateComponents()
    dateComponents.year = 1998
    dateComponents.month = 9
    dateComponents.day = 6
    
    // since the components above (like year 1980) are for Gregorian
    let userCalendar = Calendar(identifier: .gregorian)
    
    let someDateTime = userCalendar.date(from: dateComponents)!
    return someDateTime
}
