//
//  RequestTokenStruct.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 11.06.23.

import Foundation

struct RequestTokenStruct: Codable {
    let success: Bool?
    let expiresAt, requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
