//
//  User.swift
//  InstagramClone
//
//  Created by Weijie Lin on 3/7/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = uid
    }
}
