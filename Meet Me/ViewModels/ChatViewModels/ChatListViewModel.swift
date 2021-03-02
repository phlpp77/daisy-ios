//
//  ChatListViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 28.02.21.
//


//Alle MatchInformationModels
import Foundation
import PromiseKit


class ChatListViewModel: ObservableObject {
    
    private var firestoreManagerChat: FirestoreManagerChat = FirestoreManagerChat()
    
    private var userModel: UserModel = stockUser
    private var eventModel: EventModel = stockEvent
    //private var matchDoc : [MatchModel] = []
    @Published var matches : [AllMatchInformationModel] = [AllMatchInformationModel(chatId: "egal", user: stockUser, event: stockEvent)]
    
    
    func getMatches() {
            firstly {
                self.firestoreManagerChat.getAllMatchDocumentsCurrentUser()
            }.then { matchDocs in
                self.mapAllMatches(docs: matchDocs)
            }.done { match in
                self.matches = match
            }.catch { error in
                print("DEBUG: error in getMatchesChain error: \(error)")
            }
        }
    
    func mapAllMatches(docs: [MatchModel]) -> Promise <[AllMatchInformationModel]> {
        return Promise { seal in
            
    }
    
    func getAllMatchInformation(doc: MatchModel) -> Promise<AllMatchInformationModel> {
        return Promise { seal in
                firstly{
                    when(fulfilled: self.firestoreManagerChat.getEventWithEventId(eventId: doc.eventId),
                                    self.firestoreManagerChat.getUserWithUserId(userId: doc.matchedUserId))
                }.done{ event, user in
                     let matchInformation = AllMatchInformationModel(chatId: doc.chatId, user: user, event: event)
                    seal.fulfill(matchInformation)
                }.catch { error in
                    print(error)
                }
            }
            
        }
    }
}

//func bar() -> Promise<T?> {
//    //…
//}
//
//func baz() -> Promise<T> {
//    return bar().then {
//        if let done = value {
//            return Promise(value: done)
//        } else {
//            return baz()
//        }
//    }
//}
//
//baz().then { value in
//    // all done
//}



    
//    func getPosts(_ ids: [String]) -> Promise<Void> {
//        return Promise.value(ids).thenMap { id in
//            Promise<data> { resolver in
//                db.collection("data").whereField("id", isEqualTo: id).getDocuments { dataForId, error in
//                    guard let error = error else { resolver.fulfill(dataForId) }
//                    resolver.reject(error)
//                }
//            }
//        }
//        .done { allDataForIds in
//            self.arr = allDataForIds
//        }
//        .catch { error in
//            // handle error
//        }
//    }
//}





