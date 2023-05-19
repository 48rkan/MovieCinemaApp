//
//  MoviesCell.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 20.04.23.
//

import UIKit
import SDWebImage

protocol MoviesCellProtocol {
    var title_    :String  { get }
    var imageUrl_ :String  { get }
    var imdbPoint_:Double  { get }
    var genres_   :[Int]   { get }
    var date      :String  { get }
}

class MoviesCell: UICollectionViewCell {
        
    public var viewModel: MoviesCellViewModel? {
        didSet {
//            viewModel?.fetchAllGenre { self.collectionView.reloadData() }
            configure()
            collectionView.reloadData()
        }
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray

        return image
    }()
    
    private let movieTitle: UILabel = {
        let movieTitle = UILabel()
        movieTitle.font = UIFont(name: "Mulish-Bold", size: 14)
        movieTitle.numberOfLines = 0
        movieTitle.textColor = UIColor(hexString: "#000000")
        
        return movieTitle
    }()
    
    private let imdbPointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#9C9C9C")

        return label
    }()
    
    private let starIconImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "starr")
        
        return icon
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing      = 8
        layout.minimumInteritemSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate   = self
        collection.dataSource = self
        collection.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
        
        return collection
    }()
    
    private let clockIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "clock")
        
        return icon
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "2012-01-01"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#9C9C9C")
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(hexString: "FFC319")
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not") }
    
    private func configureUI() {
    
        addSubview(imageView)
        imageView.anchor(top: topAnchor,left: leftAnchor,bottom: bottomAnchor,paddingTop: 8,paddingLeft: 24,paddingBottom: 4)
        imageView.equalHeight(percent: 0.85, mainHeight: heightAnchor)
        imageView.equalWidth(percent: 0.25, mainWidth: widthAnchor)
        
        addSubview(movieTitle)
        movieTitle.anchor(top: topAnchor,left: imageView.rightAnchor,right: rightAnchor,paddingTop: 10,paddingLeft: 16,paddingRight: 8)
        
        addSubview(starIconImage)
        starIconImage.anchor(top: movieTitle.bottomAnchor,left: imageView.rightAnchor,paddingTop: 4,paddingLeft: 16)
        starIconImage.setDimensions(height: 12, width: 12)
        
        addSubview(imdbPointLabel)
        imdbPointLabel.centerY(inView: starIconImage,leftAnchor: starIconImage.rightAnchor ,paddingLeft: 4)
        
        addSubview(collectionView)
        collectionView.anchor(top: imdbPointLabel.bottomAnchor,left: imageView.rightAnchor,paddingTop: 8,paddingLeft: 16)
        collectionView.setDimensions(height: 18, width: 203)
        collectionView.showsVerticalScrollIndicator   = false
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(clockIcon)
        clockIcon.anchor(top: collectionView.bottomAnchor,left: imageView.rightAnchor,paddingTop: 10,paddingLeft: 16)
        clockIcon.setDimensions(height: 10, width: 10)
        
        addSubview(timeLabel)
        timeLabel.anchor(top: collectionView.bottomAnchor,left: starIconImage.rightAnchor,paddingTop: 8,paddingLeft: 4)
    }
    
    private func configure() {
        movieTitle.text = viewModel?.title
        imageView.sd_setImage(with: viewModel?.imageURL)
        imdbPointLabel.text = viewModel?.imdbPoint
        timeLabel.text = viewModel?.items.date
    }
}

extension MoviesCell: UICollectionViewDelegate { }

extension MoviesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel?.genreList.count ?? 0 }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as! GenreCell
        cell.viewModel = GenreCellViewModel(item: viewModel?.genreList[indexPath.row] ?? "")
        return cell
    }
}

extension MoviesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = dynamicWidthCalculator(text: viewModel?.genreList[indexPath.row] ?? "", height: 18)
        return  CGSize(width: width, height: 18)
    }
}
