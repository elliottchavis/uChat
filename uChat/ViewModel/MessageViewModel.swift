//
//  MessageViewModel.swift
//  uChat
//
//  Created by agileassociates on 4/28/21.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        if message.isFromCurrentUser {
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            if ThemeManager.sharedInstance.getTheme() == "Default"{
                return .systemBlue
            } else {
                return .systemPink
            }
        }
        
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
    }
    
    init(message: Message) {
        self.message = message
    }
}
