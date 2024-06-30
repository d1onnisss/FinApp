//
//  IncomesView.swift
//  FinApp
//
//  Created by Alexey Lim on 20/6/24.
//

import UIKit

class IncomesView: UIViewController {
    
    var dataList: [AccountingModel] = []
    var expendsTabBarController: ExpensesTabBarController?
    
    lazy var incomesCollectionView: UICollectionView = {
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
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataList = CoreDataManager.shared.fetchIncomes()
        incomesCollectionView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubview(incomesCollectionView)
        incomesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        incomesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 244).isActive = true
        incomesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        incomesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        incomesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension IncomesView: UICollectionViewDataSource {
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

extension IncomesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension IncomesView: ExpendsTabBarControllerDelegate {
    func didAddTap() {
        let alert = UIAlertController(title: "Доходы", message: "Добавьте доходы", preferredStyle: .alert)
        
        var amountTextField: UITextField!
        var titleTextField: UITextField!
        
        alert.addTextField { textField in
            amountTextField = textField
            textField.placeholder = "Введите сумму"
            textField.keyboardType = .decimalPad
        }
        
        alert.addTextField { textField in
            titleTextField = textField
            textField.placeholder = "Введите название"
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let amountText = amountTextField.text, !amountText.isEmpty,
                  let titleText = titleTextField.text, !titleText.isEmpty,
                  let amount = Double(amountText) else { return }
            
            let id = UUID()
            let date = Date()
            let category = "incomes"
            let image = "star"
            let color = "orange"
            
            CoreDataManager.shared.addAccounting(id: id, title: titleText, amount: amount, date: date, category: category, image: image, color: color)
            
            self.dataList = CoreDataManager.shared.fetchIncomes()
            self.incomesCollectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
