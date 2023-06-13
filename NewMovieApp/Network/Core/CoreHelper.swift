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
    
    let header: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YmMzZmZmZjQ1MTNmODBmZjI5ZDQ1NTYyMzNlMWZiOCIsInN1YiI6IjYzYTk4ZjEzZTRiNTc2MDBiYTBjYjI3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LZL9jJKMVAUP6QfRuww00rEwxtKsy9zsLZ4Bv8q4aMo"
    ]
    
    public func url(path: String) -> String {
        return BASE_URL + path + "?api_key=\(API_KEY)"
    }
    
    public func imagePath(path: String) -> String {
        return "https://image.tmdb.org/t/p/original/" + path
    }
    

}
