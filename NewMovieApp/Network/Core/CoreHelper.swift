//
//  CoreHelper.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 21.04.23.
//

import Foundation
import Alamofire

public class CoreHelper {
    static let shared = CoreHelper()
    
    private let BASE_URL = "https://api.themoviedb.org/3"
    private let API_KEY  = "5bc3ffff4513f80ff29d4556233e1fb8"
    
//    private lazy var token = Keychain.shared.get("ACCESS_TOKEN")
//
//    let header: HTTPHeaders = [
//        "Authorization": token
//    ]
    
    lazy var header: HTTPHeaders = {
        let token = Keychain.shared.get("ACCESS_TOKEN")
        
        return [
            "Authorization": (token ?? "")
        ]
    }()
    
    public func url(path: String) -> String {
        return BASE_URL + path + "?api_key=\(API_KEY)"
    }
    
    public func imagePath(path: String) -> String {
        return "https://image.tmdb.org/t/p/original/" + path
    }
    

}
