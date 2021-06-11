//
//  NewController.swift
//  uChat
//
//  Created by elliott chavis on 5/23/21.
//

import UIKit

class SettingsController: UIViewController {
    
    private let themeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        //button.titleLabel?.text = "Themes"  ... doesn't work, use setTitle below
        button.setTitle("Themes", for: .normal)
        //button.tintColor = .blue
        if ThemeManager.sharedInstance.getTheme() == "Default"{
            button.setTitleColor(.blue, for: .normal)

        } else {
            button.setTitleColor(.systemPink, for: .normal)

        }
        button.addTarget(self, action: #selector(showThemes), for: .touchUpInside)

        return button
    }()
    
    //MARK: - #Lifecycles
    override func viewDidLoad(){
        super.viewDidLoad()
        configurUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(withTitle: "Settings", prefersLargeTitles: true)
        let image = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleDismissal))
    }
    
    //MARK: - #Selectors
    
    @objc func showThemes() {
        let controller = ThemeController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)

    }
    
    @objc func handleDismissal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - #Helpers
    
    func configurUI() {
        
        view.backgroundColor = .white

        view.addSubview(themeButton)
        themeButton.setDimensions(height: 40, width: view.frame.width)
        themeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor)
    }
}
