//
//  ExpensesView.swift
//  FinApp
//
//  Created by Alexey Lim on 20/6/24.
//

import UIKit

class ExpensesView: UIViewController {
    
    var dataList: [AddCellData] = []
    
    var expendsTabBarController: ExpensesTabBarController?
    
    lazy var expensesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(AddCell.self, forCellWithReuseIdentifier: AddCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        expendsTabBarController?.expendsTabBarControllerDelegate = self
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        expensesCollectionView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubview(expensesCollectionView)
        expensesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        expensesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 244).isActive = true
        expensesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        expensesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        expensesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ExpensesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.reuseId, for: indexPath) as! AddCell
        let item = dataList[indexPath.row]
        cell.setup(data: item)
        return cell
    }
    
    
}

extension ExpensesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension ExpensesView: ExpendsTabBarControllerDelegate {
    func didAddTap() {
        let alert = UIAlertController(title: "Расходы", message: "Добавьте расходы", preferredStyle: .alert)
        var amounTextField = UITextField()
        var titleTextField = UITextField()
        
        let acceptAction = UIAlertAction(title: "Да", style: .cancel) { action in
            self.dataList.append(AddCellData(title: titleTextField.text ?? "", amount: Int(amounTextField.text ?? "0") ?? 0))
            self.expensesCollectionView.reloadData()
            print(self.dataList)
        }
        
        let declineAction = UIAlertAction(title: "Нет", style: .default) { action in
            
        }
        
        alert.addTextField { textField in
            amounTextField = textField
            
        }
        alert.addTextField { textField in
            titleTextField = textField
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        present(alert, animated: true)
        
        
        
        
    }
}
