//
//  TrahedCode.swift
//  Meet Me
//
//  Created by Lukas Dech on 18.02.21.
//


//    func getUser(){
//        firestoreManagerUser.getAllUsers { result in
//            switch result {
//            case .success(let user):
//                if let user = user {
//                    DispatchQueue.main.async {
//                        self.user = user.map(UserModelObject.init)
//                        self.userModel = self.convertModels(userArray: self.user)
//
//
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

//    func convertModels(userArray: [UserModelObject]) -> UserModel {
//
//        var user: UserModel = stockUser
//
//            user.name = userArray[0].name
//            user.gender = userArray[0].gender
//            user.startProcessDone = userArray[0].startProcessDone
//            user.searchingFor = userArray[0].searchingFor
//            user.url = userArray[0].url
//            user.userId = userArray[0].userId
//            user.birthdayDate = userArray[0].birthdayDate
//
//        return user
//
//
//    }



//func saveUser(userModel: UserModel, completion: @escaping (Result<UserModel?, Error>) -> Void) {
//
//        do {
//            let ref = try db.collection("users").addDocument(from: userModel)
//            ref.getDocument { (snapshot, error) in
//                guard let snapshot = snapshot, error == nil else {
//                    completion(.failure(error!))
//                    return
//                }
//
//                let userModel = try? snapshot.data(as: UserModel.self)
//                completion(.success(userModel))
//            }
//        } catch let error {
//                completion(.failure(error))
//            }
//        }
//
