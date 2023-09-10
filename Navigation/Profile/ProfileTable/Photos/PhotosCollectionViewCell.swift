//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Kr Qqq on 02.07.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
 
    static let id = "PhotosCollectionViewCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    private func addSubviews() {
        contentView.addSubview(photoImageView)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func update(_ photo: UIImage) {
        photoImageView.image = photo
    }
    
}
