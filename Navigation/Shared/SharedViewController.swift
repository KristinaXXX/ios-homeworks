//
//  SharedViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import Foundation
import UIKit

final class SharedViewController: UIViewController {
    
    private let viewModel: SharedViewModel
    
    static var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        
        return tableView
    }()
    
    private lazy var filterBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "plus.magnifyingglass", selector: #selector(filterBarButtonPressed(_:)))
    }()
    
    private lazy var cancelFilterBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "minus.magnifyingglass", selector: #selector(cancelFilterBarButtonPressed(_:)))
    }()
    
    init(viewModel: SharedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Self.postsTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.cancelFilter {}
    }
    
    private func addSubviews() {
        view.addSubview(Self.postsTableView)
        view.backgroundColor = .white
        title = "Shared"
        
        navigationItem.rightBarButtonItems = [cancelFilterBarButtonItem, filterBarButtonItem]
    }
    
    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            Self.postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            Self.postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            Self.postsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            Self.postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        Self.postsTableView.dataSource = self
        Self.postsTableView.delegate = self
    }
    
    @objc func filterBarButtonPressed(_ sender: UIButton) {
        viewModel.setFilter {
            Self.postsTableView.reloadData()
        }
    }
    
    @objc func cancelFilterBarButtonPressed(_ sender: UIButton) {
        viewModel.cancelFilter {
            Self.postsTableView.reloadData()
        }
    }
}

extension SharedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension SharedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
        cell.update(viewModel.selectPost(selectRow: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deletePost(selectRow: indexPath.row) { _ in
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

}
