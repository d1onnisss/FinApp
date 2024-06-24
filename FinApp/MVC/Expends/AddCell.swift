//
//  AddCell.swift
//  FinApp
//
//  Created by Alexey Lim on 20/6/24.
//

import UIKit

struct AddCellData {
    var title: String
    var amount: Int
}

class AddCell: UICollectionViewCell {
    
    static var reuseId = "add_cell"
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Shaurma"
        return view
    }()
    
    private lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.text = "200 c."
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .clear
    }
    
    func setup(data: AddCellData) {
        titleLabel.text = data.title
        amountLabel.text = String(data.amount) + "c."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
