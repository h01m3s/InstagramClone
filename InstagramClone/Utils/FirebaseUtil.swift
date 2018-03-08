//
//  FirebaseUtil.swift
//  InstagramClone
//
//  Created by Weijie Lin on 3/7/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    
    static func fetchUserWithUID(uid: String, completeion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictioanry = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: userDictioanry)
            
            print(user.username)
            
            completeion(user)
        }) { (err) in
            print("Failed to fetch user for posts: ", err)
        }
    }
    
}
