//
//  DefaultController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 28.04.23.

extension UIView {

    /**
       Rotate a view by specified degrees
       parameter angle: angle in degrees
     */

    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }

}

import UIKit

//    page control ferqli seydir , uipageviewcontroller ferqli bir seydir

class DefaultController: UIViewController {
    
    private let azButton: UIButton = {
        let button = UIButton()
        button.setTitle("AZE", for: .normal)
        button.addTarget(self, action: #selector(clickedAZE), for: .touchUpInside)
        return button
    }()
    
    private let enButton: UIButton = {
        let button = UIButton()
        button.setTitle("EN", for: .normal)
        button.addTarget(self, action: #selector(clickedEN), for: .touchUpInside)

        return button
    }()
    
    private let trButton: UIButton = {
        let button = UIButton()
        button.setTitle("TR", for: .normal)
        button.addTarget(self, action: #selector(clickedTR) , for: .touchUpInside)

        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [azButton,enButton,trButton])
        stackView.axis         = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var customView: UIView = {
        let iv = UIView(frame: .init(x: 200, y: 100, width: 100, height: 100))
        iv.rotate(angle: 45)
        iv.backgroundColor = .red
        
        return iv
    }()
    
    @objc func clickedAZE() { UserDefaults.standard.set("az", forKey: "appLanguage") }

    @objc func clickedEN() { UserDefaults.standard.set("en", forKey: "appLanguage") }

    @objc func clickedTR() { UserDefaults.standard.set("tr", forKey: "appLanguage") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(customView)
    }
}
