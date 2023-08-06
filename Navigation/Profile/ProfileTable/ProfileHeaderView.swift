//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Kr Qqq on 07.06.2023.
//

import UIKit
import Foundation
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    static let id = "ProfileHeaderView"
    private var statusText: String = "Waiting for something..."
    private var profileImagePoint = CGPoint()
    
    // MARK: - Custom elements
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "avatarImage"))
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
        label.text = "Hipster Cat"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
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
        textField.placeholder = "Set your status.."
        
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

        profileImage.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(110)
            make.top.left.equalTo(self).offset(16)
        }
        
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(27)
            make.left.equalTo(profileImage.snp.right).offset(16)
            make.right.equalTo(self).offset(-16)
            make.height.equalTo(20)
        }
        
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(fullNameLabel)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        statusTextField.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(fullNameLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        showButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.top.equalTo(statusTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        closeProfileImageButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }
    }
    
    // MARK: - Selectors
    
    @objc func buttonPressed(_ sender: UIButton) {
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
