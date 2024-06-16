//
//  HomeView.swift
//  FinApp
//
//  Created by Alexey Lim on 13/6/24.
//

import UIKit

class HomeView: UIViewController {
    
    private lazy var homeBottomView: HomeBottomView = {
        let view = HomeBottomView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var totalAmountLabel: UILabel = {
        let view = UILabel()
        view.text = "5000 Com"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 28/255, green: 89/255, blue: 255/255, alpha: 1)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(homeBottomView)
        homeBottomView.translatesAutoresizingMaskIntoConstraints = false
        homeBottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        homeBottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        homeBottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        homeBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(totalAmountLabel)
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        totalAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

class HomeBottomView: UIView {
    
    private var users: [User] = []
    private var analytics: [Analytics] = []
    
    private lazy var spendAnalysisLabel: UILabel = {
        let view = UILabel()
        view.text = "Spend analysis"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return view
    }()
    
    private lazy var previousLabel: UILabel = {
        let view = UILabel()
        view.text = "Previous"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return view
    }()
    
    private lazy var horizontalCV = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(CustomHorizontalCVCell.self, forCellWithReuseIdentifier: "horizontalCV")
        return view
    }()
    
    private lazy var verticalCV = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(CustomVerticalCVCell.self, forCellWithReuseIdentifier: "verticalCV")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(horizontalCV)
        addSubview(verticalCV)
        horizontalCV.translatesAutoresizingMaskIntoConstraints = false
        verticalCV.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalCV.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        horizontalCV.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        horizontalCV.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        horizontalCV.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        verticalCV.topAnchor.constraint(equalTo: horizontalCV.bottomAnchor, constant: 40).isActive = true
        verticalCV.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        verticalCV.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        verticalCV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(spendAnalysisLabel)
        spendAnalysisLabel.translatesAutoresizingMaskIntoConstraints
         = false
        spendAnalysisLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        spendAnalysisLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        addSubview(previousLabel)
        previousLabel.translatesAutoresizingMaskIntoConstraints = false
        previousLabel.topAnchor.constraint(equalTo: horizontalCV.bottomAnchor, constant: 10).isActive = true
        previousLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
    
    private func setupData() {
        users = [
        User(image: "cart", title: "Products"),
        User(image: "book", title: "Education"),
        User(image: "cup.and.saucer", title: "Food"),
        User(image: "beach.umbrella", title: "Relax"),
        User(image: "sportscourt", title: "Sport")
        ]
        
        analytics = [
            Analytics(image: "cart", title: "Products", subtitle: "This month you spent 4320 Com on products."),
            Analytics(image: "book", title: "Education", subtitle: "This month you spent 6790 Com on education."),
            Analytics(image: "cup.and.saucer", title: "Food", subtitle: "This month you spent 3500 Com on food."),
            Analytics(image: "beach.umbrella", title: "Relax", subtitle: "This month you spent 4320 Com on 3000."),
            Analytics(image: "sportscourt", title: "Sport", subtitle: "This month you spent 4320 Com on 2500.")
        ]
    }
    
}

extension HomeBottomView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 && collectionView == horizontalCV {
            return 5
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 && collectionView == horizontalCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCV", for: indexPath) as! CustomHorizontalCVCell
            //cell.backgroundColor = .green
            cell.setCellData(image: users[indexPath.row].image, title: users[indexPath.row].title)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCV", for: indexPath) as! CustomVerticalCVCell
            //cell.backgroundColor = .purple
            cell.setCellData(image: analytics[indexPath.row].image, title: analytics[indexPath.row].title, subtitle: analytics[indexPath.row].subtitle)
            return cell
        }
    }
}

extension HomeBottomView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCV {
            return CGSize(width: frame.width / 3 - 10, height: frame.width / 3)
        } else {
            return CGSize(width: frame.width, height: frame.width / 4)
        }
    }
}
