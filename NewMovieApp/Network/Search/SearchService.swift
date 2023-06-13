//
//  SearchManager.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 25.04.23.

import Foundation

public class SearchService: SearchManagerProtocol {
    
    static func getMoviesForSearch(pageIndex: Int,searchText: String, completion: @escaping (Movie?,Error?)->()) {
        CoreService.request(type: Movie.self,
                            url: SearchEndPoint.movie.path() + "&page=\(pageIndex)" + "&query=\(searchText)" ) { items, error in
            completion(items,error)
        }
    }
}
