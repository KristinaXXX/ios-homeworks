//
//  ProfileTableHeaderFooterView.swift
//  Navigation
//
//  Created by Kr Qqq on 16.06.2023.
//

import UIKit

class ProfileTableHeaderFooterView: UITableViewHeaderFooterView {

    static let id = "ProfileTableHeaderFooterView"
    // MARK: - Subviews
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func update(title: String) {
        //titleLabel.text = title
    }
    
    // MARK: - Private
    
    private func tuneView() {
        contentView.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        contentView.addSubview(profileHeaderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 230.0),
            profileHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }

}
