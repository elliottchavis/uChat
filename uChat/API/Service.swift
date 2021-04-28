//
//  Service.swift
//  uChat
//
//  Created by agileassociates on 4/28/21.
//

import Firebase

struct Service {
    static func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                print(document.data())
            })
        }
    }
}
