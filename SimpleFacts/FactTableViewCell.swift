//
//  FactTableViewCell.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import UIKit
import Kingfisher

class FactTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FactTableViewCell"
    
    var fact: Fact? {
        didSet {
            photoView.image = UIImage(named: "placeholder")
            photoView.kf.setImage(with: URL.init(string: fact?.imageHref ?? ""), placeholder: UIImage.init(named: "placeholder"))
            nameLabel.text = fact?.title ?? "default title"
            detailLabel.text = fact?.description ?? "default description"
        }
    }
    
    // MARK: - UI Elements
    
    private let dataView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let detailLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let photoView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, detailLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Constraint
    
    // Constraints for Compact and Regular Size classes
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    // Constraints for Compact Size classes
    private var compactConstraints: [NSLayoutConstraint] = []
    
    // Constraints for Regular Size classes
    private var regularConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Default methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoView.image = nil
//        photoView.cancelImageLoad()
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    private func setupViews() {
        selectionStyle = .none
        
        contentView.addSubview(dataView)
        dataView.addSubview(photoView)
        dataView.addSubview(stackView)
        
        dataView.translatesAutoresizingMaskIntoConstraints = false
        photoView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        dataView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        
        sharedConstraints.append(contentsOf: [
            photoView.topAnchor.constraint(equalTo: dataView.topAnchor, constant: 8),
            photoView.leftAnchor.constraint(equalTo: dataView.leftAnchor, constant: 8),
            
            stackView.rightAnchor.constraint(equalTo: dataView.rightAnchor, constant: -8)
        ])
        
        compactConstraints.append(contentsOf: [
            photoView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            photoView.rightAnchor.constraint(equalTo: dataView.rightAnchor, constant: -8),
            photoView.heightAnchor.constraint(equalTo: dataView.widthAnchor, multiplier: 0.5),
            
            stackView.leftAnchor.constraint(equalTo: dataView.leftAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: dataView.bottomAnchor, constant: -8)
        ])
        
        regularConstraints.append(contentsOf: [
            photoView.rightAnchor.constraint(equalTo: stackView.leftAnchor, constant: -8),
            photoView.widthAnchor.constraint(equalTo: dataView.widthAnchor, multiplier: 0.20),
            photoView.heightAnchor.constraint(equalTo: dataView.widthAnchor, multiplier: 0.20),
            photoView.bottomAnchor.constraint(lessThanOrEqualTo: dataView.bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: dataView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: dataView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Trait Changes
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }
    
    private func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
            // activating shared constraints
            NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    
}
