//
//  ValidDataLoaderNetworkUtility.swift
//  VrboCodingChallengeTests
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import VrboCodingChallenge

final class ValidDataLoaderNetworkUtility: NetworkServiceable {
    func searchForTeamSchedule(with teamName: String, completionHandler: @escaping ([Team]) -> Void, errorHandler: @escaping (LoadError) -> Void) {
        let teams = [
            Team(id: 100, title: "Team 1", venue: Venue(city: "City 1", state: "State 1"), dateTimeLocalString: "2019-12-08T03:30:00", performers: []),
            Team(id: 100, title: "Team 2", venue: Venue(city: "City 2", state: "State 2"), dateTimeLocalString: "2018-12-08T03:30:00", performers: [])]
        completionHandler(teams)
    }
}
