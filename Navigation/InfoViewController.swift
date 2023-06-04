//
//  InfoViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 03.06.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var showAlertButton: UIButton = {
        return createButton(title: "Показать alert", color: .systemBlue, selector: #selector(buttonPressed(_:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(showAlertButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        //привязка constraint
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
    
    @objc func buttonPressed(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "Информация", message: "Подробная информация", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("alert - OK has pressed")
            }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Отмена", comment: "Default action"), style: .default, handler: { _ in print("alert - cancel has pressed")
            }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
