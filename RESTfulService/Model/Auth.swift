//
//  Auth.swift
//  RESTfulService
//
//  Created by Mert Ziya on 7.01.2025.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
}
