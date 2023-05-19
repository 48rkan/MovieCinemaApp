//
//  SearchController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 25.04.23.
//

import UIKit



class SearchController: UIViewController {
    
    //MARK:- Properties
    
    private var viewModel = SearchViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(MoviesCell.self, forCellWithReuseIdentifier: "\(MoviesCell.self)")
        
        return collectionView
    }()
    
    private lazy var customView: SearchView = {
        let customView = SearchView()
        customView.delegate = self
//        customView.resignButton.addTarget(self, action: #selector(hiddenResignButton), for: .touchUpInside)
        
        return customView
    }()

            
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCustomizeNavigationController()
        
        viewModel.successCallBack = { self.collectionView.reloadData() }
    }
    
    //MARK:- Actions
            
    private func configureCustomizeNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Search"
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(customView)
        customView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 8,paddingLeft: 8,paddingRight: 8)
        customView.setHeight(48)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: customView.bottomAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
}

//MARK:- UICollectionViewDelegate

extension SearchController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}

//MARK:- UICollectionViewDataSource

extension SearchController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.items.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MoviesCell.self)", for: indexPath) as! MoviesCell
        cell.viewModel = MoviesCellViewModel(items: viewModel.items[indexPath.row])
        return cell
    }    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: view.frame.width, height: 150) }
}

//MARK:- SearchViewDelegate

extension SearchController: SearchViewDelegate {
   
    func searchIconClicked(_ view: SearchView) { view.textField.becomeFirstResponder() }
    
    func view(_ view: SearchView, editingChangedTextField text: String) {
        viewModel.reset()
        viewModel.text = text
        
        viewModel.getMoviesForSearch()
    }
}
