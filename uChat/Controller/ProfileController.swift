//
//  ProfileController.swift
//  uChat
//
//  Created by agileassociates on 5/2/21.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
//        gradient.locations = [0, 1]
//        headerView.layer.addSublayer(gradient)
        //gradient.frame = bounds
        headerView.backgroundColor = .systemBlue
        configureUI()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    
    
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = self.configureHeaderGradient()
//    }
}
