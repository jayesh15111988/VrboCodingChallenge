//
//  TeamDetailsViewController.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit
import PINRemoteImage

final class TeamDetailsViewController: UIViewController {

    let viewModel: TeamViewModel

    private enum ImageNames: String {
        case favorite
        case unfavorite
        case placeholder
    }

    private enum Constants {
        static let horizontalPadding: CGFloat = 24.0
        static let verticalPadding: CGFloat = 24.0
        static let imageHeight: CGFloat = 230.0
        static let imageCornerRadius: CGFloat = 8.0
        static let favoriteIconWidth: CGFloat = 20.0
        static let favoriteIconHeight: CGFloat = 20.0
    }

    let barButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: Constants.favoriteIconWidth, height: Constants.favoriteIconHeight))
        return imageView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        return imageView
    }()

    let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    let locationDetailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    init(viewModel: TeamViewModel) {
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
        setupNavigationBar()
        applyViewModel()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(dateTimeLabel)
        view.addSubview(locationDetailsLabel)
    }

    private func layoutViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        locationDetailsLabel.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Constraints for `imageView`
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])

        // MARK: Constraints for `dateTimeLabel`
        NSLayoutConstraint.activate([
            dateTimeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.verticalPadding),
            dateTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            dateTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding)
        ])

        // MARK: Constraints for `locationDetailsLabel`
        NSLayoutConstraint.activate([
            locationDetailsLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: Constants.verticalPadding),
            locationDetailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            locationDetailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonImageView)
    }

    func applyViewModel() {
        title = viewModel.title
        barButtonImageView.image = viewModel.isFavorited ? UIImage(named: ImageNames.favorite.rawValue) : UIImage(named: ImageNames.unfavorite.rawValue)
        imageView.pin_setImage(from: viewModel.imageUrl, placeholderImage: UIImage(named: ImageNames.placeholder.rawValue))
        dateTimeLabel.text = viewModel.formattedDateTime
        locationDetailsLabel.text = viewModel.formattedLocation
    }
}
