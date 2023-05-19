//
//  AuthService.swift
//  NewMovieApp
//  Created by Erkan Emir on 10.05.23.

import Foundation
import Alamofire

// MARK: - RequestTokenStruct
struct RequestTokenStruct: Codable {
    let success: Bool?
    let expiresAt, requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

// MARK: - SessionStruct
struct SessionStruct: Codable {
    let success: Bool?
    let sessionID: String?

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}

// MARK: - Account
struct Account: Codable {
    var avatar: Avatar?
    var id: Int?
    var iso639_1, iso3166_1, name: String?
    var includeAdult: Bool?
    var username: String?

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar?
    let tmdb: Tmdb?
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String?
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatarPath: JSONNull?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


//"Aslanaslan44",
//"password":"aslan444"
class AuthService {
        
    static func allLoginProcess(username: String , password: String, completion: @escaping (Account?,Error?)->()) {
//        var item: RequestTokenStruct?

        CoreService.request(type: RequestTokenStruct.self,
                            url: CoreHelper.shared.url(path: "/authentication/token/new")) { items, error in
            
            guard let token = items?.requestToken else { return }

            let parameters = ["username":username,
                              "password":password,
                              "request_token":token]
            
            CoreService.request(type: RequestTokenStruct.self,
                                url: CoreHelper.shared.url(path: "/authentication/token/validate_with_login"),
                                method: .post,
                                parameters: parameters,
                                encoding: JSONEncoding.default) { items, error in
                
                let parameters = ["request_token":token]
                
                CoreService.request(type: SessionStruct.self,
                                    url: CoreHelper.shared.url(path: "/authentication/session/new"),
                                    method: .post,
                                    parameters: parameters,
                                    encoding: JSONEncoding.default) { items, error in
                    
                    guard let sessionID = items?.sessionID else { return }
                    guard let isSuccess = items?.success else { return }
                    print(sessionID)
                    CoreService.request(type: Account.self,
                                        url: CoreHelper.shared.url(path: "/account") + "&session_id=\(sessionID)") { items, error in
                        print(items)
                        completion(items,error)
                      
                    }
                }
                
            }
        }
    }
}
