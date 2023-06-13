//
//  VerticalCell.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 08.04.23.
//

import UIKit
import SDWebImage

protocol TopImageBottomLabelCellProtocol {
    var imageURL   :String { get }
    var titleText  :String { get }
    var movieID :Int { get }
}

protocol TopImageBottomLabelCellDelegate: AnyObject {
    func doFavourite(_ cell: TopImageBottomLabelCell,id: Int)
}

class TopImageBottomLabelCell: UICollectionViewCell {
    
    public var viewModel: TopImageBottomLabelCellViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: TopImageBottomLabelCellDelegate?
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "movie")
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Symbol", size: 16)
        label.textColor = UIColor(hexString: "#222F3D")
//        label.text = "FREE GUY"
//        label.attributedText = NSAttributedString(string: "free guy")
        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
//        label.sizeToFit()

        return label
    }()
    
    lazy var favouriteButton: UIButton = {
        let b = UIButton()
//        b.setImage(UIImage(named: "unstar"), for: .normal)
        b.addTarget(self, action: #selector(doFavourite), for: .touchUpInside)
        return b
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not been ") }
    
    //awake from nib - programmaticallyde cagirilmir.
    override class func awakeFromNib() { super.awakeFromNib() }
    
    // contraintlerde deyisiklik ucun tasarlanib ( round , bound , ve s eklemek ) forma vermek kimi
    // init 1 defe cagirilir , layout subviews her cell yarananda
    override func layoutSubviews() { super.layoutSubviews() }
    
    // cell'ler collection'a yerlesende cagirilir
    override func prepareForReuse() { super.prepareForReuse() }
    
    @objc func doFavourite() {
        delegate?.doFavourite(self, id: viewModel?.items.movieID ?? 0)
        
    }
    
    private func configureUI() {
        addSubview(movieImage)
        movieImage.anchor(top: topAnchor,left: leftAnchor,
                          right: rightAnchor,paddingTop: 10,
                          paddingLeft: 10, paddingRight: 10)
        movieImage.equalHeight(percent: 0.75, mainHeight: heightAnchor)
        
        addSubview(favouriteButton)
        favouriteButton.anchor(top: movieImage.topAnchor,left: movieImage.leftAnchor,paddingTop: 4,paddingLeft: 4)
        
        addSubview(movieTitle)
        movieTitle.anchor(top: movieImage.bottomAnchor,left: leftAnchor,
                          bottom: bottomAnchor,right: rightAnchor,
                          paddingTop: 4,paddingLeft: 12,
                          paddingBottom: 0,paddingRight: 4)
//        movieTitle.setDimensions(height: 23, width: 108)
    }
    
    private func configure() {
        movieImage.sd_setImage(with: viewModel?.imageURL)
        movieTitle.text = viewModel?.title
        
        if viewModel?.isFavourited  == true {
            favouriteButton.setImage(UIImage(named: "star"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "unstar"), for: .normal)
        }
    }
}
