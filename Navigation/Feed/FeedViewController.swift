//
//  FeedViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    // MARK: - Custom elements
    
    private lazy var showPost1: UIButton = {
        return createButton(title: "Post #1", color: .systemBlue, selector: #selector(showPost(_:)))
    }()
    private lazy var showPost2: UIButton = {
        return createButton(title: "Post #2", color: .systemBlue, selector: #selector(showPost(_:)))
    }()
    
    private lazy var stackFeeds: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(showPost1)
        stackView.addArrangedSubview(showPost2)
        return stackView
    }()

    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(stackFeeds)
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackFeeds.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            stackFeeds.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            stackFeeds.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    // MARK: - Selectors
    
    @objc func showPost(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.post = Post(author: sender.titleLabel?.text ?? "")
        navigationController?.pushViewController(postViewController, animated: true)
    }
}


