//
//  MainControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI
import FirebaseAuth
import PromiseKit

struct MainControllerView: View {
    
    @State var startProcessDone: Bool = false
    @State var userIsLoggedIn: Bool = false
    @State var loading: Bool = true
    @State var startTab = 2
    @StateObject var locationManager = LocationManager()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    
    var body: some View {
        
        // shows the main screen if the startProcess (user-creation) is done OR logged into firebase
        ZStack {
            if (startProcessDone || userIsLoggedIn) && false{
                TabBarView(startProcessDone: $startProcessDone).environmentObject(locationManager)
            } else {
                MainStartView(startUpDone: $startProcessDone)
            }
            
            if loading {
                AppLaunchView()
            }
        }
        .onAppear {
            checkUserAccForAutoLogin()
        }
        .onChange(of: startProcessDone, perform: { value in
            checkUserAccForAutoLogin()
        })
        
    }
    
    func checkUserAccForAutoLogin(){
        
        if Auth.auth().currentUser != nil{
            firstly {
                self.firestoreManagerUserTest.getCurrentUser()
            }.done { userModel in
                userIsLoggedIn = true
            }.catch { error in
                userIsLoggedIn = false
            }.finally {
                //disappear loading View
                loading = false
            }
            
        } else {
            userIsLoggedIn = false
            //disappear loading view
            loading = false
        }
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}
