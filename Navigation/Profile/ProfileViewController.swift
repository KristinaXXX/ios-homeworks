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
        
        return view
    }()
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileHeaderView)
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.frame
    }

}
