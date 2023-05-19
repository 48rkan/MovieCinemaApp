//
//  MovieCellViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 09.04.23.
//

import Foundation

struct HomeCellViewModel {

    var items:  Category
    
    init(items: Category) { self.items = items }
    
    var title: String     { items.title  }
    
    var movies: [Result]  { items.movies }
}
