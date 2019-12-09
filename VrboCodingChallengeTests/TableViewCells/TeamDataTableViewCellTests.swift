//
//  TeamDataTableViewCellTests.swift
//  VrboCodingChallengeTests
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import VrboCodingChallenge

final class TeamDataTableViewCellTests: XCTestCase {
    func testThatViewModelIsCorrectlyAppliedToTableViewCellWhenInDefaultState() {
        let cell = TeamDataTableViewCell(style: .default, reuseIdentifier: nil)
        let cellViewModel = TeamViewModel(team: Team(id: 100, title: "My Team", venue: Venue(city: "Boston", state: "MA"), dateTimeLocalString: "2019-12-08T03:30:00", performers: []))

        cell.apply(viewModel: cellViewModel)

        XCTAssertEqual(cell.favoriteIconView.image(for: .normal), UIImage(named: "unfavorite"))
        XCTAssertEqual(cell.titleLabel.text, "My Team")
        XCTAssertEqual(cell.locationDetailsLabel.text, "Boston, MA")
        XCTAssertEqual(cell.dateTimeLabel.text, "Sun, 8 Dec 2019 3:30 AM")
    }

    func testThatViewModelIsCorrectlyAppliedToTableViewCellWhenInFavoritedState() {
        let cell = TeamDataTableViewCell(style: .default, reuseIdentifier: nil)
        let cellViewModel = TeamViewModel(team: Team(id: 100, title: "My Team 1", venue: Venue(city: "Chicago", state: "IL"), dateTimeLocalString: "2019-01-08T03:30:00", performers: []))
        cellViewModel.isFavorited = true

        cell.apply(viewModel: cellViewModel)

        XCTAssertEqual(cell.favoriteIconView.image(for: .normal), UIImage(named: "favorite"))
        XCTAssertEqual(cell.titleLabel.text, "My Team 1")
        XCTAssertEqual(cell.locationDetailsLabel.text, "Chicago, IL")
        XCTAssertEqual(cell.dateTimeLabel.text, "Tue, 8 Jan 2019 3:30 AM")
    }
}
