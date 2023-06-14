//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Custom elements
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var someButton: UIButton = {
        return createButton(title: "Some button", color: .systemBlue, selector: #selector(someButtonPressed(_:)))
    }()
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(profileHeaderView)
        view.addSubview(someButton)
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .lightGray
        setupConstraint()
    }
    
    func setupConstraint() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            someButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            someButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            someButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    // MARK: - Selectors
    
    @objc func someButtonPressed(_ sender: UIButton) {
        print("Some button's been pressed")
    
    }

}
