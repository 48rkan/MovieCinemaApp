//
//  AllMoviesController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 02.05.23.
//

import UIKit

class AllMoviesController: UIViewController {
    
    var viewModel: AllMoviesViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK:- Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.register(TopImageBottomLabelCell.self, forCellWithReuseIdentifier: "\(TopImageBottomLabelCell.self)")
        c.showsVerticalScrollIndicator   = false
        c.showsHorizontalScrollIndicator = false
        c.delegate   = self
        c.dataSource = self
        

        return c
    }()

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel?.successCallBack = { self.collectionView.reloadData() }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = viewModel?.categoryTitle

        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0,paddingLeft: 0,
                              paddingBottom: 0,paddingRight: 0)
    }
}

//MARK:- UICollectionViewDelegate

extension AllMoviesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.pagination(index: indexPath.row)
    }
}

//MARK:- UICollectionViewDataSource

extension AllMoviesController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.items.count  ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TopImageBottomLabelCell.self)", for: indexPath) as! TopImageBottomLabelCell
        cell.viewModel = TopImageBottomLabelCellViewModel(items: viewModel.items[indexPath.row])

        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension AllMoviesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 188, height: 290)
    }
}
