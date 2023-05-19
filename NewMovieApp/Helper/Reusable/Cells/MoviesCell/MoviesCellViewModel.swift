//
//  MoviesCellViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 20.04.23.
//

import Foundation

class MoviesCellViewModel {
    
    //MARK:- Properties
    
    var items: MoviesCellProtocol
        
    init(items: MoviesCellProtocol) { self.items = items }
    
    var title: String { items.title_ }
    
    var imageURL: URL? { URL(string: CoreHelper.shared.imagePath(path: items.imageUrl_ ))}
        
    var imdbPoint: String { "\(String(format: "%.1f", items.imdbPoint_ ))/10 IMDb" }
    
    var selectedMovieGenres: [Int] { items.genres_ }
        
    var genreList : [String] { GenreClass.shared.getGenre(genres: selectedMovieGenres)}
    

}
