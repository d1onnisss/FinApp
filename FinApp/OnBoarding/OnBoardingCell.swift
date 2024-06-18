//
//  OnBoardingCell.swift
//  FinApp
//
//  Created by Alexey Lim on 18/6/24.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    private lazy var onBoardImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        view.textColor = .black
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        return view
    }()
    
    private lazy var dotsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "")
        return view
    }()
    
    private lazy var horizontalSV: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 10
        return view
    }()
    
    lazy var skipBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var nextBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 16
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
        addSubview(onBoardImage)
        onBoardImage.translatesAutoresizingMaskIntoConstraints = false
        onBoardImage.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        onBoardImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        onBoardImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        onBoardImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        onBoardImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: onBoardImage.bottomAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        
        addSubview(dotsImage)
        dotsImage.translatesAutoresizingMaskIntoConstraints = false
        dotsImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        dotsImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dotsImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        dotsImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(horizontalSV)
        horizontalSV.translatesAutoresizingMaskIntoConstraints = false
        horizontalSV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        horizontalSV.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        horizontalSV.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
//        horizontalSV.rightAnchor.constraint(equalTo: rightAnchor, constant: 50).isActive = true
        horizontalSV.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        horizontalSV.addArrangedSubview(skipBtn)
        horizontalSV.addArrangedSubview(nextBtn)
        
        skipBtn.widthAnchor.constraint(equalToConstant: 173).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: 173).isActive = true
    }
    
    func setCellData(image: String, title: String, subtitle: String, dotImage: String) {
        onBoardImage.image = UIImage(named: image)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        dotsImage.image = UIImage(named: dotImage)
    }
}


