//
//  ListTableViewCell.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

import Then
import Kingfisher
import SnapKit

final class ListTableViewCell: UITableViewCell {
    private let thumbnailImageView: AnimatedImageView = AnimatedImageView().then {
        $0.kf.indicatorType = .activity
    }
    private let nameLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureThumbnailImageView()
        configureNameLabel()
        configurePriceLabel()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func preFetchThumbnail(with url: URL) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
        thumbnailImageView.kf.setImage(with: url, options: [
            .processor(processor),
            .transition(.fade(0.2)),
            .cacheOriginalImage
        ])
    }

    func update(with metadata: ListMetadata) {
        nameLabel.text = metadata.name
        priceLabel.text = metadata.price
        preFetchThumbnail(with: metadata.thumbnailURL)
    }

    private func configureThumbnailImageView() {
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(thumbnailImageView.snp.width)
        }
    }
    private func configureNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.leading).offset(4)
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            $0.trailing.equalTo(thumbnailImageView.snp.trailing).inset(4)
        }
    }
    private func configurePriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(nameLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
