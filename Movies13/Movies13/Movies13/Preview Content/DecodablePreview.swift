//
//  DecodablePreview.swift
//  Movies13
//
//  Created by Avario Babushka on 20/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

extension Decodable {
	static func preview(_ fileName: String, decoder: JSONDecoder = JSONDecoder()) -> Self {
		guard let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
			fatalError("Couldn't find \(fileName) in main bundle.")
		}

		do {
			let data = try Data(contentsOf: path)
			return try decoder.decode(Self.self, from: data)
		} catch {
			fatalError(error.localizedDescription)
		}
	}
}
