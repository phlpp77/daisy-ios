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
    private var firestoreManagerMatches: FirestoreManagerMatches = FirestoreManagerMatches()
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    //private var userModel: UserModel?
    //private var eventModel: EventModel?
    private var matchDoc : [MatchModel] = []
    @Published var matches : [AllMatchInformationModel] = []
    
    
    func getMatches() {
            firstly {
                self.firestoreManagerChat.getAllMatchDocumentsCurrentUser()
            }.map { matchDocs in
                self.matchDoc = matchDocs
            }.then {
                when(fulfilled: self.matchDoc.compactMap(self.getAllMatchInformation)).done { result in
                    self.matches = result
                }.done{
                    self.matches = self.matches.sorted{
                        $0.event.distance < $1.event.distance

                    }
                }
            }.catch { error in
                print("DEBUG: error in getMatchesChain error: \(error)")
            }
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
    
    
    
    func deleteMatchAndEventCompletely(match: AllMatchInformationModel) {
        firstly {
            when(fulfilled:
                 self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: match.chatId, matchedUserId: match.user.userId),
                 self.firestoreManagerMatches.deleteChat(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteEvent(eventId: match.event.eventId))

        }.catch { error in
            print("DEGUB: error in deleteMatch complete, error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
        
    }
    
    func deleteMatchAndBackToPool(match: AllMatchInformationModel) {
        firstly {
            when(fulfilled:
            self.firestoreManagerMatches.deleteMatchFromCurrentUser(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteMatchFromMatchedUser(chatId: match.chatId, matchedUserId: match.user.userId),
                 self.firestoreManagerMatches.deleteChat(chatId: match.chatId),
                 self.firestoreManagerMatches.deleteAllLikedUserFromEvent(eventId: match.event.eventId),
                 self.firestoreManagerEventTest.createLikedUserArray(eventId: match.event.eventId),
                 self.firestoreManagerMatches.setLikedUserAndMatchedUserToFalse(eventId: match.event.eventId))

        }.catch { error in
            print("DEGUB: error in deleteMatch complete, error: \(error)")
            print("DEGUB: error localized: \(error.localizedDescription)")
        }
    }


}


