//
//  AcronymList.swift
//  AcronymSearch
//
//  Created by Rajesh Sammita on 05/06/22.
//

import Foundation

struct AcronymListResponse: Codable {
    let shortForm: String?
    let longFormList: [LongForm]?
    enum CodingKeys: String, CodingKey {
        case shortForm = "sf"
        case longFormList = "lfs"
    }
}

struct LongForm: Codable {
    let longForm: String?
    enum CodingKeys: String, CodingKey {
        case longForm = "lf"
    }
}
