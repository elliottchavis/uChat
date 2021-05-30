//
//  ProfileController.swift
//  uChat
//
//  Created by agileassociates on 5/2/21.
//

import UIKit
import Firebase
import JGProgressHUD

private let reuseIdentifier = "AccountCell"

protocol PhotoDelegate: AnyObject {
    func changePhoto(_ photo: UIImage?)
}

class AccountController: UITableViewController, ProfileHeaderDelegate {
    
    // MARK: - Properties
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private var user: User? {
        didSet { headerView.user = user }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    weak var photoDelegate: PhotoDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
                configureUI()
        if ThemeManager.sharedInstance.getTheme() == "Default"{
            headerView.backgroundColor = .systemBlue
        } else {
            headerView.backgroundColor = .systemPink
        }
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            print("\n\n\n\n\n\n\n\n\n\n\n\nDEBUG: User is \(user.username)")
        }
    }
    
    // MARK: - Helpers
    
    func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func dismissController() {
        if (self.navigationController?.topViewController == self) {
            dismiss(animated: true, completion: nil)
        }    }
    
    func configureUI() {
        headerView.delegate = self
        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        tableView.register(AccountCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        tableView.contentInsetAdjustmentBehavior = .never //hides status bar at top
    }
    
}

extension AccountController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccountCell
        let viewModel = AccountViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AccountController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = AccountViewModel(rawValue: indexPath.row) else { return }
        print("DEBUG: Handle action for \(viewModel.description)")
        
        switch viewModel {
        case .accountInfo:
            print("DEBUG: Show profile photo info...")
            handleSelectPhoto()
        case .settings:
            print("DEBUG: Show email info...")
            let controller = SettingsController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
            
        }
    }
}

extension AccountController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        photoDelegate?.changePhoto(image)
        headerView.changePhoto(image)
        guard let profileImage = image else { return }
        
        AuthService.shared.deletePhoto()

        AuthService.shared.setPhoto(photo: profileImage) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                self.showLoader(true)
                return
            }
        }
        
        dismiss(animated: true, completion: nil)

        
//        let hud = JGProgressHUD()
//        hud.textLabel.text = "Setting Photo..."
//        hud.show(in: self.view)
//        hud.dismiss(afterDelay: 0.5)
//
//        let secondsToDelay = 0.7
//        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
//           print("This message is delayed")
//            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//        }
    }
}


