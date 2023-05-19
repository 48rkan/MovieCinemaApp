//
//  SearchViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 25.04.23.
//

import Foundation

class SearchViewModel {
    
    public var items = [Result]()
    private var movie: Movie?
    public var text = ""
    internal var successCallBack: (()->())?
    
    public func getMoviesForSearch() {
        SearchService.getMoviesForSearch(pageIndex: (movie?.page ?? 0) + 1, searchText: text) { movie, error in
            if error != nil { return }
        
            self.movie = movie
            
            guard let movieResult = movie?.results else { return }

            self.items.append(contentsOf: movieResult)
            self.successCallBack?()
        }
    }
    
    public func reset() {
        items.removeAll()
        movie = nil
    }
    
    public func pagination(index: Int) {
        guard let movie = movie else { return }
        if index == self.items.count - 1 && movie.page ?? 0 <= movie.totalPages ?? 0 {
            getMoviesForSearch()
        }
    }
}
