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
    private var conversations = [Conversation]()
    private var conversationsDictionary = [String: Conversation]()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        if ThemeManager.sharedInstance.getTheme() == "Default"{
            button.backgroundColor = .systemBlue
            button.tintColor = .white
        } else {
            button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            button.tintColor = .white
        }
        
        button.imageView?.setDimensions(height: 25, width: 25)
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
        if ThemeManager.sharedInstance.getTheme() == "Default"{
            newMessageButton.backgroundColor = .systemBlue
            newMessageButton.tintColor = .white
        } else {
            newMessageButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            newMessageButton.tintColor = .white
        }
        

    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        //let controller = ProfileController(style: .insetGrouped)
        let controller = ProfileController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .pageSheet
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchConversations() {
        Service.fetchConversations { conversations in
            conversations.forEach { conversation in
                let message = conversation.message
                self.conversationsDictionary[message.chatPartnerId] = conversation
            }
            
            self.conversations = Array(self.conversationsDictionary.values)
            self.tableView.reloadData()
            
        }
    }
    
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
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out...")
        }
    }
    
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 60, width: 60)
        newMessageButton.layer.cornerRadius = 60 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() //gets rid of emtpy lines, extra lines
        tableView.tableFooterView?.backgroundColor = .systemTeal
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.frame
    }
    
    
}

// MARK: UITableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: UITableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell.backgroundColor = .systemTeal                        *******  THEME  *******
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    
}

// MARK: - NewMessageControllerDelegate

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        print("\n\n\nYou are presssing a button in the NewMessageController and it is sending data back to the ConversationController b/c it is a delegate of NMController")
        print("DEBUG: User to send message to in conversation controller is \(user.username)")
        
        dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)                                //send user info to ChatController
        navigationController?.pushViewController(chat, animated: true)
    }
}

extension ConversationsController: AuthenticationDelegate {
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
        fetchConversations()
    }
}

extension ConversationsController: ProfileControllerDelegate {
    func handleLogout() {
        logout()
    }
}
