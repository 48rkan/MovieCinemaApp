//  PeopleControllerViewModel.swift
//  NewMovieApp
//  Created by Erkan Emir on 18.04.23.

import Foundation

class PeopleViewModel {
    
    public var items = [PeopleResult]()
    private var movie: PopularPerson?
    public var successCallBack: (()->())?
    public var coordinator: PeopleCoordinator?
    
    public func fetchPopularPeople() {
        PeopleService.fetchPopularPeople(pageIndex: (movie?.page ?? 0) + 1) { items, error in
            if error != nil { return }
            
            self.movie = items
            
            guard let items = items?.results else { return }
            
            self.items.append(contentsOf: items)
            self.successCallBack?()
        }
    }
    
    public func pagination(index: Int) {
        guard let movie = movie else { return }
        
        if index == self.items.count - 1 && movie.page ?? 0 <= movie.totalPages ?? 0  {
            fetchPopularPeople()
        }
    }
}
