//
//  OnBoarding.swift
//  FinApp
//
//  Created by Alexey Lim on 18/6/24.
//

import UIKit

class OnBoarding: UIViewController {
    
    private var onBoard: [OnBoard] = []
    
    private lazy var onBoardingCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = false
        view.dataSource = self
        view.delegate = self
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: "horizontalCV")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        view.addSubview(onBoardingCV)
        onBoardingCV.translatesAutoresizingMaskIntoConstraints = false
        onBoardingCV.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        onBoardingCV.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        onBoardingCV.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        onBoardingCV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupData() {
        onBoard = [
            OnBoard(image: "image1", title: "Welcome on our FinApp", subtitle: "Welcome to FinApp – your new companion for tasks, goals, health – all in one place. Let's get started!", dots: "dots1"),
            OnBoard(image: "image2", title: "Welcome on our FinApp", subtitle: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals.", dots: "dots2"),
            OnBoard(image: "image3", title: "Welcome on our FinApp", subtitle: "You're fully equipped to dive into the world of FinApp. Remember, we're here to assist you every step of the way. Ready to start? Let's go!", dots: "dots3")
        ]
    }
    
    @objc private func skipBtnTapped() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func nextBtnTapped() {
        guard let indexPaths = onBoardingCV.indexPathsForVisibleItems.first,
              let currentCellIndex = onBoardingCV.indexPathsForVisibleItems.first?.row else {
            return
        }
        
        if currentCellIndex == onBoard.count - 1 {
            skipBtnTapped()
        } else {
            let nextIndex = IndexPath(row: currentCellIndex + 1, section: indexPaths.section)
            onBoardingCV.scrollToItem(at: nextIndex, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnBoarding: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCV", for: indexPath) as! OnBoardingCell
        cell.setCellData(image: onBoard[indexPath.row].image, title: onBoard[indexPath.row].title, subtitle: onBoard[indexPath.row].subtitle, dotImage: onBoard[indexPath.row].dots)
        cell.skipBtn.addTarget(self, action: #selector(skipBtnTapped), for: .touchUpInside)
        cell.nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        return cell
    }
}

extension OnBoarding: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
