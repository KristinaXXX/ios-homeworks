//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Kr Qqq on 07.06.2023.
//

import UIKit
import Foundation

class ProfileHeaderView: UITableViewHeaderFooterView {

    static let id = "ProfileHeaderView"
    private var statusText: String = NSLocalizedString("Waiting for something...", comment: "")
    private var profileImagePoint = CGPoint()
    
    // MARK: - Custom elements
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 55.0
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        addGestureRecognizer(tapImage)
        
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showButton = CustomButton(title: NSLocalizedString("Set status", comment: ""), buttonAction: ( { self.buttonPressed() } ))
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        textField.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: 12.0, height: self.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = NSLocalizedString("Set your status..", comment: "")
        
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.keyboardType = UIKeyboardType.default
        return textField
    }()
    
    private lazy var closeProfileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.backgroundColor = .clear
        button.contentMode = .scaleToFill
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeProfileImage), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profileBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .systemGray6
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    // MARK: - UI Loading
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(user: User) {
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
        profileImage.image = user.avatar
    }
    
    private func addSubviews() {
        addSubview(fullNameLabel)
        
        addSubview(statusLabel)
        addSubview(showButton)
        addSubview(statusTextField)
        
        addSubview(profileBackgroundView)
        addSubview(profileImage)
        addSubview(closeProfileImageButton)
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            profileImage.heightAnchor.constraint(equalToConstant: 110.0),
            profileImage.widthAnchor.constraint(equalToConstant: 110.0)
        ])
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27.0),
            fullNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16.0),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
           
        NSLayoutConstraint.activate([
            showButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            showButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 25.0), //40
            showButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            showButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])

        NSLayoutConstraint.activate([
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16.0),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            statusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40.0),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            statusTextField.bottomAnchor.constraint(equalTo: showButton.topAnchor, constant: -16.0)
        ])
        
        NSLayoutConstraint.activate([
            closeProfileImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeProfileImageButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: - Selectors
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
        statusTextField.endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    @objc private func didTapProfileImage() {
        profileImage.isUserInteractionEnabled = false
                
        ProfileViewController.postsTableView.isScrollEnabled = false
        ProfileViewController.postsTableView.tableHeaderView?.isUserInteractionEnabled = false
        ProfileViewController.postsTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
        ProfileViewController.postsTableView.cellForRow(at: IndexPath(row: 0, section: 1))?.isUserInteractionEnabled = false
        
        profileImagePoint = profileImage.center
        let scale = UIScreen.main.bounds.width / profileImage.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.profileImage.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - self.profileImagePoint.y)
            self.profileBackgroundView.isHidden = false
            self.profileBackgroundView.alpha = 0.8
            self.profileImage.layer.cornerRadius = 0
        } completion: { _ in UIView.animate(withDuration: 0.3) {
                self.closeProfileImageButton.alpha = 1
            }
        }
    }
    
    @objc private func closeProfileImage() {
        UIImageView.animate(withDuration: 0.5) {
            UIImageView.animate(withDuration: 0.5) {
                self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.profileImage.center = self.profileImagePoint
                self.closeProfileImageButton.alpha = 0
                self.profileBackgroundView.alpha = 0
                self.profileImage.layer.cornerRadius = 55
            }
        } completion: { _ in
            ProfileViewController.postsTableView.isScrollEnabled = true
            ProfileViewController.postsTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
            ProfileViewController.postsTableView.cellForRow(at: IndexPath(row: 0, section: 1))?.isUserInteractionEnabled = true
            self.profileImage.isUserInteractionEnabled = true
        }
    }

}
