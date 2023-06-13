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
        configureUI()
        configureTabBar()
    }
    
    private func configureUI() {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: "SUCCESS_LOGIN") == false {
                let controller = LoginController()
                controller.delegate = self
                
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
            }
        }
    }
    
    private func configureTabBar() {
        self.delegate = self
        
        let home = templateViewControllers(controller: HomeController(),
                                           selectedImage: UIImage(named: "home")!,
                                           unselectedImage: UIImage(named: "home")!)
        
        let people = templateViewControllers(controller: PeopleController(),
                                             selectedImage: UIImage(named: "Profile")!,
                                             unselectedImage: UIImage(named: "Profile")!)
        
        let search = templateViewControllers(controller: SearchController(),
                                             selectedImage: UIImage(named: "search-normal")!,
                                             unselectedImage: UIImage(named: "search-normal")!)
        
        let account = templateViewControllers(controller: AccountController(),
                                              selectedImage: UIImage(named: "search-normal")! ,
                                              unselectedImage: UIImage(named: "search-normal")!)
         
        viewControllers = [ home , search , people , account ]
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

extension TabBarController: LoginControllerDelegate {
    func authCompleted(id: String) {
        guard let nav = viewControllers?[3] as? UINavigationController else { return }
        guard let account = nav.viewControllers.first as? AccountController else { return }
    
        account.viewModel.fetchAllProcess(id: id)
//        account.viewModel.fetchProfileData(sessionID: id)
//        account.viewModel.fetchFavourited(id: id)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let controllerIndex = viewControllers?.firstIndex(of: viewController)
        
        if controllerIndex == 3 {
            if UserDefaults.standard.bool(forKey: "SUCCESS_LOGIN") == false {
                showMessage(withTitle: "You must login..", message: "You must login")
            }
        }
        
        return true
    }
}
