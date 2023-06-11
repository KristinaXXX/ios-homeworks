//
//  PostViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?
    
    // MARK: - Custom elements
    
    private lazy var infoBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "info", selector: #selector(infobuttonPressed(_:)))
    }()
    
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        if post != nil {
            title = post!.title
        }

        navigationItem.rightBarButtonItems = [infoBarButtonItem]
    }
    
    
    // MARK: - Selectors
    
    @objc func infobuttonPressed(_ sender: UIButton) {
       
        let infoViewController = InfoViewController()

        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.modalPresentationStyle = .pageSheet
        present(infoViewController, animated: true)
    }

}
