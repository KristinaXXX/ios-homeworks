//
//  FeedViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 31.05.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    // MARK: - Custom elements    
    private lazy var showPost1 = CustomButton(title: "Post #1", buttonAction: ( { self.showPost("Post #1") } ))
    private lazy var showPost2 = CustomButton(title: "Post #2", buttonAction: ( { self.showPost("Post #2") } ))
    private lazy var checkGuessButton = CustomButton(title: "Check word", buttonAction: ( { self.checkWord()} ))
    
    private let feedModel = FeedModel()
    
    private lazy var checkWordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: 12.0, height: view.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = "Secret word"
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        return textField
    }()
    
    private lazy var stackFeeds: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(showPost1)
        stackView.addArrangedSubview(showPost2)
        stackView.addArrangedSubview(checkWordTextField)
        stackView.addArrangedSubview(checkGuessButton)
        return stackView
    }()

    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(stackFeeds)
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackFeeds.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            stackFeeds.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            stackFeeds.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
    
    // MARK: - Selectors
    
    func showPost(_ text: String) {
        let postViewController = PostViewController()
        postViewController.post = Post(author: text)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func checkWord() {
        checkWordTextField.endEditing(true)
        let result = feedModel.check(word: checkWordTextField.text ?? "")
        let alert = UIAlertController(title: "Check word", message: result ? "Right!" : "False! Try to enter 'word'", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))

        self.present(alert, animated: true, completion: nil)
    }
}


