//
//  MovieCellViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 09.04.23.
//

import Foundation
import Alamofire

// MARK: - FavouriteSuccess
struct FavouriteSuccess: Codable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

import Foundation

struct HomeCellViewModel {

    var items:  Category
    
    init(items: Category) { self.items = items }
    
    var title: String     { items.title  }
    
    var movies: [Result]  { items.movies }
    
 
    
    func favouriteClicked(movieID: Int) {
//        let id = UserDefaults.standard.integer(forKey: "USERR_ID")
        guard let id = Keychain.shared.get("ID_USER") else { return }
        
        let url = "https://api.themoviedb.org/3/account/\(id)/favorite"
        
        let parameter: Parameters = ["media_type": "movie",
                                     "media_id": movieID,
                                     "favorite": true
        ]
                
        CoreService.request(type: FavouriteSuccess.self,
                            url: url,
                            method: .post,
                            parameters: parameter,
                            encoding: JSONEncoding.default
        ) { items, error in
            if error != nil {
                return
            }
            
            guard let items = items else { return }
            
            print(items)
        }
    }
}
