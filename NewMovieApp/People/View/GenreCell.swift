//
//  AnyCell.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 22.04.23.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    public var viewModel: GenreCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "MYSTERY"
        label.numberOfLines = 0
        label.font = UIFont(name: "Mulish-Bold", size: 10)
        label.textColor = UIColor(hexString: "#88A4E8")
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(hexString: "#DBE3FF")
        layer.cornerRadius = 10
    }
    
    private func configureUI() {
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor,left: leftAnchor,
                         bottom: bottomAnchor,right: rightAnchor,
                         paddingTop: 4,paddingLeft: 4,
                         paddingBottom: 4,paddingRight: 4)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    private func configure() {
        textLabel.text = viewModel?.item
    }
}
