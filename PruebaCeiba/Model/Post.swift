//
//  Post.swift
//  PruebaCeiba
//
//  Created by July Pardo on 11/05/23.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
