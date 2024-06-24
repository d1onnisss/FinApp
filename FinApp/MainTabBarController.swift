//
//  MainTabBarController.swift
//  FinApp
//
//  Created by Alexey Lim on 13/6/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    private lazy var mainTabBar: MainTabBar = {
        let view = MainTabBar()
        view.setup(backgroundColor: .systemBlue, images: ["house", "plus.circle", "person"])
        view.layer.cornerRadius = 20
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.isHidden = true
        setupUI()
        configureViewController()
    }
    
    private func setupUI() {
        view.addSubview(mainTabBar)
        mainTabBar.translatesAutoresizingMaskIntoConstraints = false
        mainTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        mainTabBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        mainTabBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        mainTabBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func configureViewController() {
        let homeView = HomeView()
        let expenciesAddView = ExpensesTabBarController()
        let profileView = ProfileView()
        let vc1 = UINavigationController(rootViewController: homeView)
        homeView.title = "Home"
        let vc2 = UINavigationController(rootViewController: expenciesAddView)
        expenciesAddView.title = "Expends"
        let vc3 = UINavigationController(rootViewController: profileView)
        profileView.title = "Profile"
        viewControllers = [vc1, vc2, vc3]
    }
}

extension MainTabBarController: MainTabBarDelegate {
    func didTabButtonTapped(tag: Int) {
        selectedIndex = tag
    }
}
