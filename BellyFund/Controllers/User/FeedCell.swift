//
//  FeedCell.swift
//  BellyFund
//
//  Created by Alex 6.1 on 12/16/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    var itemImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var itemDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0.3, alpha: 0.8)
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.image = UIImage(systemName: "person")
        image.tintColor = .white
        return image
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainItemImage()
        constrainItemDetail()
        contrainProfileImage()
        constrainNameLabel()
    }
    
    override func layoutSubviews() {
        profileImage.layer.cornerRadius = (profileImage.frame.size.width) / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrainItemImage() {
        contentView.addSubview(itemImage)
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: itemImage.frame.width),
            itemImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - 100)])
    }
    
    func constrainItemDetail() {
        contentView.addSubview(itemDetailView)
        itemDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDetailView.topAnchor.constraint(equalTo: itemImage.bottomAnchor),
            itemDetailView.leadingAnchor.constraint(equalTo: itemImage.leadingAnchor),
            itemDetailView.trailingAnchor.constraint(equalTo: itemImage.trailingAnchor),
            itemDetailView.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    func contrainProfileImage() {
        itemDetailView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: itemDetailView.topAnchor, constant: -20),
            profileImage.leadingAnchor.constraint(equalTo: itemDetailView.leadingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    func constrainNameLabel() {
        itemDetailView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: itemDetailView.topAnchor, constant: -20),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: itemDetailView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: itemDetailView.heightAnchor)])
    }
    
}
