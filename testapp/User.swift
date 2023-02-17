//
//  User.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 20.01.23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
 
    let username: String
    let email: String
    let address: Address
     
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case address
    }
}

struct Address: Codable {
    let city: String
    let country: String

    private enum CodingKeys: String, CodingKey {
        case city
        case country
    }
}
