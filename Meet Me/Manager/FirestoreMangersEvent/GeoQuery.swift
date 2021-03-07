//
//  GeoQuery.swift
//  Meet Me
//
//  Created by Lukas Dech on 07.03.21.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
import MapKit
import GeoFire
import PromiseKit

class GeoQuery {
    
    private var db: Firestore
    
    
    init() {
        db = Firestore.firestore()
        
    }
    
    func queryColletion(center : CLLocationCoordinate2D) -> Promise<[Query]> {
        return Promise { seal in
            let center = CLLocationCoordinate2D(latitude: 53.5466399, longitude: 9.93079)
            let radiusInKilometers: Double = 50
            
            let queryBounds = GFUtils.queryBounds(forLocation: center,
                                                  withRadius: radiusInKilometers)
            let queries = queryBounds.compactMap { (any) -> Query? in
                guard let bound = any as? GFGeoQueryBounds else { return nil }
                return db.collection("events")
                    .order(by: "hash")
                    .start(at: [bound.startValue])
                    .end(at: [bound.endValue])
            }
            seal.fulfill(queries)
            
        }
    }
    
    func querysInEvent(likedEvents: [String], queries: [Query], center : CLLocationCoordinate2D) ->Promise<[EventModelObject]> {
        return Promise { seal in
            
            
            let userPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)
            
        
            guard let currentUser = Auth.auth().currentUser else {
                seal.reject(Err("No User Profile"))
                return
            }
            
            for query in queries {
                query.getDocuments {(snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    }else {
                        
                        if let snapshot = snapshot {
                            var event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                                var event = try? doc.data(as: EventModel.self)
                                event?.eventId = doc.documentID
                                if var event = event {
                                    if event.userId != currentUser.uid && event.eventMatched == false {
                                        let eventPoint = CLLocation(latitude: event.latitude, longitude: event.longitude)
                                        event.distance = GFUtils.distance(from: userPoint, to: eventPoint)
                                        print("EventDistance: \(event.distance)")
                                        return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
                                    }
                                }
                                return nil
                            }
                            if event != nil {
                                for (index, eventModel) in event!.enumerated().reversed() {
                                    if likedEvents.contains(eventModel.eventId) {
                                        event!.remove(at: index)
                                    }
                                }
                                DispatchQueue.main.async {
                                    seal.fulfill(event!)
                                }
                            } else {
                                let error = Err("No Events in GetYouEvents")
                                DispatchQueue.main.async {
                                    seal.reject(error)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
}
//
//    //(latitude: 53.5466399, longitude: 9.93079)
//    // Find cities within 50km of London
//    let center = CLLocationCoordinate2D(latitude: 53.5466399, longitude: 9.93079)
//    let radiusInKilometers: Double = 50
//    var matchingDocs = [QueryDocumentSnapshot]()
//    // Each item in 'bounds' represents a startAt/endAt pair. We have to issue
//    // a separate query for each pair. There can be up to 9 pairs of bounds
//    // depending on overlap, but in most cases there are 4.
//    func query() {
//        let queryBounds = GFUtils.queryBounds(forLocation: center,
//                                              withRadius: radiusInKilometers)
//        let queries = queryBounds.compactMap { (any) -> Query? in
//            guard let bound = any as? GFGeoQueryBounds else { return nil }
//            print("TEST: bound \(bound)")
//            return db.collection("events")
//                .order(by: "hash")
//                .start(at: [bound.startValue])
//                .end(at: [bound.endValue])
//        }
//
//
//        for query in queries {
//            query.getDocuments {(snapshot, error) in
//                if let error = error {
//                    print(error)
//                }else {
//
//                    if let snapshot = snapshot {
//                        let event: [EventModelObject]? = snapshot.documents.compactMap { doc in
//                            var event = try? doc.data(as: EventModel.self)
//                            event?.eventId = doc.documentID
//                            if let event = event {
//                                //if event.userId != currentUser.uid && event.eventMatched == false {
//                                    return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
//                                //}
//                            }
//                            return nil
//                        }
//                        if event != nil {
//                            //for (index, eventModel) in event!.enumerated().reversed() {
//                                //if likedEvents.contains(eventModel.eventId) {
//                                   // event!.remove(at: index)
//                               // }
//                            //}
//                            DispatchQueue.main.async {
//                                print(event!)
//                            }
//                        } else {
//                            let error = Err("No Events in GetYouEvents")
//                            DispatchQueue.main.async {
//                                print(error)
//                            }
//
//                        }
//                    }
//                }
//            }
//                    // Collect all the query results together into a single list
//                    func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) -> () {
//                        print("funktion aufgerufen")
//                        guard let documents = snapshot?.documents else {
//                            print("Unable to fetch snapshot data. \(String(describing: error))")
//                            return
//                        }
//                        print(documents)
//                        for document in documents {
//                            let lat = document.data()["lat"] as? Double ?? 0
//                            let lng = document.data()["lng"] as? Double ?? 0
//                            let coordinates = CLLocation(latitude: lat, longitude: lng)
//                            let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)
//
//                            // We have to filter out a few false positives due to GeoHash accuracy, but
//                            // most will match
//                            let distance = GFUtils.distance(from: centerPoint, to: coordinates)
//                            if distance <= radiusInKilometers {
//                                matchingDocs.append(document)
//                            }
//                        }
//                    }
//
//                    // After all callbacks have executed, matchingDocs contains the result. Note that this
//                    // sample does not demonstrate how to wait on all callbacks to complete.
//
//                }
//    }
//}








