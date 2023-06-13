//
//  HomeManager.swift
//  NewMovieApp
//  Created by Erkan Emir on 08.04.23.

import Foundation

public class HomeService: HomeManagerProtocol {
    
    static func getMovies(category: CategoryType, pageIndex: Int,langCode: String, completion: @escaping (Movie?,Error?)->()) {
        
        var url = ""
        
        switch category {
        case .popular:
            url = HomeEndPoint.popular.path()
        case .topRated:
            url = HomeEndPoint.topRated.path()
        case .upComing:
            url = HomeEndPoint.upComing.path()
        case .nowPLaying:
            url = HomeEndPoint.nowPLaying.path()
        }
        
        CoreService.request(type: Movie.self, url: url + "&page=\(pageIndex)" + "&language=\(langCode)") { items, error in
            completion(items,error)
        }
    }
}


