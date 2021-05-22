//
//  SettingsController.swift
//  uChat
//
//  Created by agileassociates on 5/18/21.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol ColorDelegate: AnyObject {
    func changeColor(_ color: UIColor?)
}

class SettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    
   // weak var delegate: ColorDelegate?

    private let dismissButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
            button.backgroundColor = .systemBlue
            button.tintColor = .white
            button.imageView?.setDimensions(height: 22, width: 22)
            return button
        }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Themes"
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
    
    @objc func handleDismissal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func exit() {
        let controller = ProfileController()
        let nav = UINavigationController(rootViewController: controller)

        show(controller, sender: self)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        
        view.addSubview(dismissButton)
                dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 3)
                
                view.addSubview(themeLabel)
                themeLabel.setDimensions(height: 15, width: 64)
                themeLabel.anchor(top: dismissButton.bottomAnchor, paddingTop: 10)
                
        
        
        
//        view.addSubview(themeLabel)
//        themeLabel.setDimensions(height: 15, width: 64)
//        themeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(picker)
        
        picker.anchor(top: themeLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -20)

//        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        picker.topAnchor.constraint(equalTo: themeLabel.bottomAnchor).isActive = true
        
        
    }
    
    // MARK: - PickerDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerData = ["Default", "Miami"]
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            ThemeManager.sharedInstance.setTheme(userTheme: "Default")
            print(ThemeManager.sharedInstance.getTheme())
            
            
            

            
        } else {
            ThemeManager.sharedInstance.setTheme(userTheme: "Miami")
            print(ThemeManager.sharedInstance.getTheme())
            
            
            

        }
        
    }
}
