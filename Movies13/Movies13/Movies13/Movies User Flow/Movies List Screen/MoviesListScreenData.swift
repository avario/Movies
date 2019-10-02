//
//  MoviesListScreenData.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine

class MoviesListScreenData: ObservableObject {

	@Published var isLoading: Bool = false
	@Published var movieSummaries: [MovieSummary] = []

	private var request: Cancellable?

	func fetchMovies(from moviesNetwork: MoviesNetwork) {
		request = moviesNetwork
			.request(FetchPopularMovies())
			.map { $0.results }
			.handleEvents(
				receiveSubscription: { _ in self.isLoading = true },
				receiveCompletion: { _ in self.isLoading = false })
			.replaceError(with: [])
			.assign(to: \.movieSummaries, on: self)
	}

	deinit {
		request?.cancel()
	}
}

extension Publisher {

	func load<Root>(into keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> Self {
		return self.handleEvents(
			receiveSubscription: <#T##((Subscription) -> Void)?##((Subscription) -> Void)?##(Subscription) -> Void#>,
			receiveOutput: <#T##((Self.Output) -> Void)?##((Self.Output) -> Void)?##(Self.Output) -> Void#>,
			receiveCompletion: <#T##((Subscribers.Completion<Error>) -> Void)?##((Subscribers.Completion<Error>) -> Void)?##(Subscribers.Completion<Error>) -> Void#>,
			receiveCancel: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>,
			receiveRequest: <#T##((Subscribers.Demand) -> Void)?##((Subscribers.Demand) -> Void)?##(Subscribers.Demand) -> Void#>)
	}

}
