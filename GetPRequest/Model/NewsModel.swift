//
//  NewsModel.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 7/4/23.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let thumbnail: String?
    
    init(id: Int?, title: String?, description: String? = nil, thumbnail: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}

//struct Product: Codable {
//    let id: Int?
//    let title, description: String?
//    let price: Int?
//    let discountPercentage, rating: Double?
//    let stock: Int?
//    let brand, category: String?
//    let thumbnail: String?
//    let images: [String]?
//}
