//
//  SharedViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import CoreData
import Foundation
import UIKit

final class SharedViewController: UIViewController {
    
    private let viewModel: SharedViewModel
    private let sharedService = SharedService.shared
    
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
    
    private lazy var fetchResultController: NSFetchedResultsController<SharedPost> = {
        let request = SharedPost.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let fetchResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: sharedService.backgroundContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController
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
        initialFetch()
    }
    
    private func initialFetch() {
        try? fetchResultController.performFetch()
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
        let alert = UIAlertController(title: "Search by author", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "Author"
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak self] _ in
            self?.fetchResultController.fetchRequest.predicate = NSPredicate(format: "author CONTAINS %@", alert.textFields![0].text ?? "")
            self?.initialFetch()
            Self.postsTableView.reloadData()
        }))
        navigationController?.present(alert, animated: true)
    }
    
    @objc func cancelFilterBarButtonPressed(_ sender: UIButton) {
        fetchResultController.fetchRequest.predicate = nil
        initialFetch()
        Self.postsTableView.reloadData()
    }
}

extension SharedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension SharedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
        cell.update(fetchResultController.object(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sharedService.deletePost(post: fetchResultController.object(at: indexPath))
        }
    }
}

extension SharedViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        DispatchQueue.main.async {
            switch type {
            case .insert:
                guard let newIndexPath else { return }
                SharedViewController.postsTableView.insertRows(at: [newIndexPath], with: .automatic)
            case .delete:
                guard let indexPath else { return }
                SharedViewController.postsTableView.deleteRows(at: [indexPath], with: .fade)
            case .move:
                guard let indexPath,
                      let newIndexPath else { return }
                SharedViewController.postsTableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath else { return }
                SharedViewController.postsTableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                break
            }
        }
    }
}
