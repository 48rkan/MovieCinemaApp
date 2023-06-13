//
//  CKeychain.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 12.06.23.

import Foundation
import KeychainSwift

class Keychain {
    static var shared = KeychainSwift()
}

class Token {
    static let shared = Token()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YmMzZmZmZjQ1MTNmODBmZjI5ZDQ1NTYyMzNlMWZiOCIsInN1YiI6IjYzYTk4ZjEzZTRiNTc2MDBiYTBjYjI3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LZL9jJKMVAUP6QfRuww00rEwxtKsy9zsLZ4Bv8q4aMo"
    
    func configure() {
        Keychain.shared.set(accessToken, forKey: "ACCESS_TOKEN")
    }
    
//    init() {
//        Keychain.shared.set(accessToken, forKey: "ACCESS_TOKEN")
//    }
    
}
