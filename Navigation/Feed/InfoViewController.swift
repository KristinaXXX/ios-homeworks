//
//  InfoViewController.swift
//  Navigation
//
//  Created by Kr Qqq on 03.06.2023.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Custom elements
    
    private lazy var showAlertButton = CustomButton(title: "Show alert", buttonAction: ( { self.buttonPressed() } ))
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - UI Drawing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        //view.addSubview(showAlertButton)
        setupConstraints()
        loadData()
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        NSLayoutConstraint.activate([
            orbitalPeriodLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            orbitalPeriodLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            orbitalPeriodLabel.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    func loadData() {
        NetworkService.requestJSONSerialization(url: AppConfiguration.todos.url!, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    self?.titleLabel.text = title
                case .failure(let error):
                    print(error)
                }
            }
        })
        
        NetworkService.requestJSONDecoder(appConfiguration: .planets, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let planet):
                    if let planet = planet as? Planets {
                        self?.orbitalPeriodLabel.text = planet.orbitalPeriod
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
        
    }
    
    // MARK: - Selectors
    
    func buttonPressed() {
    
        let alert = UIAlertController(title: "Information", message: "More information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("alert - OK has pressed")
            }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in print("alert - cancel has pressed")
            }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
