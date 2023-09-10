//
//  CustomButton.swift
//  Navigation
//
//  Created by Kr Qqq on 10.09.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    private let buttonAction: ((_ sender: UIButton) -> Void)?
    
    init(title: String, buttonAction: @escaping ((_ sender: UIButton) -> Void)) {
        
        self.buttonAction = buttonAction
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        backgroundColor = UIColor(named: "mainColor") ?? .lightGray
        setTitleColor(.white, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // call closure
        buttonAction?(sender)
    }

}
