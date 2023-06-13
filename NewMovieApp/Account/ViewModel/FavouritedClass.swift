//
//  FavouritedClass.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 11.06.23.
//

import Foundation
import Alamofire

class FavouritedClass {
    static let shared = FavouritedClass()
    
    var favouritedDatas = [Result]()
    
    func fetchFavourited() {
        
        guard let id = Keychain.shared.get("ID_USER") else { return }

        let url = "https://api.themoviedb.org/3/account/\(id)/favorite/movies"
    
            CoreService.request(type: Favourited.self,
                                url: url) { items, error in
                if error != nil { return }
                guard let items = items?.results else { return }
                self.favouritedDatas = items
            }
        }
}

