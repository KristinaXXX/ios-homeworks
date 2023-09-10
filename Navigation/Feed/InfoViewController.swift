//
//  InfoViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 03.06.2023.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Custom elements
    
    private lazy var showAlertButton = CustomButton(title: "Show alert", buttonAction: ( { (b: UIButton) -> Void in self.buttonPressed(b) } ))
    
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(showAlertButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            showAlertButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            showAlertButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            showAlertButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            showAlertButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    // MARK: - Selectors
    
    @objc func buttonPressed(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "Information", message: "More information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("alert - OK has pressed")
            }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in print("alert - cancel has pressed")
            }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
