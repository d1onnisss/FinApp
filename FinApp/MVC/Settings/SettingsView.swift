//
//  SettingsView.swift
//  FinApp
//
//  Created by Alexey Lim on 17/6/24.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: AnyObject {
    func clearAllData()
}

class SettingsView: UIViewController {
    
    private var controller: SettingsControllerToViewProtocol?
    
    private var settings: [Settings] = [
        Settings(image: "globe", title: "Выбрать язык", type: .descritpion, description: "русский"),
        Settings(image: "moon", title: "Темная тема", type: .withSwitch),
        Settings(image: "trash", title: "Очистить данные", type: .standart)
    ]
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .systemGray4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        controller = SettingsController(view: self)
        setupConstraints()
        
        let isDarkTheme = UserDefaults.standard.bool(forKey: "darkTheme")
        view.overrideUserInterfaceStyle = isDarkTheme ? .dark : .light
    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SettingsView: SettingsViewProtocol {
    func clearAllData() {
        let alert = UIAlertController(title: "Очистить данные", message: "Вы уверены, что хотите удалить все данные?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            CoreDataManager.shared.deleteAllData()
            // Optionally, notify the user or update the UI accordingly
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        let item = settings[indexPath.row]
        cell.setup(settings: item)
        cell.delegate = self
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        if setting.title == "Очистить данные" {
            clearAllData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension SettingsView: SettingsCellDelegate {
    func didSwitch(isOn: Bool) {
        UserDefaults.standard.setValue(isOn, forKey: "darkTheme")
        view.overrideUserInterfaceStyle = isOn ? .dark : .light
    }
}
