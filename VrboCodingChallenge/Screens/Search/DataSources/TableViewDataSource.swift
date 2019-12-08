//
//  TableViewDataSource.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource {

    var teamsViewModels: [TeamViewModel] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamDataTableViewCell.identifier, for: indexPath) as? TeamDataTableViewCell else {
            fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `TeamDataTableViewCell`")
        }

        let viewModel = teamsViewModels[indexPath.row]
        cell.favoriteIconTapActionClosure = { [weak cell] in
            viewModel.isFavorited = !viewModel.isFavorited
            cell?.update(with: viewModel.isFavorited)
        }
        cell.apply(viewModel: viewModel)
        return cell
    }
}
