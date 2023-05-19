//
//  TabBarController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 08.04.23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let home = templateViewControllers(controller: HomeController(), selectedImage: UIImage(named: "home")!, unselectedImage: UIImage(named: "home")!)
        
        let people = templateViewControllers(controller: PeopleController(), selectedImage: UIImage(named: "Profile")!, unselectedImage: UIImage(named: "Profile")!)
        
        let search = templateViewControllers(controller: SearchController(), selectedImage: UIImage(named: "search-normal")!, unselectedImage: UIImage(named: "search-normal")!)
        
        let empty = templateViewControllers(controller: DefaultController(), selectedImage: UIImage(named: "search-normal")! , unselectedImage: UIImage(named: "search-normal")!)
         
        viewControllers = [ home , search , people , empty ]
    }
    
    private func templateViewControllers(controller: UIViewController,selectedImage: UIImage,unselectedImage: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.prefersLargeTitles = true

        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        
        nav.navigationBar.tintColor = UIColor(hexString: "222F3D")
        tabBar.tintColor = UIColor(hexString: "222F3D")
        
        return nav
    }
}
