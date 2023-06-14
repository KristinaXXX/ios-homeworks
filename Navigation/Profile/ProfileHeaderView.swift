//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Kr Qqq on 07.06.2023.
//

import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String = "Waiting for something..."
    
    // MARK: - Custom elements
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "avatarImage"))
        image.layer.cornerRadius = 55.0
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
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
        return textField
    }()
    
    // MARK: - UI Loading
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(fullNameLabel)
        addSubview(profileImage)
        addSubview(statusLabel)
        addSubview(showButton)
        addSubview(statusTextField)
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            fullNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16.0),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            profileImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            profileImage.heightAnchor.constraint(equalToConstant: 110.0),
            profileImage.widthAnchor.constraint(equalToConstant: 110.0),
            showButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            showButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 40.0),
            showButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            showButton.heightAnchor.constraint(equalToConstant: 50.0),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16.0),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40.0),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            statusTextField.bottomAnchor.constraint(equalTo: showButton.topAnchor, constant: -16.0)
        ])
    }
    
    // MARK: - Selectors
    
    @objc func buttonPressed(_ sender: UIButton) {
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }

}
