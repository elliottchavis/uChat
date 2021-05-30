//
//  AccountViewModel.swift
//  uChat
//
//  Created by elliott chavis on 5/27/21.
//

import Foundation

enum AccountViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo: return "Photo"
        case .settings: return "Email"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "envelope"
        }
    }
    
}
