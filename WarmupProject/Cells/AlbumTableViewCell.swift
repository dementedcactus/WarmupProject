//
//  AlbumTableViewCell.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/27/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .clear
        return cv
    }()
    
    lazy var artistTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Artist Title"
        lb.textAlignment = .left
        lb.textColor = .white
        lb.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        lb.numberOfLines = 0
        lb.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return lb
    }()
    
    lazy var artistBannerPhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "3/3"
        lb.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "AlbumCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        artistTitleLabel.layer.cornerRadius = 4
        artistTitleLabel.layer.masksToBounds = true
        
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        contentView.addSubview(containerView)
        containerView.addSubview(artistBannerPhotoImage)
        containerView.addSubview(artistTitleLabel)
        
        //ARRAY MUST BE IN ORDER
        let albumCellObjects = [containerView, artistBannerPhotoImage, artistTitleLabel, releaseDateLabel] as [UIView]
        albumCellObjects.forEach {addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        let borderSpacing: CGFloat = 4
        NSLayoutConstraint.activate([
            //containerView
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: borderSpacing),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -borderSpacing),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: borderSpacing),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -borderSpacing),
            
            //eventBannerPhotoImageView
            artistBannerPhotoImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            artistBannerPhotoImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            artistBannerPhotoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            artistBannerPhotoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            //artistTitleLabel
            artistTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            artistTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            artistTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            artistTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            artistTitleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2),
            
            //releaseDateLabel
            releaseDateLabel.trailingAnchor.constraint(equalTo: artistTitleLabel.trailingAnchor, constant: -borderSpacing),
            releaseDateLabel.bottomAnchor.constraint(equalTo: artistTitleLabel.bottomAnchor, constant: -borderSpacing)
            ])
    }
}
