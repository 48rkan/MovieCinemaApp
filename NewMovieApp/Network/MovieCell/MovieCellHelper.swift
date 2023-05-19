//
//  MovieHelper.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 27.04.23.
//

import Foundation

public enum MovieEndPoint: String {
    case allGenres = "/genre/movie/list"

    public func path() -> String { return CoreHelper.shared.url(path: self.rawValue) }
}
