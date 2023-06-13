//
//  SessionStruct.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 11.06.23.
//

import Foundation

// MARK: - SessionStruct
struct SessionStruct: Codable {
    let success: Bool?
    let sessionID: String?

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
