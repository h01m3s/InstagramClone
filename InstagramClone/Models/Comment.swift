//
//  Comment.swift
//  InstagramClone
//
//  Created by Weijie Lin on 3/21/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
