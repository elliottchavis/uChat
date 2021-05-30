//
//  ThemeController.swift
//  uChat
//
//  Created by elliott chavis on 5/23/21.
//

import UIKit
import JGProgressHUD

class ThemeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - #Lifecycles
    
    override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(withTitle: "Themes", prefersLargeTitles: true)
        let image = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleDismissal))
    }

    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - #Helpers
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        if ThemeManager.sharedInstance.getTheme() == "Default"{
            picker.selectRow(0, inComponent: 0, animated: true)
        } else {
            picker.selectRow(1, inComponent: 0, animated: true)
        }
        
        view.addSubview(picker)
        
        picker.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -20)
    }
    
    
    //MARK: - #PickerDataSource
    
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
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 0.5)
        
        let secondsToDelay = 0.7
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
           print("This message is delayed")
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
}
