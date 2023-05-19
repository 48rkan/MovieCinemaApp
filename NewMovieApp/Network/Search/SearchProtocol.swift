//
//  SearchProtocol.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 27.04.23.
//

import Foundation

protocol SearchManagerProtocol {
    static func getMoviesForSearch(pageIndex: Int,searchText: String,completion: @escaping (Movie?,Error?)->())
}
