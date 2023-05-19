//
//  PeopleController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 17.04.23.
//

import UIKit

class PeopleController: UIViewController {
    
    //MARK:- Properties
    
    private var viewModel = PeopleViewModel()
    
//    var coordinator: PeopleCoordinator?
    
    private lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        l.sectionInset.left = 16
        l.sectionInset.right = 16

        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.register(TopImageBottomLabelCell.self, forCellWithReuseIdentifier: "\(TopImageBottomLabelCell.self)")
        c.delegate   = self
        c.dataSource = self
        
        c.showsVerticalScrollIndicator   = false
        c.showsHorizontalScrollIndicator = false
        
        return c
    }()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        confireUI()
        configureNavigationBar()
         
        viewModel.fetchPopularPeople()
        
        guard let nav = navigationController else { return }
        viewModel.coordinator = PeopleCoordinator(navigationController: nav)

        viewModel.successCallBack = {
            self.collectionView.reloadData()
//            self.collectionView.scrollToItem(at: IndexPath(item: self.viewModel.items.count - 1, section: 0), at: .centeredVertically, animated: true)
        }
    }

    private func confireUI() {
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 4,paddingLeft: 0,
                              paddingBottom: 0,paddingRight: 0)
    }
    
    private func configureNavigationBar() {
        view.backgroundColor = .white
        navigationItem.title = "People"
    }
}

//MARK:- UICollectionViewDelegate

extension PeopleController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller = PeopleMoviesController()
//        controller.viewModel.personId = viewModel.items[indexPath.row].id ?? 0
//
//        navigationController?.show(controller, sender: nil)
        viewModel.coordinator?.showPeopleMovies(personID: viewModel.items[indexPath.row].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.row)
    }
}

//MARK:- PeopleController

extension PeopleController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.items.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TopImageBottomLabelCell.self)", for: indexPath) as! TopImageBottomLabelCell
        cell.viewModel = TopImageBottomLabelCellViewModel(items: viewModel.items[indexPath.row])
//        cell.viewModel = PeopleCellViewModel(items: viewModel.items[indexPath.row])
        return cell
    }
}

extension PeopleController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2 - 24 , height: view.frame.height / 3 - 24)
    }
}
