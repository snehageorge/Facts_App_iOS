//
//  FactTableViewCell.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit
import Kingfisher

class FactTableViewCell: UITableViewCell {

    var item:FactDetailResponseModel? {
        didSet {
            iconImageView.image = nil
            titleLabel.text = item?.title
            descriptionLabel.text = item?.description
            if let imageUrl = item?.imageHref {
                let url = URL(string: imageUrl)
                iconImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { [weak self] (image, err, cache, url) in
                    guard let self = self else { return }
                    if image == nil {
                        self.iconImageView.image = #imageLiteral(resourceName: "ImgNotFound")
                    }
                })
            }else {
                iconImageView.image = #imageLiteral(resourceName: "ImgNotFound")
            }
        }
    }

    private let iconImageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    private let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()

    private let descriptionLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: CellIdentifier.Fact)
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left:safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)

        iconImageView.anchor(top: titleLabel.safeAreaLayoutGuide.bottomAnchor, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 60, height: 60)
        titleLabel.heightGreaterThanOrEqualAnchor(height: 20)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.anchor(top: titleLabel.safeAreaLayoutGuide.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: iconImageView.safeAreaLayoutGuide.leftAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        descriptionLabel.heightGreaterThanOrEqualAnchor(height: 60)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
