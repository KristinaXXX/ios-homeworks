//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import UIKit
import StorageService

protocol FeedCoordinatorProtocol {
    func showCheckResult(result: Bool)
    func showPost(post: Post)
}

final class FeedCoordinator: FeedCoordinatorProtocol {
   
    var navigationController: UINavigationController?
    
    func showPost(post: StorageService.Post) {
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func showCheckResult(result: Bool) {
        let alert = UIAlertController(title: "Check word", message: result ? "Right!" : "False! Try to enter 'word'", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
