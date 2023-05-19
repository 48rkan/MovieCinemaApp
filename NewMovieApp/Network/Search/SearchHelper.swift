//
//  SearchHelper.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 25.04.23.
//

import Foundation

public enum SearchEndPoint: String {
    case movie = "/search/movie"
    
    public func path() -> String { return CoreHelper.shared.url(path: self.rawValue) }
}
