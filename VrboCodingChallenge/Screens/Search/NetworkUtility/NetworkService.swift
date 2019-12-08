//
//  NetworkService.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

enum LoadError: Error {
    case invalidUrl
    case emptyData
    case malformedContent
}

final class NetworkService {

    private enum Constants {
        static let baseURLString = "https://api.seatgeek.com/2/events"
        static let clientToken = "MTk4MTEwMDR8MTU3NTgyMjA5Ni4wOA"
    }

    private enum Keys: String {
        case clientId = "client_id"
        case query = "q"
    }

    static func loadData(with searchTerm: String, completionHandler: @escaping ([Team]) -> Void, errorHandler: @escaping (LoadError) -> Void) {

        let queryItems = [URLQueryItem(name: Keys.clientId.rawValue, value: Constants.clientToken), URLQueryItem(name: Keys.query.rawValue, value: searchTerm)]
        let urlComponents = NSURLComponents(string: Constants.baseURLString)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            errorHandler(.invalidUrl)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                errorHandler(.emptyData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(TeamsList.self, from: data)
                completionHandler(data.teams)
            } catch let error {
                print(error.localizedDescription)
                errorHandler(.malformedContent)
            }
        }
        task.resume()
    }
}
