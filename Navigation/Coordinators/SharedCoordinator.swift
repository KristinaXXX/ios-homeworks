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
}

class SharedCoordinator: SharedCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    func showFail(text: String) {
        let alert = UIAlertController(title: "Fail", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
