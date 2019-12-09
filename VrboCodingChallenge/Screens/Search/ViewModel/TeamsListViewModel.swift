//
//  TeamsListViewModel.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

final class TeamsListViewModel {

    static let inputDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    static let outputDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
        return dateFormatter
    }()

    weak var view: SearchScreenViewController?
    let networkUtility: NetworkServiceable
    var viewModels: [TeamViewModel]
    var error: LoadError?

    init(networkUtility: NetworkServiceable) {
        self.networkUtility = networkUtility
        self.viewModels = []
    }

    func searchForTeamSchedule(with teamName: String) {
        networkUtility.searchForTeamSchedule(with: teamName, completionHandler: { [weak self] teams in
            guard let strongSelf = self else { return }
            strongSelf.viewModels = teams.map { TeamViewModel(team: $0) }
            strongSelf.error = nil
            strongSelf.view?.update(with: strongSelf.viewModels)
        }) { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.error = error
            strongSelf.viewModels = []
            strongSelf.view?.displayErrorMessage()
        }
    }

    func clearList() {
        viewModels = []
        view?.update(with: viewModels)
    }

    func triggerLoadingSpinner() {
        view?.displayLoadingSpinner()
    }
}

class TeamViewModel {
    let id: Int
    let formattedDateTime: String?
    let imageUrl: URL?
    let title: String
    let formattedLocation: String
    var isFavorited = false

    init(team: Team) {
        id = team.id
        if let inputDate = TeamsListViewModel.inputDateFormatter.date(from: team.dateTimeLocalString) {
            formattedDateTime = TeamsListViewModel.outputDateFormatter.string(from: inputDate)
        } else {
            formattedDateTime = nil
        }

        let imageUrlString = team.performers.compactMap { $0.image }.first

        if let urlString = imageUrlString {
            imageUrl = URL(string: urlString)
        } else {
            imageUrl = nil
        }

        title = team.title
        formattedLocation = "\(team.venue.city), \(team.venue.state)"
    }
}
