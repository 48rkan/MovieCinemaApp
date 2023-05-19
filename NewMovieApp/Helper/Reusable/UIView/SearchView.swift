//  SearchView.swift
//  NewMovieApp
//  Created by Erkan Emir on 26.04.23.

import UIKit

protocol SearchViewDelegate: AnyObject {
    func view(_ searchView: SearchView , editingChangedTextField text: String)
    func searchIconClicked(_ view: SearchView)
}


class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?
        
    public lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Search"
        tf.font = UIFont(name: "Mulish-Bold", size: 16)
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.delegate = self
        tf.addTarget(self, action: #selector(changedTextFieldAction), for: .editingChanged)
                
        return tf
    }()
    
    public lazy var searchIcon: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "search-normal")
        i.isUserInteractionEnabled = true
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchIconTapped)))
        
        return i
    }()

    //MARK:- Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = UIColor(hexString: "F9F9F9")
        layer.cornerRadius = 24
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK:- Actions

    @objc private func searchIconTapped() {
        // becomeFirstResponder - kalivaturani acir
        delegate?.searchIconClicked(self)
    }
    
    @objc private func changedTextFieldAction() {
        guard let searchText = textField.text?.lowercased() else { return }
        
        delegate?.view(self, editingChangedTextField: searchText)
    }
    
    private func configureUI() {
        addSubview(searchIcon)
        searchIcon.centerY(inView: self , leftAnchor: leftAnchor ,paddingLeft: 8)
        searchIcon.setDimensions(height: 28, width: 28)

        addSubview(textField)
        textField.anchor(top: topAnchor,left: searchIcon.rightAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 4,paddingBottom: 8,paddingRight: 20)
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resign - kalivaturani baglayir
        textField.resignFirstResponder()
        return true
    }
    
    // X duymesine basanda call olunur
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        return true
    }
}
