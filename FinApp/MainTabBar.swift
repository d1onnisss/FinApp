//
//  MainTabBar.swift
//  FinApp
//
//  Created by Alexey Lim on 13/6/24.
//

import Foundation
import UIKit

protocol MainTabBarDelegate: AnyObject {
    func didTabButtonTapped(tag: Int)
}

class MainTabBar: UIView {
    
    private var images: [String] =  []
    
    weak var delegate: MainTabBarDelegate?
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setup(backgroundColor: UIColor, images: [String]) {
        self.images = images
        self.backgroundColor = backgroundColor
        
        for i in 0...images.count - 1 {
            let button = createButton(image: images[i])
            button.tag = i
            button.addTarget(self, action: #selector(tabButtontapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tabButtontapped(sender: UIButton) {
        delegate?.didTabButtonTapped(tag: sender.tag)
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

func createButton(image: String) -> UIButton {
    let view = UIButton(type: .system)
    view.setImage(UIImage(systemName: image), for: .normal)
    view.tintColor = .white
    return view
}
