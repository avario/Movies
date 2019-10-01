//
//  PreviewLoader.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

struct PreviewLoader {

	static let shared: PreviewLoader = PreviewLoader()

	func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
		let data: Data

		guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
			fatalError("Couldn't find \(filename) in main bundle.")
		}

		do {
			data = try Data(contentsOf: file)
		} catch {
			fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
		}

		do {
			let decoder = JSONDecoder()
			return try decoder.decode(T.self, from: data)
		} catch {
			fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
		}
	}
}
