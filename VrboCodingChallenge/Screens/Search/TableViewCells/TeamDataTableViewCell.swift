//
//  TeamDataTableViewCell.swift
//  VrboCodingChallenge
//
//  Created by Jayesh Kawli on 12/8/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit
import PINRemoteImage

final class TeamDataTableViewCell: UITableViewCell {

    private enum ImageNames: String {
        case favorite
        case unfavorite
        case placeholder
    }

    private enum Constants {
        static let outerHorizontalPadding: CGFloat = 24.0
        static let outerVerticalPadding: CGFloat = 24.0
        static let innerVerticalPadding: CGFloat = 8.0
        static let imageWidth: CGFloat = 60.0
        static let imageHeight: CGFloat = 60.0
        static let favoritesIconHeight: CGFloat = 20.0
        static let favoritesIconWidth: CGFloat = 20.0
        static let imageCornerRadius: CGFloat = 8.0
        static let favoriteIconOffset: CGFloat = 8.0
    }

    var favoriteIconTapActionClosure: (() -> Void)?

    private let stadiumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        return imageView
    }()

    private let favoriteIconView: UIButton = {
        let button = UIButton()
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let locationDetailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutViews()
    }

    private func setupViews() {
        contentView.addSubview(stadiumImageView)
        contentView.addSubview(favoriteIconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationDetailsLabel)
        contentView.addSubview(dateTimeLabel)

        favoriteIconView.isUserInteractionEnabled = true
        favoriteIconView.addTarget(self, action: #selector(favoriteIconTapped), for: .touchUpInside)
    }

    private func layoutViews() {
        favoriteIconView.translatesAutoresizingMaskIntoConstraints = false
        stadiumImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Constraints for `favoriteIconImageView`
        NSLayoutConstraint.activate([
            stadiumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.outerVerticalPadding),
            stadiumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.outerHorizontalPadding),
            stadiumImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Constants.outerVerticalPadding),
            stadiumImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            stadiumImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])

        // MARK: Constraints for `stadiumImageView`
        NSLayoutConstraint.activate([
            favoriteIconView.topAnchor.constraint(equalTo: stadiumImageView.topAnchor, constant: -Constants.favoriteIconOffset),
            favoriteIconView.leadingAnchor.constraint(equalTo: stadiumImageView.leadingAnchor, constant: -Constants.favoriteIconOffset),
            favoriteIconView.widthAnchor.constraint(equalToConstant: Constants.favoritesIconWidth),
            favoriteIconView.heightAnchor.constraint(equalToConstant: Constants.favoritesIconHeight)
        ])

        // MARK: Constraints for `titleLabel`
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.outerVerticalPadding),
            titleLabel.leadingAnchor.constraint(equalTo: stadiumImageView.trailingAnchor, constant: Constants.outerHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.outerHorizontalPadding),
        ])

        // MARK: Constraints for `locationDetailsLabel`
        NSLayoutConstraint.activate([
            locationDetailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.innerVerticalPadding),
            locationDetailsLabel.leadingAnchor.constraint(equalTo: stadiumImageView.trailingAnchor, constant: Constants.outerHorizontalPadding),
            locationDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.outerHorizontalPadding),
        ])

        // MARK: Constraints for `dateTimeLabel`
        NSLayoutConstraint.activate([
            dateTimeLabel.topAnchor.constraint(equalTo: locationDetailsLabel.bottomAnchor, constant: Constants.innerVerticalPadding),
            dateTimeLabel.leadingAnchor.constraint(equalTo: stadiumImageView.trailingAnchor, constant: Constants.outerHorizontalPadding),
            dateTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.outerHorizontalPadding),
            dateTimeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Constants.outerVerticalPadding)
        ])

    }

    @objc private func favoriteIconTapped() {
        favoriteIconTapActionClosure?()
    }

    func apply(viewModel: TeamViewModel) {
        stadiumImageView.pin_setImage(from: viewModel.imageUrl, placeholderImage: UIImage(named: ImageNames.placeholder.rawValue))
        update(with: viewModel.isFavorited)
        titleLabel.text = viewModel.title
        locationDetailsLabel.text = viewModel.formattedLocation
        dateTimeLabel.text = viewModel.formattedDateTime
    }

    func update(with isFavorited: Bool) {
        let favoriteIconImage = isFavorited ? UIImage(named: ImageNames.favorite.rawValue) : UIImage(named: ImageNames.unfavorite.rawValue)
        favoriteIconView.setImage(favoriteIconImage, for: .normal)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        stadiumImageView.pin_cancelImageDownload()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ReuseableView {
    static var identifier: String { get }
}

extension TeamDataTableViewCell: ReuseableView {
    static var identifier: String {
        return String(describing: self)
    }
}
