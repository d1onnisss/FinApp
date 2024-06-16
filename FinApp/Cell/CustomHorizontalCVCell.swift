//
//  CustomHorizontalCVCell.swift
//  FinApp
//
//  Created by Alexey Lim on 16/6/24.
//

import UIKit

class CustomHorizontalCVCell: UICollectionViewCell {
    
    private lazy var userImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "")
        view.tintColor = .black
        return view
    }()
    
    private lazy var userTitle: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.textColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        userImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(userTitle)
        userTitle.translatesAutoresizingMaskIntoConstraints = false
        userTitle.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10).isActive = true
        userTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setCellData(image: String, title: String) {
        userImage.image = UIImage(systemName: image)
        userTitle.text = title
    }
}
