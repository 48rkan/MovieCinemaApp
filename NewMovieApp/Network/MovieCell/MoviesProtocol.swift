//
//  MoviesProtocol.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 27.04.23.
//

import Foundation

protocol MovieCellManagerProtocol {
    static func fetchAllGenres(completion: @escaping (AllGenres?,Error?)->())
}
