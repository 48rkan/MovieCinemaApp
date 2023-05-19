//
//  PeopleManager.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 18.04.23.
//

import Foundation


public class PeopleService: PeopleManagerProtocol {
    
    static func fetchPopularPeople(pageIndex: Int,completion: @escaping (PopularPerson?,Error?)->()) {
        
        CoreService.request(type: PopularPerson.self, url: PeopleEndPoint.popular.path() + "&page=\(pageIndex)") { items, error in
            completion(items,error)
        }
    }
    
    static func fetchPersonMovie(personId: Int,completion: @escaping (PersonMovie?,Error?)->()) {
        CoreService.request(type: PersonMovie.self, url: CoreHelper.shared.url(path: "/person/\(personId)/movie_credits")) { items, error in
            completion(items,error)
        }
    }
}
