//
//  MalformedDataLoaderNetworkUtility.swift
//  VrboCodingChallengeTests
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import VrboCodingChallenge

final class MalformedDataLoaderNetworkUtility: NetworkServiceable {

    func searchForEvents(with searchTerm: String, completionHandler: @escaping ([Team]) -> Void, errorHandler: @escaping (LoadError) -> Void) {
        errorHandler(.malformedContent)
    }

}
