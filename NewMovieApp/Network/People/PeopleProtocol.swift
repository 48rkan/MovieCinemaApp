//
//  PeopleProtocol.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 27.04.23.
//

import Foundation

protocol PeopleManagerProtocol {
    static func fetchPopularPeople(pageIndex: Int,completion: @escaping (PopularPerson?,Error?)->())
    static func fetchPersonMovie(personId: Int,completion: @escaping (PersonMovie?,Error?)->())
}
