//
//  SettingsCell.swift
//  FinApp
//
//  Created by Alexey Lim on 18/6/24.
//

import UIKit

enum SettingsType {
    case standart
    case withSwitch
    case descritpion
}

struct Settings {
    var image: String
    var title: String
    var type: SettingsType
    var description: String?
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitch(isOn: Bool)
}

class SettingsCell: UITableViewCell {

    static var reuseId = "settings_cell"
    
    weak var delegate: SettingsCellDelegate?
    
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        view.isOn = UserDefaults.standard.bool(forKey: "darkTheme")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged() {
        delegate?.didSwitch(isOn: switchView.isOn)
    }
    
    func setup(settings: Settings) {
        leftImageView.image = UIImage(systemName: settings.image)
        titleLabel.text = settings.title
        if settings.type != .withSwitch {
            switchView.isHidden = true
        }
    }
    
    private func setupConstraints() {
        addSubview(leftImageView)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leftImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        switchView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftImageView.rightAnchor, constant: 13).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: switchView.leftAnchor, constant: -13).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
