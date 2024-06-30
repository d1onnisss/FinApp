//
//  AccountingImageCell.swift
//  FinApp
//
//  Created by Alexey Lim on 27/6/24.
//

import UIKit

class AccountingImageCell: UICollectionViewCell {
    
    static var reuseId = "accounting_image_cell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: String) {
        imageView.image = UIImage(named: image)
    }
    
    private func setupConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
