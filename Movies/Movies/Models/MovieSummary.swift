//
//  Shot.swift
//  Abstract
//
//  Created by Avario on 08/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire

struct MovieSummary: Codable {
    let id: Int
    let title: String
    let backdropPath: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
    }
}

extension MovieSummary {
    var backdropImageURL: URL? {
        let url = try! "https://image.tmdb.org/t/p/w1280".asURL()
        return url.appendingPathComponent(backdropPath)
    }
}
