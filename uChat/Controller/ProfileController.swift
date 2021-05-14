//
//  ProfileController.swift
//  uChat
//
//  Created by agileassociates on 5/2/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "ProfileCell"

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private var user: User? {
        didSet { headerView.user = user }
    }
    private let footerView = ProfileFooter()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.backgroundColor = .systemBlue
        configureUI()
        fetchUser()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
