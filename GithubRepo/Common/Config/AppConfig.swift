//
//  AppConfig.swift
//  GithubRepo
//
//  Created by Luiz Durães on 17/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import Keys

struct AppConfig {
    static let repositoryListEndpoint = GithubRepoKeys().aPIEndpoint

    enum Title: String {
        case repositoryList = "Repositories"
    }
}
