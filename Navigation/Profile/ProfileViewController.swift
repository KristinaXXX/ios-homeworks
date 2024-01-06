//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit
import StorageService
import MobileCoreServices

class ProfileViewController: UIViewController {

    // MARK: - Custom elements
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var postsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        
        tableView.dragInteractionEnabled = true
        
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
        Self.postsTableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(Self.postsTableView)
        view.backgroundColor = .systemGray6
        Self.postsTableView.backgroundColor = .systemGray6
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
        
        Self.postsTableView.dragDelegate = self
        Self.postsTableView.dropDelegate = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return postData.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ProfileViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let cellData = postData[indexPath.row]
        let data = cellData.image.pngData()// .data(using: .utf8)
        let itemProvider = NSItemProvider()
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }
        
        let stringProvider = NSString(string: cellData.description)

        return [
            UIDragItem(itemProvider: itemProvider),
          //  UIDragItem(itemProvider: stringProvider)
        ]
    }
}

extension ProfileViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
            
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // Consume drag items.
            let stringItems = items as! [String]
            
            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                //let newPost = Post(author: user.fullName, image: UIImage(data: Data( item) id: UUID())
                //postData.append(<#T##newElement: Post##Post#>)
                //self.model.addItem(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }


            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
            
        // Accept only one drag item.
        guard session.items.count == 1 else { return dropProposal }
        
        // The .move drag operation is available only for dragging within this app and while in edit mode.
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            // Drag is coming from outside the app.
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }

        return dropProposal
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
            cell.update(postData[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.id) as! ProfileHeaderView
            headerView.update(user: user)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
    }
}
