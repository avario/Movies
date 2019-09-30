//
//  ShotsNetwork.swift
//  Abstract
//
//  Created by Avario Babushka on 07/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import ResponseDetective
import Alamofire

class MoviesNetwork: NetworkService {
    
    init() {
        let configuration = URLSessionConfiguration.default
        ResponseDetective.enable(inConfiguration: configuration)
        let manager = Session(configuration: configuration)
        
        super.init(baseURL: "https://api.themoviedb.org/3/", sessionManager: manager)
        
        persistentParameters = ["api_key": "7141478ba63e445f5cc58583ed4bbb45"]
    }
    
}
