//
//  SelectGameViewController.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import UIKit

enum TypeGame: String {
    case en = "🇬🇧 ➡️ 🇷🇺"
    case ru = "🇷🇺 ➡️ 🇬🇧"
}

// MARK: Constants

fileprivate struct Constants {
    static let navigationTitle = "Выберите тип игры"
}

class SelectGameViewController: UIViewController {

    // MARK: - Properties
    
    private let buttonsStackView = UIStackView()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        self.title = Constants.navigationTitle
        createButtons()
    }
    
    // MARK: - Func for create UI elements
    
    private func createButtons() {
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(leftButton)
        buttonsStackView.addArrangedSubview(rightButton)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillEqually
        
        leftButton.setTitle(TypeGame.ru.rawValue, for: .normal)
        leftButton.addAction(
            UIAction(
                handler: { _ in self.pushToGame(type: TypeGame.ru) }
            ), for: .touchUpInside
        )
        leftButton.backgroundColor = .yellow
        leftButton.layer.cornerRadius = 10
        leftButton.layer.borderWidth = 3
        
        rightButton.setTitle(TypeGame.en.rawValue, for: .normal)
        rightButton.addAction(
            UIAction(
                handler: { _ in self.pushToGame(type: TypeGame.en) }
            ), for: .touchUpInside
        )
        rightButton.backgroundColor = .yellow
        rightButton.layer.cornerRadius = 10
        rightButton.layer.borderWidth = 3
        
        buttonsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(view.frame.height / 5)
            make.width.equalTo(view.frame.width - view.frame.width / 10)
        }
    }
    
    private func pushToGame(type: TypeGame) {
        navigationController?.pushViewController(
            GameViewController(type: type),
            animated: true
        )
    }
}
