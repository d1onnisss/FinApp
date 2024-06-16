//
//  CustomVerticalCVCell.swift
//  FinApp
//
//  Created by Alexey Lim on 16/6/24.
//

import UIKit

class CustomVerticalCVCell: UICollectionViewCell {
    
    private lazy var analyticImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "")
        view.tintColor = .black
        return view
    }()
    
    private lazy var analyticTitle: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    private lazy var analyticSubtitle: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.textColor = .black
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
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
        addSubview(analyticImage)
        analyticImage.translatesAutoresizingMaskIntoConstraints = false
        analyticImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        analyticImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        analyticImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        analyticImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        addSubview(analyticTitle)
        analyticTitle.translatesAutoresizingMaskIntoConstraints = false
        analyticTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        analyticTitle.leftAnchor.constraint(equalTo: analyticImage.rightAnchor, constant: 10).isActive = true
        
        addSubview(analyticSubtitle)
        analyticSubtitle.translatesAutoresizingMaskIntoConstraints = false
        analyticSubtitle.topAnchor.constraint(equalTo: analyticTitle.bottomAnchor, constant: 10).isActive = true
        analyticSubtitle.leftAnchor.constraint(equalTo: analyticImage.rightAnchor, constant: 10).isActive = true
        analyticSubtitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    func setCellData(image: String, title: String, subtitle: String) {
        analyticImage.image = UIImage(systemName: image)
        analyticTitle.text = title
        analyticSubtitle.text = subtitle
    }
}
