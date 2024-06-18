//
//  ProfileView.swift
//  FinApp
//
//  Created by Alexey Lim on 13/6/24.
//

import UIKit

class ProfileView: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func settingsButtonTapped () {
        let settingsView = SettingsView()
        navigationController?.pushViewController(settingsView, animated: true)
    }
}
