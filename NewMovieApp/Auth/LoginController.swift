//
//  LoginController.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 10.05.23.

import UIKit

protocol LoginControllerDelegate: AnyObject {
    func authCompleted(id: String)
}

class LoginController: UIViewController {
    
    weak var delegate: LoginControllerDelegate?
    
    var viewModel = LoginViewModel()
    //"Aslanaslan44",
    //"password":"aslan444"
        
    private lazy var emailTextField: CustomTextField =  {
        let tf = CustomTextField(placeholder: "Email")
        tf.addTarget(self, action: #selector(editingChangedTextFields), for: .editingChanged)
        tf.text = "Aslanaslan44"
        //"password":"aslan444"
        return tf
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password",isSecure: false)
        tf.addTarget(self, action: #selector(editingChangedTextFields), for: .editingChanged)
        tf.text = "aslan444"
        return tf
    }()
    
    private let logInButton: UIButton = {
        let l = UIButton()
        l.setTitle("Log In", for: .normal)
        l.setTitleColor(.darkGray, for: .normal)
        return l
    }()
    
    private let registerButton: UIButton = {
        let r = UIButton()
        r.setTitle("Register", for: .normal)
        r.setTitleColor(.darkGray, for: .normal)
        
        return r
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configure()
        configureRightBarbutton()
    }
    
    func configureRightBarbutton() {
        let rightButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func editingChangedTextFields(sender: UITextField) {
        if sender == emailTextField {
            viewModel.username = sender.text
        } else {
            viewModel.password = sender.text
        }
    }
    
    @objc func goBack() {
        navigationController?.dismiss(animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,logInButton,registerButton])
        view.addSubview(stack)
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.centerX(inView: view)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 20,paddingLeft: 8,paddingRight: 8)
        stack.setHeight(240)
    }
    
    func configure() {
        logInButton.addTarget(self, action: #selector(tappedLogIn), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(goRegister), for: .touchUpInside)
    }
    
    @objc func tappedLogIn() {
        viewModel.getAccountDatas()
        
        viewModel.callBack = { id in
            UserDefaults.standard.set(true, forKey: "SUCCESS_LOGIN")
            self.dismiss(animated: true)
            self.delegate?.authCompleted(id: id)
        }
    }
    
    @objc func goRegister() {
        navigationController?.show(RegisterController(), sender: nil)
    }
}
