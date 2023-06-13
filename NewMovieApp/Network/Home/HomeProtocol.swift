//
//  HomeManagerProtocol.swift
//  NewMovieApp
//  Created by Erkan Emir on 27.04.23.

import Foundation

protocol HomeManagerProtocol {
    static func getMovies(category: CategoryType, pageIndex: Int,langCode: String, completion: @escaping (Movie?,Error?)->())
}
