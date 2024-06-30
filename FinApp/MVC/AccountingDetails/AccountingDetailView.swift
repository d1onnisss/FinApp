//
//  AccountingDetailView.swift
//  FinApp
//
//  Created by Alexey Lim on 27/6/24.
//

import UIKit

enum AccountingDetailsType {
    case add
    case details
}

class AccountingDetailsView: UIViewController {
    
    var type: AccountingDetailsType?
    
    private let images: [String] = ["bus", "food", "palm", "bus", "food", "palm", "bus", "food", "palm", "bus", "food", "palm", "bus", "food", "palm", "bus", "food", "palm"]
    
    var accountingModel: AccountingModel?
    
    private lazy var amountTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Введите сумму"
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Введите название"
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(AccountingImageCell.self, forCellWithReuseIdentifier: AccountingImageCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var colorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Cохранить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
       // title = "Детали"
        if type == .details {
            let deleteBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
            navigationItem.rightBarButtonItem = deleteBarButtonItem
        }
        
        guard let accountingModel = accountingModel else {
            return
        }
        amountTextField.text = "\(accountingModel.amount)"
        titleTextField.text = accountingModel.title
    }
    
    @objc func deleteButtonTapped() {
        guard let accountingModel = accountingModel else {
            return
        }
        CoreDataManager.shared.deleteAccounting(id: accountingModel.id ?? UUID())
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        guard let accountingModel = accountingModel else {
            return
        }
        CoreDataManager.shared.updateAccounting(id: accountingModel.id ?? UUID(), amount: Double(amountTextField.text ?? "0") ?? 0, title: titleTextField.text ?? "", image: accountingModel.image ?? "")
        self.dismiss(animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(amountTextField)
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(imagesCollectionView)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imagesCollectionView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30).isActive = true
        imagesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        imagesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        imagesCollectionView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

extension AccountingDetailsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountingImageCell.reuseId, for: indexPath) as! AccountingImageCell
        let item = images[indexPath.row]
        cell.setup(image: item)
        return cell
    }
}

extension AccountingDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = images[indexPath.row]
        accountingModel?.image = item
    }
}
