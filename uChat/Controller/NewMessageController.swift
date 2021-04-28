//
//  NewMessageController.swift
//  uChat
//
//  Created by agileassociates on 4/28/21.
//

import UIKit

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemPink
    }
}
