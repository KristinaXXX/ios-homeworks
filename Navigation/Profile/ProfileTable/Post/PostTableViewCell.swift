//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Kr Qqq on 15.06.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    static let id = "PostTableViewCell"
    private var post: Post?
    private var sharedPost: SharedPost?
    private var isSaved: Bool = false

    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTappedImage))
        tap.numberOfTapsRequired = 2
        image.addGestureRecognizer(tap)
        return image
    }()
    
    private lazy var likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        updateColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateColors()
    }
    
    private func updateColors() {
        backgroundColor = .defaultColor(lightMode: .white, darkMode: .black)
        postImage.backgroundColor = .defaultColor(lightMode: .white, darkMode: .black)
        authorLabel.textColor = .defaultColor(lightMode: .black, darkMode: .white)
        likeImage.backgroundColor = .defaultColor(lightMode: .white, darkMode: .black)
        likesLabel.textColor = .defaultColor(lightMode: .black, darkMode: .white)
        viewsLabel.textColor = .defaultColor(lightMode: .black, darkMode: .white)
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        contentView.addSubviews(authorLabel, postImage, descriptionLabel, likeImage, likesLabel, viewsLabel)
        self.selectionStyle = .default
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indent),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),

            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 250),
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: LayoutConstants.indent),

            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: LayoutConstants.indent),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),

            likeImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutConstants.indent),
            likeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            likeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutConstants.indent),
            likesLabel.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor, constant: LayoutConstants.leadingMargin),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutConstants.indent),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent)
        ])
    }
    
    // MARK: - Public
    
    func update(_ post: Post) {
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        postImage.image = UIImage(named: post.image)
        likesLabel.text = post.likes.numberOfLikes
        viewsLabel.text = post.views.numberOfViews
        isSaved = SharedService.shared.isSaved(post: post)
        likeImage.tintColor = isSaved ? .red : .black
        self.post = post
    }
    
    func update(_ post: SharedPost) {
        authorLabel.text = post.author
        descriptionLabel.text = post.description_
        if let postImageString = post.image {
            postImage.image = UIImage(named: postImageString)
        } else {
            postImage.image = UIImage()
        }
        likesLabel.text = post.likes.numberOfLikes
        viewsLabel.text = post.views.numberOfViews
        isSaved = true
        likeImage.tintColor = .red
        sharedPost = post
    }
    
    @objc func doubleTappedImage() {
        if !isSaved {
            SharedService.shared.savePost(post: post!)
            isSaved.toggle()
            likeImage.tintColor = isSaved ? .red : .black
        }
    }
}

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}
