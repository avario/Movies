//
//  FetchMovieDetails.swift
//  Abstract
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire

extension MoviesNetwork {
    
    struct FetchMovieDetails: NetworkRequest {
        let method: HTTPMethod = .get
        let path: String
        
        init(movieId: Int) {
            path = "movie/" + String(movieId)
        }
        
        typealias Response = MovieDetails
    }
    
}
