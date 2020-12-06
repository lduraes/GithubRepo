//
//  Repository.swift
//  GithubRepo
//
//  Created by Luiz Durães on 15/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let login: String
}

struct Repository: Codable {
    let name: String
    let description: String
    let owner: Owner
    let fork: Bool
}
