//
//  PeopleCoordinator.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 08.05.23.
//

import UIKit

class PeopleCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showPeopleMovies(personID: Int) {
        let controller = PeopleMoviesController()
        controller.viewModel.personId = personID

        navigationController.show(controller, sender: nil)
    }
}
