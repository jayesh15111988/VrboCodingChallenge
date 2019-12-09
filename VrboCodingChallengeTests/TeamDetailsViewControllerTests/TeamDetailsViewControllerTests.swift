//
//  TeamDetailsViewControllerTests.swift
//  VrboCodingChallengeTests
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import VrboCodingChallenge

final class TeamDetailsViewControllerTests: XCTestCase {

    func testThatViewModelGetsCorrectlyAppliedToTeamDetailsViewControllerInDefaultState() {
        let viewModelForViewController = TeamViewModel(team: Team(id: 100, title: "My Team", venue: Venue(city: "Boston", state: "MA"), dateTimeLocalString: "2019-12-08T03:30:00", performers: []))
        let viewController = TeamDetailsViewController(viewModel: viewModelForViewController)
        viewController.applyViewModel()

        XCTAssertEqual(viewController.barButtonImageView.image, UIImage(named: "unfavorite"))
        XCTAssertEqual(viewController.title, "My Team")
        XCTAssertEqual(viewController.dateTimeLabel.text, "Sun, 8 Dec 2019 3:30 AM")
        XCTAssertEqual(viewController.locationDetailsLabel.text, "Boston, MA")

    }

    func testThatViewModelGetsCorrectlyAppliedToTeamDetailsViewControllerInFavoritedState() {
        let viewModelForViewController = TeamViewModel(team: Team(id: 100, title: "My Team 1", venue: Venue(city: "Brookline", state: "MA"), dateTimeLocalString: "2019-01-08T03:30:00", performers: []))
        viewModelForViewController.isFavorited = true
        let viewController = TeamDetailsViewController(viewModel: viewModelForViewController)
        viewController.applyViewModel()

        XCTAssertEqual(viewController.barButtonImageView.image, UIImage(named: "favorite"))
        XCTAssertEqual(viewController.title, "My Team 1")
        XCTAssertEqual(viewController.dateTimeLabel.text, "Tue, 8 Jan 2019 3:30 AM")
        XCTAssertEqual(viewController.locationDetailsLabel.text, "Brookline, MA")

    }

}
