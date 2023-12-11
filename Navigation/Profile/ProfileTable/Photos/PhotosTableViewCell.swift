//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Kr Qqq on 01.07.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    static let id = "PhotosTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Photos", comment: "")
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrow
    }()
    
    private lazy var stackPhotos: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        addImagesInStack(uiStack: stackView, count: 4)
        return stackView
    }()
    
    private func addImagesInStack(uiStack: UIStackView, count: Int) {
    
        let photosArray = Photos.make()
        for i in 0...count - 1 {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.clipsToBounds = true
            image.layer.cornerRadius = 6
            image.image = UIImage(named: photosArray[i].image)
            NSLayoutConstraint.activate([
                image.heightAnchor.constraint(equalTo: image.widthAnchor)
            ])
            uiStack.addArrangedSubview(image)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        addSubview(stackPhotos)
        addSubview(arrowImage)
        addSubview(titleLabel)
    }
    
    private func tuneView() {
        backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            stackPhotos.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackPhotos.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackPhotos.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackPhotos.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
