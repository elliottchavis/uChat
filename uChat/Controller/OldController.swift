//
//  SettingsController.swift
//  uChat
//
//  Created by agileassociates on 5/18/21.
//

import UIKit
import JGProgressHUD

private let reuseIdentifier = "Cell"

protocol ColorDelegate: AnyObject {
    func changeColor(_ color: UIColor?)
}

class OldController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: ColorDelegate?

    private let dismissButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
            button.backgroundColor = .systemBlue
            button.tintColor = .white
            button.imageView?.setDimensions(height: 22, width: 22)
            return button
        }()
    
    private let themeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.titleLabel?.text = "Themes"
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)

    
        return button
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Themes"
        label.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked(_:)))
        label.addGestureRecognizer(guestureRecognizer)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(withTitle: "Settings", prefersLargeTitles: true)
        let image = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(exit))

    }
    
    // MARK: - Selectors
    
    @objc func labelClicked(_ sender: Any) {
        let controller = ThemeController()
        show(controller, sender: self)
        print("label clicked")
    }
    
    @objc func handleDismissal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showThemes() {
        let controller = ThemeController()
        show(controller, sender: self)
    }
    
    @objc func exit() {
        let controller = ProfileController()
//        let nav = UINavigationController(rootViewController: controller)
        show(controller, sender: self)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        // Set appearance
//        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        if ThemeManager.sharedInstance.getTheme() == "Default"{
//            appearance.backgroundColor = .systemBlue
//        } else {
//            appearance.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
//        }
        
        // Set NavigationBar
//        navigationBar.standardAppearance = appearance
//        navigationBar.compactAppearance = appearance
//        navigationBar.scrollEdgeAppearance = appearance
//        navigationBar.isTranslucent = true
//        navigationBar.barTintColor = .systemBlue
//        navigationBar.prefersLargeTitles = true
//
//        view.addSubview(navigationBar)
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        navigationBar.overrideUserInterfaceStyle = .dark
//
//        navigationBar.delegate = self
//
        //Create an imageview to display image
//        let itemImage = UIImage(systemName: "plus")
//        let headerImageView = UIImageView(image: itemImage)
//        headerImageView.contentMode = .scaleAspectFit
        
        
//        let itemTitle = UINavigationItem()
//
//        itemTitle.title = "Settings"
//
//
//        let image = UIImage(systemName: "markx")
//        let markxItem = UINavigationItem()
//        markxItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleDismissal))
//
//        let button = UIButton()
//        let backItem = UINavigationItem()
//        button.setImage(UIImage(systemName: "markx"), for: .normal)
//        button.tintColor = .white
//        backItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//
//        navigationBar.items = [itemTitle]
//
        
        
//        view.addSubview(dismissButton)
//        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 5, paddingLeft: 12)

                
//        view.addSubview(themeButton)
//        themeButton.setDimensions(height: 40, width: 64)
//        themeButton.anchor(top: navigationBar.bottomAnchor, paddingTop: 10)

//
//        let picker = UIPickerView()
//        picker.delegate = self
//        picker.dataSource = self
//        picker.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(picker)
//
//        picker.anchor(top: themeLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -20)
//
    }
    
    // MARK: - PickerDataSource
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let pickerData = ["Default", "Miami"]
//        return pickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if row == 0 {
//            ThemeManager.sharedInstance.setTheme(userTheme: "Default")
//            print(ThemeManager.sharedInstance.getTheme())
//        } else {
//            ThemeManager.sharedInstance.setTheme(userTheme: "Miami")
//            print(ThemeManager.sharedInstance.getTheme())
//        }
//        let hud = JGProgressHUD()
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        hud.dismiss(afterDelay: 0.5)
//
//        let secondsToDelay = 0.5
//        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
//           print("This message is delayed")
//            self.handleDismissal()
//        }
//    }
//}
    
}

extension OldController:UINavigationBarDelegate{
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

