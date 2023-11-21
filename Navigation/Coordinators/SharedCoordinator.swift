//
//  SharedCoordinator.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import Foundation
import UIKit

protocol SharedCoordinatorProtocol {
    func showFail(text: String) 
    func showSetFilter(completion: @escaping () -> Void)
}

class SharedCoordinator: SharedCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    func showFail(text: String) {
        let alert = UIAlertController(title: "Fail", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showSetFilter(completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Search by author", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "Author"
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
            SharedService.shared.setFilter(value: alert.textFields![0].text ?? "") { _ in
                completion()
            }
        }))
        navigationController?.present(alert, animated: true)
    }
}
