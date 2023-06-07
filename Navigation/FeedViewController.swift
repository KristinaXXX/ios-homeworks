//
//  FeedViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var showButton: UIButton = {
        return createButton(title: "Показать пост", color: .systemBlue, selector: #selector(buttonPressed(_:)))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(showButton)
        setupConstraint()
    }
    
    func setupConstraint() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            showButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            showButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            showButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            showButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
    
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Первый пост")
        navigationController?.pushViewController(postViewController, animated: true)
        
    }
}


