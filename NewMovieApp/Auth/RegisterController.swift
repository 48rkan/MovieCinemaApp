//
//  RegisterController.swift
//  NewMovieApp
//  Created by Erkan Emir on 10.05.23.

import UIKit
import WebKit

class RegisterController: UIViewController {

    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        guard let url = URL(string: "https://www.themoviedb.org/signup") else { return }
        
        webView.load(URLRequest(url: url))


    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(webView)
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
        
     
    }
    

}
