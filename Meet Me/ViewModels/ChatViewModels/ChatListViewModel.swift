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
                self.getAllMatchInformation(docs: matchDocs)
            }.done { match in
                self.matches = match
            }.catch { error in
                print("DEBUG: error in getMatchesChain error: \(error)")
            }
        }
    

    
    func getAllMatchInformation(docs: [MatchModel]) -> Promise<[AllMatchInformationModel]> {
        return Promise { seal in
            var match : [AllMatchInformationModel]  = []
            for doc in docs {
                firstly{
                    when(fulfilled: self.firestoreManagerChat.getEventWithEventId(eventId: doc.eventId),
                                    self.firestoreManagerChat.getUserWithUserId(userId: doc.matchedUserId))
                }.map{ [self] event, user in
                    let matchInformation = AllMatchInformationModel(chatId: doc.chatId, user: userModel, event: eventModel)
                    match.append(matchInformation)
                    seal.fulfill(match)
                }.catch { error in
                    print(error)
                }
            }
            
        }
    }
}



    
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





