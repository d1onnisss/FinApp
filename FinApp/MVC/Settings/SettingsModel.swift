//
//  SettingsModel.swift
//  FinApp
//
//  Created by Alexey Lim on 17/6/24.
//

protocol SettingsModelProtocol: AnyObject {
    
}

class SettingsModel: SettingsModelProtocol {
    private weak var controller: SettingsControllerToModelProtocol?
    
    init(controller: SettingsControllerToModelProtocol) {
        self.controller = controller
    }
}
