//
//  File.swift
//  
//
//  Created by James Hickman on 2/25/21.
//

import Foundation

extension SonosManager {

    public func getFavorites(householdId: String, success: @escaping ([Favorite]) -> Void, failure: @escaping (Error?) -> Void) {
        guard let authenticationToken = authenticationToken else {
            let error = NSError.errorWithMessage(message: "Could not load authentication token.")
            failure(error)
            return
        }

        favoriteService.getFavorites(authenticationToken: authenticationToken, householdId: householdId, success: success, failure: failure)
    }

    
    // Play favorite
    
    func loadFavorite(groupId: String, favoriteId: String, success: @escaping (Error?) -> Void, failure: @escaping (Error?) -> Void) {
        guard let authenticationToken = authenticationToken else {
            let error = NSError.errorWithMessage(message: "Could not load authentication token.")
            failure(error)
            return
        }

        favoriteService.loadFavorite(authenticationToken: authenticationToken, groupId: groupId, favoriteId: favoriteId, success: success, failure: failure)
    }
    
    public func playFavorite(groupId: String, favoriteId: String) async throws {
        return try await withCheckedThrowingContinuation({ continuation in
            loadFavorite(groupId: groupId, favoriteId: favoriteId) { err in
                if let err {
                    continuation.resume(throwing: err)
                }
            } failure: { err in
                if let err {
                    continuation.resume(throwing: err)
                }
            }
            continuation.resume()
            
        })
    }

    public func subscribeToFavorites(forHouseholdId householdId: String, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        guard let authenticationToken = authenticationToken else {
            let error = NSError.errorWithMessage(message: "Could not load authentication token.")
            failure(error)
            return
        }

        favoriteService.subscribe(authenticationToken: authenticationToken, householdId: householdId, success: success, failure: failure)
    }

    public func unsubscribeToFavorites(forHouseholdId householdId: String, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        guard let authenticationToken = authenticationToken else {
            let error = NSError.errorWithMessage(message: "Could not load authentication token.")
            failure(error)
            return
        }

        favoriteService.unsubscribe(authenticationToken: authenticationToken, householdId: householdId, success: success, failure: failure)
    }

}
