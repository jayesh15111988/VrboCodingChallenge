//
//  SearchScreenViewController.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

final class SearchScreenViewController: UIViewController {
    private let tableView = UITableView()
    private let searchBarController = UISearchController(searchResultsController: nil)
    private let tableViewDataSource = TableViewDataSource()
    private let tableViewDelegate = TableViewDelegate()
    private let searchBarDelegate: SearchBarDelegate
    private let viewModel: TeamsListViewModel

    private enum Constants {
        static let searchBarFieldKey = "searchField"
    }

    private enum Colors {
        static let darkBlue = UIColor(red: 0.074, green: 0.176, blue: 0.259, alpha: 1.0)
    }

    init(viewModel: TeamsListViewModel) {
        self.searchBarDelegate = SearchBarDelegate(viewModel: viewModel)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        searchBarController.searchBar.delegate = searchBarDelegate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
    }

    private func setupViews() {

        // Associating tableviewDelegate with self to be able to perform the view transition
        tableViewDelegate.view = self

        // MARK: Search bar set up
        definesPresentationContext = true
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.tintColor = .white
        searchBarController.searchBar.barTintColor = .white
        searchBarController.searchBar.backgroundColor = Colors.darkBlue

        let searchBarTextField = searchBarController.searchBar.value(forKey: Constants.searchBarFieldKey) as? UITextField
        searchBarTextField?.textColor = .white

        // Mark: Setting up search bar on the navigation bar
        navigationItem.titleView = searchBarController.searchBar

        // MARK: Table view set up
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TeamDataTableViewCell.self, forCellReuseIdentifier: TeamDataTableViewCell.identifier)
        view.addSubview(tableView)
    }

    private func layoutViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func update(with viewModels: [TeamViewModel]) {
        tableViewDataSource.teamsViewModels = viewModels
        tableViewDelegate.teamsViewModels = viewModels
        tableView.reloadData()
    }

    func makeTransitionToDetailScreen(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
