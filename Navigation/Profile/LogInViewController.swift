//
//  LogInViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 14.06.2023.
//

import UIKit

class LogInViewController: UIViewController {

    private var userInfo = UserInfo()
    private let profileViewModel: ProfileViewModel
    var workItem: DispatchWorkItem?
    
    private var timer: Timer?
    
    // MARK: - Custom elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackUserData: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0.0
        
        stackView.tintColor = .lightGray
        
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        
        return stackView
    }()
    
    private lazy var stackButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16.0
        
        stackView.tintColor = .lightGray
        
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logoVk"))
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loginTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: 12.0, height: view.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = NSLocalizedString("Email or phone (Ivan)", comment: "")
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.delegate = self
        
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.addTarget(self, action: #selector(loginTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: 12.0, height: view.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = NSLocalizedString("Password", comment: "")
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(passwordTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var logInButton = CustomButton(title: NSLocalizedString("Log In", comment: ""), buttonAction: ( { self.logInButtonPressed() } ))
    private lazy var signUpButton = CustomButton(title: NSLocalizedString("Sign Up", comment: ""), buttonAction: ( { self.signUpButtonPressed() } ))
    private lazy var brutForceButton = CustomButton(title: NSLocalizedString("Brute force", comment: ""), buttonAction: ( { self.brutForceButtonPressed() } ))
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = .white
        return activity
    }()
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
        profileViewModel.signOut()
        //addTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: - Actions
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        let collisionHeight = scrollView.frame.height - (contentView.frame.height + (keyboardHeight ?? 0.0))
        if (collisionHeight < 0) {
            scrollView.contentInset.top = collisionHeight
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.top = 0.0
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        //setupConstraints()
        setupContentOfScrollView()
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupContentOfScrollView() {
 
        contentView.addSubview(logoImage)
        contentView.addSubview(stackUserData)
        contentView.addSubview(stackButtons)
        
        stackUserData.addArrangedSubview(loginTextField)
        stackUserData.addArrangedSubview(passwordTextField)
        
        stackButtons.addArrangedSubview(logInButton)
        stackButtons.addArrangedSubview(signUpButton)
            
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100.0),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackUserData.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 70.0),
            stackUserData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stackUserData.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stackUserData.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackButtons.topAnchor.constraint(equalTo: stackUserData.bottomAnchor, constant: 16.0),
            stackButtons.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stackButtons.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stackButtons.heightAnchor.constraint(equalToConstant: 100)
        ])

        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func addTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            self?.profileViewModel.rememberPassword(action: { _ in
                self?.loginTextField.text = "Ivan"
                self?.userInfo.login = "Ivan"
                self?.passwordTextField.text = "1gRt"
                self?.userInfo.password = "1gRt"
                self?.timer?.invalidate()
                self?.timer = nil
            })
        })
    }
    
    // MARK: - Selectors
    
    func logInButtonPressed() {
        profileViewModel.logIn(userInfo: userInfo)
    }
    func signUpButtonPressed() {
        profileViewModel.sighUp(userInfo: userInfo)
    }
    
    func brutForceButtonPressed() {
        
        guard profileViewModel.checkLogin(login: userInfo.login) else { return }
        
        brutForceButton.isEnabled = false
        
        let startTime = DispatchTime.now()
        let bruteForce = DispatchWorkItem {
            let foundPassword = self.profileViewModel.findPassword(login: self.userInfo.login)
            self.userInfo.password = foundPassword ?? ""
            let endTime = DispatchTime.now()
            print("Brute force: \(Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000) sec")
        }
        
        workItem = bruteForce
        
        activityIndicator.startAnimating()
        DispatchQueue.global().asyncAfter(deadline: .now(), execute: bruteForce)
        
        workItem?.notify(queue: .main, execute: {
            self.passwordTextField.text? = self.userInfo.password
            self.passwordTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
            self.brutForceButton.isEnabled = true
        })
    }
    
    @objc func loginTextChanged(_ textField: UITextField) {
        userInfo.login = textField.text ?? ""
    }
    
    @objc func passwordTextChanged(_ textField: UITextField) {
        userInfo.password = textField.text ?? ""
    }
    
    // MARK: - Keyboard
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }

}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
