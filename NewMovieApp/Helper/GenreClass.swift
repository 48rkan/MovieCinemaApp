//
//  GenreClass.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 26.04.23.
//

import Foundation

class GenreClass {
    
    static let shared = GenreClass()
    var allGenres = [Genre]()

    public func fetchAllGenre() {
        MovieCellManager.fetchAllGenres { genres, error in
            if error != nil { return }

            guard let genres = genres?.genres else { return }

            self.allGenres = genres
        }
    }
    
    public func getGenre(genres: [Int]) -> [String] {
        var dictionary = [Int:String]()
        
        self.allGenres.forEach({ dictionary[$0.id!] = $0.name})
        
        let dict = dictionary.filter({ return genres.contains($0.key)})
        
        let array = dict.map({ $0.value})
        
        return array
    }
}


//    var allGenres = [Genre]()
//
//    var genreList =  [String]()
    
//    func fetchAllGenre(completion: @escaping ()->()) {
//        print("--------")
//        MovieCellManager.fetchAllGenres { genres, error in
//            if error != nil { return }
//
//            guard let genres = genres?.genres else { return }
//
//            self.allGenres = genres
//
//            //1.Create empty dictionary
//            var dictionary = [Int:String]()
//
//            self.allGenres.forEach({ dictionary[$0.id!] = $0.name})
//
//            let dict = dictionary.filter({ return self.selectedMovieGenres.contains($0.key)})
//
//            let array = dict.map({ $0.value})
//
//            self.genreList = array
//
//            completion()
//        }
//    }
    
//    func matchGenres()  {
//        //1.Create empty dictionary
//        var dictionary = [Int:String]()
//
//        allGenres.forEach({ dictionary[$0.id!] = $0.name})
//
//        let dict = dictionary.filter({ return self.selectedMovieGenres.contains($0.key)})
//
//        self.genreTitles = dict.map({ $0.value})
////        return dictionary.map({ $0.value})
//    }
