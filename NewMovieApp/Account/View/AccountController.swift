//  AccountController.swift
//  NewMovieApp
//  Created by Erkan Emir on 11.06.23.

import UIKit

class AccountController: UIViewController {
    
    var viewModel = AccountViewModel()
    
    let bannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#6a18ff")
        return iv
    }()
    
    private var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    public let userNameLabel     = CustomLabel(text: "",
                                               size: 18,
                                               font: "Poppins-Medium")
    
    private let displayNameLabel = CustomLabel(text: "",
                                               size: 14,
                                               font: "Poppins-Medium")
    
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.register(TopImageBottomLabelCell.self,
                   forCellWithReuseIdentifier: "\(TopImageBottomLabelCell.self)")
        c.backgroundColor = .black
        c.delegate = self
        c.dataSource = self
        
        return c
    }()
    
    //MARK: - Lifecycle
    
//    init(viewModel: AccountViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil,bundle: nil)
//    }
    
//    required init?(coder: NSCoder) { fatalError("init(coder:) has not ") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel.successCallBack = {
            self.configure()
            self.collection.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchAllProcess(id: viewModel.id)
    }
    
    //MARK: - Helper
    func configure() {
        profileImageView.sd_setImage(with: viewModel.avatarURL)
        bannerImageView.sd_setImage(with: viewModel.avatarURL)
        userNameLabel.text = viewModel.accountDatas?.username
        displayNameLabel.text = viewModel.accountDatas?.username
    }
    
    func configureUI() {
        view.addSubview(bannerImageView)
        bannerImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingRight: 0)
        bannerImageView.setHeight(100)
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: view,topAnchor: bannerImageView.bottomAnchor,paddingTop: -16)
        profileImageView.setDimensions(height: 80, width: 80)
        
        view.addSubview(userNameLabel)
        userNameLabel.centerX(inView: view,topAnchor: profileImageView.bottomAnchor,paddingTop: 4)
        
        view.addSubview(displayNameLabel)
        displayNameLabel.centerX(inView: view,topAnchor: userNameLabel.bottomAnchor,paddingTop: 4)
        
        view.addSubview(collection)
        collection.anchor(top: displayNameLabel.bottomAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,paddingTop: 20,
                          paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
}

extension AccountController: UICollectionViewDelegate { }

extension AccountController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favouritedDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(TopImageBottomLabelCell.self)", for: indexPath) as! TopImageBottomLabelCell
        cell.viewModel = TopImageBottomLabelCellViewModel(items: viewModel.favouritedDatas[indexPath.row])
        
        return cell
    }
}

extension AccountController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 120)
    }
}
