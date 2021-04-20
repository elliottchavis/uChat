//
//  LoginController.swift
//  uChat
//
//  Created by agileassociates on 4/19/21.
//

import UIKit

//let themeSwitch = ThemeManager(darkTheme: true)


class  LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private let emailContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .cyan
        view.setHeight(height: 50)
        return view
    }()
    
    private let passwordContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .cyan
        view.setHeight(height: 50)
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemRed
        button.setHeight(height: 50)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureMiamiGradientLayer()
        configureUI()
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        

        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        
//       // view.backgroundColor = .systemPink
//
//        let switchDemo = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
//        switchDemo.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
//        if themeSwitch.theme == true {
//            switchDemo.setOn(true, animated: true)
//        } else {
//            switchDemo.setOn(false, animated: true)
//        }
//        self.view.addSubview(switchDemo)
 
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
//        iconImage.translatesAutoresizingMaskIntoConstraints = false
//        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        

    }
    
    func configureMiamiGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func configureAquaGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    // MARK: - Selectors
    
//    @objc func switchStateDidChange(_ sender:UISwitch!)
//       {
//           if (sender.isOn == true){
//               print("UISwitch state is now ON")
//            themeSwitch.theme = true
//                print("Dark theme is true and is ON")
//            configureMiamiGradientLayer()
//            configureUI()
//
//           }
//           else{
//               print("UISwitch state is now Off")
//            themeSwitch.theme = false
//                print("Dark theme is false and is OFF")
//            configureAquaGradientLayer()
//            configureUI()
//           }
//       }
}


