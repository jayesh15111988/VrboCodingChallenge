//
//  TeamsListViewModelTests.swift
//  VrboCodingChallengeTests
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import VrboCodingChallenge

final class TeamsListViewModelTests: XCTestCase {

    func testTheBehaviorWhenNonEmptyDataModelsAreFetched() {
        let networkUtility = ValidDataLoaderNetworkUtility()
        let teamListViewModel = TeamsListViewModel(networkUtility: networkUtility)
        teamListViewModel.searchForEvents(with: "abc")

        XCTAssertEqual(teamListViewModel.viewModels.count, 2)
        XCTAssertNil(teamListViewModel.error)
    }

    func testTheBehaviorWhenErrorOccursWhileFetchingDataFromServer() {
        let networkUtility = MalformedDataLoaderNetworkUtility()
        let teamListViewModel = TeamsListViewModel(networkUtility: networkUtility)
        teamListViewModel.searchForEvents(with: "abc")

        XCTAssertTrue(teamListViewModel.viewModels.isEmpty)
        XCTAssertNotNil(teamListViewModel.error)
        XCTAssertEqual(teamListViewModel.error?.errorMessageString(), "Invalid JSON received from the service. Please check your models again and make sure the format matches with the incoming JSON")
    }

    func testThatViewModelClearsTheListOfOldViewModels() {
        let networkUtility = ValidDataLoaderNetworkUtility()
        let teamListViewModel = TeamsListViewModel(networkUtility: networkUtility)
        teamListViewModel.searchForEvents(with: "abc")

        XCTAssertEqual(teamListViewModel.viewModels.count, 2)

        teamListViewModel.clearList()

        XCTAssertTrue(teamListViewModel.viewModels.isEmpty)
    }

    func testThatViewModelSuccessfullyConvertsRawModelsIntoViewModels() {
        let team = Team(id: 100, title: "My Team", venue: Venue(city: "City 1", state: "State 1"), dateTimeLocalString: "2019-09-08T03:30:00", performers: [Performers(image: "https://www.google.com/noimage.png")])

        let viewModel = TeamViewModel(team: team)

        XCTAssertEqual(viewModel.id, 100)
        XCTAssertEqual(viewModel.formattedDateTime, "Sun, 8 Sep 2019 3:30 AM")
        XCTAssertEqual(viewModel.imageUrl?.absoluteString, "https://www.google.com/noimage.png")
        XCTAssertEqual(viewModel.title, "My Team")
        XCTAssertEqual(viewModel.formattedLocation, "City 1, State 1")
        XCTAssertFalse(viewModel.isFavorited)
    }

}
