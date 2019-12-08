//
//  SearchBarDelegate.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

final class SearchBarDelegate: NSObject, UISearchBarDelegate {

    let viewModel: TeamsListViewModel

    init(viewModel: TeamsListViewModel) {
        self.viewModel = viewModel
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchForTeamSchedule(with: searchText)
    }
}
