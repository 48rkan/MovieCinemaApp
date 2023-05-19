//
//  CustomCollectionView.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 02.05.23.
//

import UIKit

class CustomCollectionView: UICollectionView {
    
    let layout = UICollectionViewFlowLayout()
    
    init(scroll: UICollectionView.ScrollDirection,spacing: CGFloat) {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = scroll
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        configureCollectionView()
    }
        
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureCollectionView() {
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
}


//private lazy var collectionView: UICollectionView = {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .vertical
//    layout.minimumLineSpacing = 4
//    layout.minimumInteritemSpacing = 4
////        layout.sectionInset.top = 30
////        layout.sectionInset.right = 140
//
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    collectionView.delegate   = self
//    collectionView.dataSource = self
//
//    collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "\(HomeCell.self)")

//}()
