//
//  NetworkUtility.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

protocol NetworkServiceable {
    func searchForTeamSchedule(with teamName: String, completionHandler: @escaping ([Team]) -> Void, errorHandler: @escaping (LoadError) -> Void)
}

final class NetworkUtility: NetworkServiceable {
    func searchForTeamSchedule(with teamName: String, completionHandler: @escaping ([Team]) -> Void, errorHandler: @escaping (LoadError) -> Void) {
        NetworkService.loadData(with: teamName, completionHandler: { teams in
            DispatchQueue.main.async {
                completionHandler(teams)
            }
        }) { error in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
}
