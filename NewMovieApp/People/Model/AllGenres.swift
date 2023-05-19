//
//  AllGenres.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 25.04.23.
//

import Foundation

import Foundation

// MARK: - AllGenres
struct AllGenres: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable,Hashable {
    let id: Int?
    let name: String?
}
