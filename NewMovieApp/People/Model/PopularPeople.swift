//
//  PopularPeople.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 18.04.23.
//

import Foundation

// MARK: - PopularPerson
struct PopularPerson: Codable {
    let page: Int?
    let results: [PeopleResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PeopleResult: Codable,TopImageBottomLabelCellProtocol {
    
    let adult: Bool?
    let gender, id: Int?
    let knownFor: [KnownFor]?
    let knownForDepartment: String?
    let name: String?
    let popularity: Double?
    let profilePath: String?
    
    var imageURL: String { profilePath ?? ""}
    
    var titleText: String { name ?? ""}

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: String?
    let name: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName, overview, posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video
    }
}
