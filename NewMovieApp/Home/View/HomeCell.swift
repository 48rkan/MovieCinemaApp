//
//  HomeCell.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 08.04.23.
//

import UIKit

protocol HomeCellDelegate: AnyObject {
    func cell(_ cell: HomeCell, wantsToAllMovies movies: Category)
}

class HomeCell: UICollectionViewCell {
    
    weak var delegate: HomeCellDelegate?
    
    public var viewModel: HomeCellViewModel? {
        didSet {
            self.collectionView.reloadData()
            titleLabel.text = viewModel?.title.localize
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Light", size: 19.08)
        label.textColor = UIColor(hexString: "2B2C34")

        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "seeAll"), for: .normal)
        button.addTarget(self, action: #selector(tappedSeeAll), for: .touchUpInside)
//        button.setTitle("See all", for: .normal)
//        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection         = .horizontal
        layout.minimumLineSpacing      = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset.right      = 12

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(TopImageBottomLabelCell.self, forCellWithReuseIdentifier: "\(TopImageBottomLabelCell.self)")
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK:- Actions
    
    @objc private func tappedSeeAll() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToAllMovies: viewModel.items)

    }
        
    private func configureUI() {
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,left: leftAnchor,
                          right: rightAnchor,paddingTop: 4,
                          paddingLeft: 18,paddingRight: 8)
        titleLabel.setDimensions(height: 29, width: 74)
        
        addSubview(rightButton)
        rightButton.anchor(top: topAnchor,right: rightAnchor,
                           paddingTop: 4,paddingRight: 11.45)
        rightButton.setDimensions(height: 22.9, width: 61.07)
        
        
        addSubview(collectionView)
        collectionView.anchor(top: titleLabel.bottomAnchor,left: leftAnchor,
                              bottom: bottomAnchor,right: rightAnchor,
                              paddingTop: 4,paddingLeft: 0,
                              paddingBottom: 0,paddingRight: 0)
    }
}

extension HomeCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(viewModel?.items.movies[indexPath.row].id)
    }
}

extension HomeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel?.items.movies.count ?? 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TopImageBottomLabelCell.self)", for: indexPath) as! TopImageBottomLabelCell
        cell.delegate = self
        cell.viewModel = TopImageBottomLabelCellViewModel(items: (viewModel?.items.movies[indexPath.row])! )

        return cell
    }
}

extension HomeCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: 167, height: 290) }
}

extension HomeCell: TopImageBottomLabelCellDelegate {
    func doFavourite(_ cell: TopImageBottomLabelCell, id: Int) {
        print(id)
        viewModel?.favouriteClicked(movieID: id)
        cell.favouriteButton.setImage(UIImage(named: "star"), for: .normal)

    }
}
