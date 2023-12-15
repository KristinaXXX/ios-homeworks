//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 02.07.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    var photos: [UIImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.photoCollection.reloadData()
            }
        }
    }

    let imageProcessor = ImageProcessor()
   
    private lazy var photoCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.id)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    private func loadData() {
        
        Photos.makeImage(completion: { [weak self] result in
            switch result {
            case .success(let photosArray):
                self?.photos = photosArray
            case .failure(let error):
                var errorText = ""
                switch error {
                case .notFound:
                    errorText = NSLocalizedString("Resource is not found", comment: "")
                case .forbidden:
                    errorText = NSLocalizedString("Forbidden", comment: "")
                case .badRequest:
                    errorText = NSLocalizedString("Bad request", comment: "")
                }
                let alert = UIAlertController(title: NSLocalizedString("Load error", comment: ""), message: errorText, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
                self?.navigationController?.present(alert, animated: true, completion: nil)
            }
        })
        
    }
    
    private func addSubviews() {
        view.addSubview(photoCollection)
    }
    
    private func tuneView() {
        view.backgroundColor = .systemBackground
        title = NSLocalizedString("Photo Gallery", comment: "")
        
        photoCollection.dataSource = self
        photoCollection.delegate = self
        
        let startTime = DispatchTime.now()
        
        imageProcessor.processImagesOnThread(sourceImages: photos,
                                             filter: ColorFilter.noir,
                                             qos: QualityOfService.utility,
                                             completion: { (imagesCGArray: [CGImage?]) in
            self.photos = imagesCGArray.compactMap{ $0 }.map { UIImage(cgImage: $0) }
            let endTime = DispatchTime.now()
            print("utility \(Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000) sec")
        })
    }
    
    func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        cell.update(photos[indexPath.row])
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        let totalSpacing: CGFloat = 3 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 8)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 8,
            left: 8,
            bottom: 8,
            right: 8
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}
