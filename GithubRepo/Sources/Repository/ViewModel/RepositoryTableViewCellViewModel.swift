//
//  RepositoryTableViewCellViewModel.swift
//  GithubRepo
//
//  Created by Luiz Durães on 22/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import UIKit

final class RepositoryTableViewCellViewModel {
    // MARK: - Properties
    private(set) var model: Repository

    // MARK: - Initializers
    init(model: Repository) {
        self.model = model
    }
    
    // MARK: - Public methods
    func getBackgroundColor() -> UIColor {
        return model.fork ? .green : .clear
    }
}
