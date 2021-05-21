//
//  ProfileController.swift
//  uChat
//
//  Created by agileassociates on 5/2/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "ProfileCell"

protocol ProfileControllerDelegate: class {
    func handleLogout()
}

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private var user: User? {
        didSet { headerView.user = user }
    }
    
    weak var delegate: ProfileControllerDelegate?
    
    private let footerView = ProfileFooter()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if ThemeManager.sharedInstance.getTheme() == "Default"{
            headerView.backgroundColor = .systemBlue
        } else {
            headerView.backgroundColor = .systemPink
        }
        configureUI()
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
    
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        tableView.contentInsetAdjustmentBehavior = .never //hides status bar at top
        
        footerView.delegate = self
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
    }
    
    
    
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = self.configureHeaderGradient()
//    }
}

// MARK: - UITableViewDelegate

extension ProfileController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else { return }
        print("DEBUG: Handle action for \(viewModel.description)")
        
        switch viewModel {
        case .accountInfo:
            print("DEBUG: Show account info...")
        case .settings:
            print("DEBUG: Show settings...")
            let controller = SettingsController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true, completion: nil)
            
        }
    }
    
}

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileController: ProfileFooterDelegate {
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Logout?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
