//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 02.07.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    var photos: [UIImage] = Photos.makeImage() {
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
        
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    private func addSubviews() {
        view.addSubview(photoCollection)
    }
    
    private func tuneView() {
        view.backgroundColor = .systemBackground
        title = "Photo Gallery"
        
        photoCollection.dataSource = self
        photoCollection.delegate = self
        
        let startTime = DispatchTime.now()
        
        imageProcessor.processImagesOnThread(sourceImages: photos,
                                             filter: ColorFilter.noir,
                                             qos: QualityOfService.utility,
                                             completion: { (imagesCGArray: [CGImage?]) in
            self.photos = []
            for elementCG in imagesCGArray {
                if elementCG != nil {
                    self.photos.append(UIImage(cgImage: elementCG!))
                }
            }
            
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
