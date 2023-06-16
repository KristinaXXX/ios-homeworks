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
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        postsTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            postsTableView.deselectRow(
                at: indexPath,
                animated: animated
            )
        }
    }
    
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
        postsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        postsTableView.register(ProfileTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: ProfileTableHeaderFooterView.id)
        postsTableView.estimatedRowHeight = 100.0
        postsTableView.rowHeight = UITableView.automaticDimension

        if #available(iOS 15.0, *) {
            postsTableView.sectionHeaderTopPadding = 0.0
        }
    }

}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.update(data[indexPath.row])
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        230
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderFooterView.id) as? ProfileTableHeaderFooterView else {
            return UIView()
        }

        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
