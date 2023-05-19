//
//  PeopleMoviesController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 20.04.23.
//

import UIKit

class PeopleMoviesController: UIViewController {
    
    public var viewModel = PeopleMoviesViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(MoviesCell.self, forCellWithReuseIdentifier: "\(MoviesCell.self)")
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        customNavigationBar()
        
        viewModel.fetchPersonMovie { self.collectionView.reloadData() }
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
    
    private func customNavigationBar() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Actor's Movies"
    }
}

extension PeopleMoviesController: UICollectionViewDelegate { }

extension PeopleMoviesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.items.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MoviesCell.self)", for: indexPath) as! MoviesCell
        cell.viewModel = MoviesCellViewModel(items: viewModel.items[indexPath.row])
        
        return cell
    }
}

extension PeopleMoviesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = dynamicHeightCalculator(text: viewModel.items[indexPath.row].overview ?? "", width: view.frame.width) + 64
        
        return CGSize(width: view.frame.width, height: 150)
    }
}
