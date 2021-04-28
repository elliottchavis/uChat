//
//  ConversationsController.swift
//  uChat
//
//  Created by agileassociates on 4/19/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .systemYellow
        button.imageView?.setDimensions(height: 25, width: 25)
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        logout()
    }
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .pageSheet
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: User is not logged in. Presen t login screen here...")
            presentLoginScreen()
        } else {
            print("DEBUG: User is logged in. Configure controller...")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("User logged out...")
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out...")
        }
    }
    
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemTeal
        
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 60, width: 60)
        newMessageButton.layer.cornerRadius = 60 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .systemTeal
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() //gets rid of emtpy lines, extra lines
        tableView.tableFooterView?.backgroundColor = .systemTeal
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.frame
    }
    
    
}

extension ConversationsController: UITableViewDelegate {
    
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    
}

// MARK: - NewMessageControllerDelegate

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        print("\n\n\nYou are presssing a button in the NewMessageController and it is sending data back to the ConversationController b/c it is a delegate of NMController")
        print("DEBUG: User to send message to in conversation controller is \(user.username)")
        
        controller.dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)                                //send user info to ChatController
        navigationController?.pushViewController(chat, animated: true)
    }
    
    
}
