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
        let post = postData[indexPath.row]
        
        let imageProvider = NSItemProvider(object: post.image as UIImage)
        let imageDragItem = UIDragItem(itemProvider: imageProvider)
        imageDragItem.localObject = post.image

        let descriptionProvider = NSItemProvider(object: post.description as NSString)
        let descriptionDragItem = UIDragItem(itemProvider: descriptionProvider)
        descriptionDragItem.localObject = post.description

        return [
            imageDragItem,
            descriptionDragItem
        ]
    }
}

extension ProfileViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // get from last row
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
         
        let rowInd = destinationIndexPath.row

        let group = DispatchGroup()

        var postDescription = String()
        group.enter()
        coordinator.session.loadObjects(ofClass: NSString.self) { objects in
            let uStrings = objects as! [String]
            for uString in uStrings {
                postDescription = uString
                break
            }
            group.leave()
        }

        var postImage = UIImage()
        group.enter()
        coordinator.session.loadObjects(ofClass: UIImage.self) { objects in
            let uImages = objects as! [UIImage]
            for uImage in uImages {
                postImage = uImage
                break
            }
            group.leave()
        }
             
        group.notify(queue: .main) {
            // delete moved post if moved
            if coordinator.proposal.operation == .move {
                //postData.remove(at: self.postDragAtIndex)
            }
            // insert new post
            let newPost = Post(author: self.user.fullName, description: postDescription, image: postImage, id: UUID())
            postData.insert(newPost, at: rowInd)
            
            tableView.reloadData()
        }
        

    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        guard session.items.count == 2 else {
            return UITableViewDropProposal(operation: .cancel)
        }

        if tableView.hasActiveDrag {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }

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
