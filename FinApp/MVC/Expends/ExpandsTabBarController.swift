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
        view.selectedSegmentIndex = 0
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
        view.layer.cornerRadius = 30
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesView.expendsTabBarController = self
        incomesView.expendsTabBarController = self
        viewControllers = [expensesView, incomesView]
        selectedIndex = 0
        expendsTabBarControllerDelegate = expensesView
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }
    
    @objc func segmentControlValueChanged() {
        if pageSegmentControl.selectedSegmentIndex == 0 {
            selectedIndex = 0
            expendsTabBarControllerDelegate = expensesView
        } else {
            selectedIndex = 1
            expendsTabBarControllerDelegate = incomesView
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
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
