//
//  HttpProvider.swift
//  GithubRepo
//
//  Created by Luiz Durães on 17/07/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import UIKit

protocol HttpProviderProtocol {
    func fetch<T>(endpoint: String, completionHandler: @escaping (Result<T, HttpProviderError>) -> Void) where T: Codable
}

enum HttpProviderError: Error {
    case unavailable
    case decoding
}

// MARK: - HttpProviderProtocol methods
class HttpProvider: HttpProviderProtocol {
    func fetch<T>(endpoint: String, completionHandler: @escaping (Result<T, HttpProviderError>) -> Void) where T: Codable {
        guard let url = URL(string: endpoint) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(.success(decoded))
                    } catch {
                        print("[ERR] HttpProvider >> \(error.localizedDescription)")
                        completionHandler(.failure(.decoding))
                    }
                } else {
                    completionHandler(.failure(.unavailable))
                }
            }
        }.resume()
    }
}
