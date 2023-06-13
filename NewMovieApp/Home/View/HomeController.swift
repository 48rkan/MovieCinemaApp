//
//  HomeController.swift
//  NewMovieApp
//  Created by Erkan Emir on 08.04.23.

import UIKit

class HomeController: UIViewController {
        
    var coordinator: HomeCoordinator?
    
    public var viewModel = HomeViewModel()
    
    private lazy var collectionView: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.register(HomeCell.self, forCellWithReuseIdentifier: "\(HomeCell.self)")
        c.delegate = self
        c.dataSource = self
        
        return c
    }()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBarButtonItems()
                
        guard let nav = navigationController else { return }
        coordinator = HomeCoordinator(navigationController: nav)
        
        viewModel.successCallBack = {
            self.collectionView.reloadData()
//            self.collectionView.scrollToItem(at: IndexPath(item: self.viewModel.category.count - 1, section: 0), at: .centeredVertically, animated: true)
        }
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.title = "home_title".localize
        collectionView.reloadData()
    }
    
    private func configureBarButtonItems() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-normal"), style: .done, target: self, action: #selector(tappedSearch))
//        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
//        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func tappedSearch() {
        let controller = SearchController()
        navigationController?.show(controller, sender: nil)
    }
    

        
    private func configureUI() {
        view.backgroundColor = .white
        
        let leftButton = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(tappedLogOut))
        navigationItem.leftBarButtonItem = leftButton

        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0, paddingLeft: 24,
                              paddingBottom: 0,paddingRight: 0)
    }
    
    @objc func tappedLogOut() {
        UserDefaults.standard.set(false, forKey: "SUCCESS_LOGIN")

        let controller = LoginController()
        controller.delegate = tabBarController as? TabBarController
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: false)
    }
}

extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.category.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeCell.self)", for: indexPath) as! HomeCell
        cell.delegate = self
        cell.viewModel = HomeCellViewModel(items: viewModel.category[indexPath.item])
        
        return cell
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: view.frame.width , height: 318) }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(viewModel.category[0].movies[indexPath.row].id)
    }
}

extension HomeController: HomeCellDelegate {
    func cell(_ cell: HomeCell, wantsToAllMovies movies: Category) {
        coordinator?.showAllMovies(movies: movies)
//        let controller = AllMoviesController()
//        controller.viewModel = AllMoviesViewModel(items: movies.movies)
//        controller.viewModel?.categoryTitle = movies.title
//        navigationController?.show(controller, sender: nil)
    }
}
