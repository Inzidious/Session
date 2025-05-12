//
//  ChatView.swift
//  SessionApp
//
//  Created by Shawn McLean on 5/9/25.
//

import SwiftUI
import SendbirdChatSDK
import SendbirdSwiftUI

func InitUser()
{
    SBUGlobals.currentUser = SBUUser(userId:"Ahmed")
}

func InitializeChat()
{
    let APP_ID = "8B39E2D5-6449-494D-A088-4E024CEED0C5"    // Specify your Sendbird application ID.
            
            SendbirdUI.initialize(
                applicationId: APP_ID
            ) { params in
                // This is the builder block where you can modify the initParameter.
                //
                // [example]
                // params.needsSynchronous = false
            } startHandler: {
                // This is the origin.
                // Initialization of SendbirdSwiftUI has started.
                // We recommend showing a loading indicator once started.
            } migrationHandler: {
                // DB migration has started.
            } completionHandler: { error in
                // If DB migration is successful, proceed to the next step.
                // If DB migration fails, an error exists.
                // We recommend hiding the loading indicator once done.
            }
    
    InitUser()
}

#Preview {
    var _ = InitializeChat()
    OpenChannelListView()
}

