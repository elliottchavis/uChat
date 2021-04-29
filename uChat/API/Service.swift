//
//  Service.swift
//  uChat
//
//  Created by agileassociates on 4/28/21.
//

import Firebase

struct Service {
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                print(document.data())
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
                
                print("\n\n\n\n\n\n You're in the Service File___________")
                print("\nThe current user info:")
                print("DEBUG: Username is \(user.username)")
                print("DEBUG: Fullname is \(user.fullname)")
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    let data = ["text": message,
                "fromId": currentUid,
                "toId": user.uid,
                "timestamp": Timestamp(date: Date())] as [String: Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        }
                
    }
}
