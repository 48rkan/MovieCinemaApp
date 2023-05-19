//
//  HomeCoordinator.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 09.05.23.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showAllMovies(movies: Category) {
        let controller = AllMoviesController()
        controller.viewModel = AllMoviesViewModel(items: movies.movies)
        controller.viewModel?.categoryTitle = movies.title
        
        navigationController.show(controller, sender: nil)
    }
}
