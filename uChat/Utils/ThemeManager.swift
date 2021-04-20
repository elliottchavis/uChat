//
//  themeManager.swift
//  uChat
//
//  Created by agileassociates on 4/19/21.
//

import UIKit

class ThemeManager {
    
    var theme: Bool
    
    init(darkTheme: Bool) {
        theme = darkTheme
    }
}

////
////  LoginController.swift
////  uChat
////
////  Created by agileassociates on 4/19/21.
////
//
//import UIKit
//
//let themeSwitch = ThemeManager(darkTheme: true)
//
//
//class  LoginController: UIViewController {
//
//    // MARK: - Properties
//
//    private let iconImage: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(systemName: "bubble.right")
//        iv.tintColor = .systemYellow
//        return iv
//    }()
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        configureMiamiGradientLayer()
//        configureUI()
//
//    }
//
//    // MARK: - Helpers
//
//    func configureUI() {
//
//
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.barStyle = .black
//
//
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
//
//
//        view.addSubview(iconImage)
//        iconImage.translatesAutoresizingMaskIntoConstraints = false
//        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
//
//
//    }
//
//    func configureMiamiGradientLayer() {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
//        gradient.locations = [0, 1]
//        view.layer.addSublayer(gradient)
//        gradient.frame = view.frame
//    }
//
//    func configureAquaGradientLayer() {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
//        gradient.locations = [0, 1]
//        view.layer.addSublayer(gradient)
//        gradient.frame = view.frame
//    }
//
//    // MARK: - Selectors
//
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
//
//
//           }
//       }
//}
//
//
//
