//
//  PeopleMoviesControllerViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 20.04.23.
//

import UIKit

class PeopleMoviesViewModel {
    
    public var personId: Int?
    
    public var items = [Cast]()
    
    public func fetchPersonMovie(completion: @escaping ()->()) {
        PeopleService.fetchPersonMovie(personId: personId ?? 0 ) { items, error in
            if error != nil { return print("\(error?.localizedDescription)") }
        
            guard let items = items?.cast else { return }
            self.items = items
            completion()
            
        }
    }
}
