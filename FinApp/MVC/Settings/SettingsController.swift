//
//  SettingsController.swift
//  FinApp
//
//  Created by Alexey Lim on 17/6/24.
//

protocol SettingsControllerToViewProtocol: AnyObject {
    
}

protocol SettingsControllerToModelProtocol: AnyObject {
    
}

class SettingsController {
    
    private weak var view: SettingsViewProtocol?
    private var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
}

extension SettingsController: SettingsControllerToModelProtocol {
    
}

extension SettingsController: SettingsControllerToViewProtocol {
    
}
