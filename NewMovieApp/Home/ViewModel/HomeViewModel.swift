//
//  HomeViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 08.04.23.
//

import Foundation

struct Category {
    let title: String
    let movies: [Result]
}

class HomeViewModel {
    public var category = [Category]()
    public var successCallBack: (()->())?
    
    var accountData: Account?
    
    public init() {
        getMovies(type: .popular, langCode: "en-US")
        getMovies(type: .upComing, langCode: "en-US")
        getMovies(type: .nowPLaying, langCode: "en-US")
        getMovies(type: .topRated, langCode: "en-US")
    }
    
    public func getMovies(type: CategoryType,langCode: String) {
        HomeService.getMovies(category: type, pageIndex: 1, langCode: langCode) { items, error in
            if error != nil { return }
                    
            guard let items = items?.results else { return }
            self.category.append(Category(title: type.rawValue, movies: items))
            
            self.successCallBack?()
        }
    }
    
//    func getPopularMovies() {
//        HomeManager.getPopularMovies(pageIndex: 1) { items, error in
//            if error != nil { return }
//
//            guard let items = items?.results else { return }
//            self.category.append(Category(title: "Popular", movies: items))
//
//            //            self.popMovies.append(contentsOf: items)
//
//            self.successCallBack?()
//        }
//    }
//
//    func getTopRatedMovies() {
//        HomeManager.getTopRatedMovies(pageIndex: 5) { items, error in
//            if error != nil { return }
//
//            guard let items = items?.results else { return }
//            self.category.append(Category(title: "Top Rated", movies: items))
////            self.topRatedMovies = items
//            self.successCallBack?()
//        }
//    }
//
//    func getNowPlayingMovies() {
//
//        HomeManager.getNowPlayingMovies(pageIndex: 5) { items, error in
//            if error != nil { return }
//
//            guard let items = items?.results else { return }
//
//            self.category.append(Category(title: "Now Playing", movies: items))
//
//            self.successCallBack?()
//        }
//    }
//
//    func getUpComingMovies() {
//        HomeManager.getUpComingMovies(pageIndex: 5) { items, error in
//            if error != nil { return }
//
//            guard let items = items?.results else { return }
//
//            self.category.append(Category(title: "Upcoming", movies: items))
//
//            self.successCallBack?()
//        }
//    }
  
}
