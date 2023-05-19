//
//  MovieCellManager.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 25.04.23.
//

import Foundation

public class MovieCellManager { }

extension MovieCellManager: MovieCellManagerProtocol {
    static func fetchAllGenres(completion: @escaping (AllGenres?,Error?)->()) {
        CoreService.request(type: AllGenres.self, url: MovieEndPoint.allGenres.path()) { items, error in
            completion(items,error)
        }
    }
}


