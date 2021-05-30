//
//  AuthService.swift
//  uChat
//
//  Created by agileassociates on 4/28/21.
//

import Firebase
import UIKit

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
                Auth.auth().signIn(withEmail: email, password: password, completion: completion)
                    
                
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                completion!(error)
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["email": credentials.email,
                                "fullname": credentials.fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username,
                                "filename": filename] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
    
    func setPhoto(photo: UIImage, completion: ((Error?)-> Void)?) {
        guard let imageData = photo.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                completion!(error)
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                let user = Auth.auth().currentUser
                guard let uid = user?.uid else { return }
                
                Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": profileImageUrl, "filename": filename])
                
            }
        }
    }
    
    func deletePhoto() {
        var filename: Any?
        let user = Auth.auth().currentUser
        guard let uid = user?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument{(document, error) in
            if let document = document, document.exists {
                     filename = document.get("filename")
                 let unwrappedFilename = filename!
                let ref = Storage.storage().reference(withPath: "/profile_images/\(unwrappedFilename)")
                print("\n\n\n The  unwrapped filename is:  \(unwrappedFilename)")
                
                // Delete the file
                ref.delete { error in
                  if let error = error {
                    // Uh-oh, an error occurred!
                    print("\n\n\nDEBUG: error is .....\(error.localizedDescription)")
                  } else {
                    print("\n\n\nDEBUG:  \(unwrappedFilename) File deleted successfully")
                  }
                }
                } else {
                    print("Document does not exist")
                }
        }
    }
    
    
}
