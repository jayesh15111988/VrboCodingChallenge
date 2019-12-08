//
//  Team.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

struct TeamsList: Decodable {
    let teams: [Team]

    enum CodingKeys: String, CodingKey {
        case teams = "events"
    }
}

struct Team: Decodable {
    let id: Int
    let title: String
    let venue: Venue
    let dateTimeLocalString: String
    let performers: [Performers]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case venue
        case dateTimeLocalString = "datetime_local"
        case performers
    }
}

struct Venue: Decodable {
    let city: String
    let state: String
}

struct Performers: Decodable {
    let image: String?
}
