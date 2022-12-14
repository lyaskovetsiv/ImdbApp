//
//  Video.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import Foundation

struct APIResponse: Codable{
    let items: [Video]
}

struct SearchResponse: Codable{
    let results: [Video]
}

struct Video: Codable{
    let title: String
    let year: String?
    let image: String?
}
