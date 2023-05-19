//
//  AllMoviesViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 02.05.23.
//

import Foundation

class AllMoviesViewModel {
    
    public var items: [Result]
    public var categoryTitle: String = ""
    private var movies: Movie?
    internal var successCallBack: (()->())?
    
    init(items: [Result]) {
        self.items = items

    }
    
    public func getMovies(type: CategoryType,langCode: String) {
        HomeService.getMovies(category: type, pageIndex: (movies?.page ?? 1) + 1, langCode: langCode) { items, error in
            if error != nil { return }
            self.movies = items
            
            guard let items = items?.results else { return }
            
            self.items.append(contentsOf: items)
            
            self.successCallBack?()
        }
    }
    
    public func pagination(index: Int) {
        if index == self.items.count - 1 {
            getMovies(type: CategoryType(rawValue: categoryTitle)!, langCode: "en-US")
        }
    }
}
