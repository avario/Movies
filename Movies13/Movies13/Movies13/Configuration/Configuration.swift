//
//  Configuration.swift
//  Movies13
//
//  Created by Avario Babushka on 15/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

struct Configuration: Decodable {

	let baseURL: URL
	let apiKey: String

	enum CodingKeys: String, CodingKey {
		case baseURL = "Base URL"
		case apiKey = "API Key"
	}

	static var shared: Self {
		let infoDictionary = Bundle.main.infoDictionary!
		let data = try! JSONSerialization.data(withJSONObject: infoDictionary)
		return try! JSONDecoder().decode(self, from: data)
	}
}
