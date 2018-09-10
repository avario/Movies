//
//  MovieSummary.swift
//  Movies
//
//  Created by Avario on 08/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

struct MovieSummary: Codable {
    
    // Properties
    let id: Property<Int>
    let title: Property<String>
    let rating: Property<Double>
    private let backdropPath: Property<String>
    
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
    }
    
}

extension MovieSummary {
    
    // Backdrop Image URL
    var backdropImageURL: Property<URL> {
        return backdropPath.map({ backdropPath in
            let url = try! "https://image.tmdb.org/t/p/w1280".asURL()
            return url.appendingPathComponent(backdropPath)
        })
    }
    
}
