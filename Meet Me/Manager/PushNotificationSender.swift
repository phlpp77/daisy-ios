//
//  PushNotificationSender.swift
//  Meet Me
//
//  Created by Lukas Dech on 13.03.21.
//
import Firebase
import PromiseKit
import UIKit
class PushNotificationSender {
    

    func sendPushNotification(to token: String, title: String, body: String) {
        print("sendaufgerufen")
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        
        print("1")
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        print("2")
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        print("3")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAdTGBNWM:APA91bH_sCDcIS8FNjzYqmuUBtbu70Pw6Ymt1LHUsmXd3cIp-4vLxLQy54ZIn2VlVZeHVr0gtSQ7SGlO7U-oEKadRhp1lsF7zayV2XD4Hx8-wUnKtD7bc92gRosPA82aC2VGP_zHwPk_", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            print("4")
            print(data!)
            print(response!)
            do {
                if let jsonData = data {
                    print("jsonData :  \(jsonData)")
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        print("5")
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
                print("6")
            } catch let err as NSError {
                print("ERRROR")
                print(err.debugDescription)
            }
        }
        print("7")
        task.resume()
    }
}
    
    
    
//    func push(message: String, token: String) {
//        print("push")
//    //var token: String?
////        for person in self.users {
////            if toUser == person.username && person.firebaseToken != nil {
////                token = person.firebaseToken
////            }
////        }
//
//            var request = URLRequest(url: URL(string: "https://fcm.googleapis.com/fcm/send")!)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("AAAAdTGBNWM:APA91bH_sCDcIS8FNjzYqmuUBtbu70Pw6Ymt1LHUsmXd3cIp-4vLxLQy54ZIn2VlVZeHVr0gtSQ7SGlO7U-oEKadRhp1lsF7zayV2XD4Hx8-wUnKtD7bc92gRosPA82aC2VGP_zHwPk_", forHTTPHeaderField: "Authorization")
//            let json = [
//                "to" : token,
//                "priority" : "high",
//                "notification" : [
//                    "body" : message
//                ]
//            ] as [String : Any]
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                request.httpBody = jsonData
//                let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                    guard let data = data, error == nil else {
//                        print("Error=\(error)")
//                        return
//                    }
//
//                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//                        // check for http errors
//                        print("Status Code should be 200, but is \(httpStatus.statusCode)")
//                        print("Response = \(response)")
//                    }
//
//                    let responseString = String(data: data, encoding: .utf8)
//                    print("responseString = \(responseString)")
//                }
//                task.resume()
//            }
//            catch {
//                print(error)
//            }
//
//    }
//}
