//
//  PaginatedResponse.swift
//  RickAndMorthy
//
//   Created by Jesus Daniel Mayo on 26/01/24.
//

import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    let info: Info
    let results: [T]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
