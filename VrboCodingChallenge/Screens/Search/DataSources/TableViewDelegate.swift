//
//  TableViewDelegate.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

final class TableViewDelegate: NSObject, UITableViewDelegate {

    var teamsViewModels: [TeamViewModel] = []
    weak var view: SearchScreenViewController?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewModel = teamsViewModels[indexPath.row]

        let detailsViewController = TeamDetailsViewController(viewModel: viewModel)
        view?.makeTransitionToDetailScreen(with: detailsViewController)
    }
}
