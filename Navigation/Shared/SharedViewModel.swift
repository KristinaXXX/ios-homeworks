//
//  SharedViewModel.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import CoreData
import Foundation
import UIKit

final class SharedViewModel {

    private let coordinator: SharedCoordinatorProtocol
    private let sharedService = SharedService.shared
    
    init(coordinator: SharedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
