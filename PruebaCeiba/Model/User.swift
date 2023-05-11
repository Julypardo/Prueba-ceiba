//
//  User.swift
//  PruebaCeiba
//
//  Created by July Pardo on 11/05/23.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.username == rhs.username &&
            lhs.email == rhs.email &&
            lhs.phone == rhs.phone
    }
}
