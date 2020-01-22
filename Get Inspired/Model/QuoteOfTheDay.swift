//
//  QuoteOfTheDay.swift
//  Get Inspired
//
//  Created by Darragh Blake on 22/01/2020.
//  Copyright © 2020 Darragh Blake. All rights reserved.
//

import Foundation

struct QuoteOfTheDay: Decodable {
    let contents: Contents
}

struct Contents: Decodable {
    let quotes: [Quotes]
    let copyright: String
}

struct Quotes: Decodable {
    let quote: String
    let author: String
    let tags: [String]
    let category: String
    let date: String
    let title: String
    let background: String
}
