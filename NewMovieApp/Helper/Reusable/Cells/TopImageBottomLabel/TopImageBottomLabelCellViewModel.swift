//
//  MovieCellViewModel.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 09.04.23.
//

import Foundation

class TopImageBottomLabelCellViewModel {
    
    let items: TopImageBottomLabelCellProtocol
    
    var isFavourited: Bool {
        FavouritedClass.shared.favouritedDatas.contains(where: { $0.movieID == items.movieID })
    }
    
    init(items: TopImageBottomLabelCellProtocol) { self.items = items }
    
    var imageURL: URL? { URL(string: CoreHelper.shared.imagePath(path: items.imageURL))}
    
    var title: String { items.titleText}
    

}
