//
//  File.swift
//  
//
//  Created by James Hickman on 3/11/21.
//

import Foundation

extension SonosManager {
     
    public func pauseGroup(groupId: String) async throws {
        guard let authenticationToken else { throw SonosError.noToken }
        try await groupPlaybackService.pauseGroup(
            authenticationToken: authenticationToken,
            groupId: groupId)
    }
    
    public func playGroup(groupId: String) async throws {
        guard let authenticationToken else { throw SonosError.noToken }
        
        try await groupPlaybackService.playGroup(authenticationToken: authenticationToken, groupId: groupId)
    }
    
    // TODO async
    public func getGroupPlaybackStatus(groupId: String, success: @escaping (PlaybackStatus) -> Void, failure: @escaping (Error?) -> Void) {
        
        
        guard let authenticationToken = authenticationToken else {
            let error = NSError.errorWithMessage(message: "Could not load authentication token.")
            failure(error)
            return
        }

        groupPlaybackService.getGroupPlaybackStatus(authenticationToken: authenticationToken, groupId: groupId, success: { playbackStatus in
            success(playbackStatus)
        }, failure: failure)
    }

}
