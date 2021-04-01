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
    @State var userModel: UserModel = stockUser
    private var developerIds: [String] = []
    @StateObject var locationManager = LocationManager()
    @ObservedObject var developerManager = DeveloperManager()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    
    
    var body: some View {
        
        // shows the main screen if the startProcess (user-creation) is done OR logged into firebase
        ZStack {
            if startProcessDone || userIsLoggedIn {
                TabBarView(startProcessDone: $startProcessDone).environmentObject(locationManager)
            } else {
                MainStartView(startUpDone: $startProcessDone)
            }
            
            if loading {
                AppLaunchView()
            }
            
            // FIXME: @budni put bool from database here to switch the whole app in maintenance mode
            if developerManager.developerOptionsModel.maintenance && !developerIds.contains(userModel.userId) {
                MaintenanceView()
            }
        }
        .onAppear {
            checkUserAccForAutoLogin()
            ckeckMaintenanceMode()
        }
        .onChange(of: startProcessDone, perform: { value in
            print("before check. startprocess: \(startProcessDone) and userlogged: \(userIsLoggedIn)")
            checkUserAccForAutoLogin()
            print("after check. startprocess: \(startProcessDone) and userlogged: \(userIsLoggedIn)")
        })
        
    }
    
    func checkUserAccForAutoLogin(){
        if Auth.auth().currentUser != nil{
            firstly {
                self.firestoreManagerUserTest.getCurrentUser()
            }.done { userModel in
                self.userModel = userModel
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
    
    func ckeckMaintenanceMode() {
        firstly {
            self.developerManager.getMaintenanceMode()
        }.catch { error in
            print(error)
        }
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}
