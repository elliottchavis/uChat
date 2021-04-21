//
//  RegistrationController.swift
//  uChat
//
//  Created by agileassociates on 4/19/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    }()
    
    private lazy var fullnameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "person"), textField: fullnameTextField)
    }()
    
    private lazy var usernameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "person"), textField: usernameTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        let containerView = InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
        containerView.backgroundColor = .clear
        
        
        return containerView
    }()
    
    private let emailTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email"
        txt.textColor = .white
        return txt
    }()
    
    private let fullnameTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Full Name"
        txt.textColor = .white
        return txt
    }()
    
    private let usernameTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Username"
        txt.textColor = .white
        return txt
    }()
    
    private let passwordTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Password"
        txt.isSecureTextEntry = true
        txt.textColor = .white

        return txt
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setHeight(height: 50)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleSelectPhoto() {
        print("Select photo here...")
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Helpers
    
    func configueUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 32, paddingRight: 32)
        
        
    }
}
