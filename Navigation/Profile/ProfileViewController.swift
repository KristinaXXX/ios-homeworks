//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    fileprivate let data = Post.make()
    // MARK: - Custom elements
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: ProfileTableHeaderFooterView.id)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        
        return tableView
    }()
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        postsTableView.indexPathsForSelectedRows?.forEach{ indexPath in
//            postsTableView.deselectRow(
//                at: indexPath,
//                animated: animated
//            )
//        }
//    }
    
    private func addSubviews() {
        view.addSubview(postsTableView)
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .lightGray
    }
    
    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
//        postsTableView.estimatedRowHeight = 100.0
        postsTableView.rowHeight = UITableView.automaticDimension

        if #available(iOS 15.0, *) {
            postsTableView.sectionHeaderTopPadding = 0.0
        }
    }

}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return data.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
            cell.update(data[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 230 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderFooterView.id) as! ProfileTableHeaderFooterView
            return headerView
        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            tableView.deselectRow(at: indexPath, animated: false)
//            navigationController?.pushViewController(PhotosViewController(), animated: true)
//        case 1:
//        default:
//        }

    }

}
