//
//  FetchShots.swift
//  Abstract
//
//  Created by Avario on 08/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire

extension MoviesNetwork {
    struct FetchPopularMovies: NetworkRequest {
        let method: HTTPMethod = .get
        let path: String = "discover/movie"
        let parameters: Parameters
        
        init(sortBy: String =  "popularity.desc") {
            parameters = Parameters(sortBy: sortBy)
        }
        
        struct Response: Decodable {
            let page: Int
            let results: [MovieSummary]
        }
        
        struct Parameters: Encodable {
            let sortBy: String
            
            enum CodingKeys: String, CodingKey {
                case sortBy = "sort_by"
            }
        }
    }
}
