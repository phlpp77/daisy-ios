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
    private var matchDoc : [MatchModel] = []
    @Published var matches : [AllMatchInformationModel] = []
    
    
    func getMatches() {
            firstly {
                self.firestoreManagerChat.getAllMatchDocumentsCurrentUser()
            }.map { matchDocs in
                self.matchDoc = matchDocs
                print(self.matchDoc)
            }.then {
                self.getAllMatchInformation()
            }.done { match in
                print("DDDD\(match)")
                self.matches = match
                print("DDDD\(self.matches)")
            }.catch { error in
                print("DEBUG: error in getMatchesChain error: \(error)")
            }
        }
    

    
    func getAllMatchInformation() -> Promise<[AllMatchInformationModel]> {
        return Promise { seal in
            var match : [AllMatchInformationModel]  = []
            for doc in matchDoc {
                firstly{
                    self.firestoreManagerChat.getEventWithEventId(eventId: doc.eventId)
                }.map { event in
                    self.eventModel = event
                }.then {
                    self.firestoreManagerChat.getUserWithUserId(userId: doc.matchedUserId)
                }.map { user in
                    self.userModel = user
                }.done { [self] in
                    
                    let matchInformation = AllMatchInformationModel(chatId: doc.chatId, user: userModel, event: eventModel)
                    print(matchInformation)
                    match.append(matchInformation)
                    seal.fulfill(match)
                }.catch { error in
                    print(error)
                }
            }
        }
    }
}





