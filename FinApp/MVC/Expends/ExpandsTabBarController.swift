//
//  ExpandsTabBarController.swift
//  FinApp
//
//  Created by Alexey Lim on 20/6/24.
//

import UIKit

protocol ExpendsTabBarControllerDelegate: AnyObject {
    func didAddTap()
}

class ExpensesTabBarController: UITabBarController {
    
    private var expensesView = ExpensesView()
    
    private var incomesView = IncomesView()
    
    weak var expendsTabBarControllerDelegate: ExpendsTabBarControllerDelegate?
    
    private lazy var pageSegmentControl: UISegmentedControl = {
        let items = ["Расходы", "Доходы"]
        let view = UISegmentedControl(items: items)
        view.setTitle(items[0], forSegmentAt: 0)
        view.setTitle(items[1], forSegmentAt: 1)
        view.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        view.backgroundColor = .lightGray
        view.selectedSegmentTintColor = .systemBlue
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("+", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 60 / 2
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesView.expendsTabBarController = self
        viewControllers = [expensesView, incomesView]
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }
    
    @objc func segmentControlValueChanged() {
        if pageSegmentControl.selectedSegmentIndex == 0 {
            selectedIndex = 0
        } else {
            selectedIndex = 1
        }
    }
    
    @objc func addButtonTapped() {
        expendsTabBarControllerDelegate?.didAddTap()
    }
    
    private func setupConstraints() {
        view.addSubview(pageSegmentControl)
        pageSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        pageSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        pageSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        pageSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        pageSegmentControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
       
        
//        view.addSubview(expensesView.view)
//        expensesView.view.translatesAutoresizingMaskIntoConstraints = false
//        expensesView.view.topAnchor.constraint(equalTo: pageSegmentControl.bottomAnchor).isActive = true
//        expensesView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        expensesView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        expensesView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
