//
//  HomeHelper.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 21.04.23.
//

import Foundation

public enum CategoryType: String {
    case popular    = "Popular"
    case topRated   = "Top Rated"
    case nowPLaying = "Now Playing"
    case upComing   = "Upcoming"
}

public enum HomeEndPoint: String {
    case popular    = "/movie/popular"
    case topRated   = "/movie/top_rated"
    case nowPLaying = "/movie/now_playing"
    case upComing   = "/movie/upcoming"
    
    public func path() -> String { return CoreHelper.shared.url(path: self.rawValue) }
}
