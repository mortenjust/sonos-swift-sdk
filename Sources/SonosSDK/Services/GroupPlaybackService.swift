//
//  File.swift
//
//
//  Created by James Hickman on 2/17/21.
//

import Foundation
import SwiftyJSON
import SonosNetworking

public enum SonosError : Error {
    case verbatim(String)
    case noData
    case noToken
}

struct GroupPlaybackService {
    
    /// https://developer.sonos.com/reference/control-api/playback/play/
    func playGroup(authenticationToken: AuthenticationToken, groupId: String) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            
            PlaybackPlayNetwork(accessToken: authenticationToken.access_token, groupId: groupId) { _ in
                continuation.resume()
                
            } failure: { err in
                continuation.resume(throwing: err ?? SonosError.verbatim("playgroupother"))
            }
            .performRequest()
        })
    }
    
    /// Pauses the group with the given ID
    /// https://developer.sonos.com/reference/control-api/playback/pause/
    func pauseGroup(authenticationToken: AuthenticationToken, groupId: String) async throws {
        
       try await withCheckedThrowingContinuation { continuation in
            PlaybackPauseNetwork(accessToken: authenticationToken.access_token, groupId: groupId) { data in
                
                if let data, let datastr = String(data: data, encoding: .utf8) {
                    print("pause", datastr)
                }
                continuation.resume()
                return
            } failure: { err in
                continuation.resume(throwing: err ?? SonosError.verbatim("pause: other"))
                return
            }.performRequest()
        }
    }
            
    func getGroupPlaybackStatus(authenticationToken: AuthenticationToken, groupId: String, success: @escaping (PlaybackStatus) -> (), failure: @escaping (Error?) -> ()) {
        
        PlaybackGetStatusNetwork(accessToken: authenticationToken.access_token, groupId: groupId) { data in
            guard let data = data,
                  let playbackStatus = PlaybackStatus(data) else {
                let error = NSError.errorWithMessage(message: "Could not create PlaybackStatus object.")
                failure(error)
                return
            }
            success(playbackStatus)
        } failure: { error in
            failure(error)
        }.performRequest()
    }

}
