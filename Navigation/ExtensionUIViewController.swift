//
//  ExtensionUIViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 03.06.2023.
//

import UIKit
import Foundation

extension UIViewController {

    func createTabButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return UIBarButtonItem(customView: button)
        
    }
}
