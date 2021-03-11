//
//  MeProfileSecondBlockView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import SwiftUI


struct MeProfileSecondBlockView: View {
    @StateObject var meProfileVM: MeProfileViewModel = MeProfileViewModel()
    
    //@State private var range: Double = 150
    //@State private var pickedGender = 1
    private var genders = ["Female", "Male", "Other"]
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("BackgroundSecondary"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
    
    var body: some View {
        VStack {
            
            // MARK: Title of the second block
            HStack(spacing: 0.0) {
                Text("The way ")
                Text("ME")
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(.accentColor)
                Text(" search")
            }
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            // MARK: Slider for searching range
            VStack {
                // title
                HStack(spacing: 0.0) {
                    Text("Show me YOUs within ")
                    Text(String(Int(meProfileVM.userModel.radiusInKilometer)))
                    Text(" km")
                        .foregroundColor(.accentColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                // slider
                Slider(value: $meProfileVM.userModel.radiusInKilometer, in: 5...150) { (editingChanged) in
                    //
                }
                .accentColor(Color("BackgroundSecondary"))
            }
            
            
            // MARK: Segmented Picker for picking searching for gender
            VStack {
                // title
                HStack(spacing: 0.0) {
                    Text("Show me ")
                    Text(meProfileVM.userModel.searchingFor)
                        .foregroundColor(.accentColor)
                    Text(" YOUs")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                // segmented picker
                Picker("Test", selection: $meProfileVM.picked) {
                    Text("Female").tag(0)
                    Text("Male").tag(1)
                    Text("Both").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
        }
        .padding()
        .frame(width: 327, height: 200)
        .modifier(offWhiteShadow(cornerRadius: 14))
        .onAppear {
            meProfileVM.getCurrentUser()
 
            }
        .onDisappear{
            print("disaper")
            meProfileVM.changedSearchingFor(searchingFor: meProfileVM.picked)
            meProfileVM.changedRange(radius: meProfileVM.userModel.radiusInKilometer)
            
        }
        }
    }


struct MeProfileSecondBlockView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileSecondBlockView()
    }
}
