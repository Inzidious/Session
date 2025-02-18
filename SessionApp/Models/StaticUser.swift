//
//  StaticUser.swift
//  SessionApp
//
//  Created by Shawn McLean on 2/18/25.
//

import Foundation

class GlobalUser {
    static let shared = GlobalUser()
    var user:User

    private init() {
        let defaultUser = User(
            id:"empty",
            email: "no@no.com",
            firstName: "Default",
            lastName: "User",
            authProvider: "empty"
           
        )
        
        user = defaultUser
    }
}
