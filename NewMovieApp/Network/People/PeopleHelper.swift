//
//  PeopleHelper.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 22.04.23.
//

import Foundation

public enum PeopleEndPoint: String {
    case popular = "/person/popular"
    
    public func path() -> String { return CoreHelper.shared.url(path: self.rawValue) }
}
