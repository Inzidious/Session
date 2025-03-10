//
//  GlobalUser.swift
//  SessionApp
//
//  Created by macOS on 2/19/25.
//


//
//  StaticUser.swift
//  SessionApp
//
//  Created by Shawn McLean on 2/18/25.
//

import Foundation
import SwiftData

class GlobalUser {
    static let shared = GlobalUser()
    var user:User

    public func setContext(context:ModelContext)
    {
        context.insert(self.user)
    }
    
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
