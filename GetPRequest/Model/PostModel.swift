//
//  PostModel.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 7/4/23.
//

import Foundation

struct PostDatum: Codable {
    let userID, id: Int?
    let title, body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias PostData = [PostDatum]
