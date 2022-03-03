//
//  MenuViewController.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import UIKit
import SnapKit

// MARK: - Constants

fileprivate struct Constants {
    static let logoImageName = "logo"
    static let learnButtonTitle = "Учить"
    static let wordsButtonTitle = "Слова"
}

class MenuViewController: UIViewController {

    // MARK: - Properties
    
    private let logoImageView = UIImageView()
    private let buttonStackView = UIStackView()
    private let learnButton = UIButton()
    private let wordsButton = UIButton()
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        createLogoImageView()
        createButtons()
    }
    
    // MARK: - Func for create UI elements
    
    private func createLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: Constants.logoImageName)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height / 10)
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(view.frame.width / 2)
            make.centerX.equalToSuperview()
        }
    }
    
    private func createButtons() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(learnButton)
        buttonStackView.addArrangedSubview(wordsButton)
        
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = view.frame.height / 20
        
        learnButton.backgroundColor = .yellow
        learnButton.setTitle(Constants.learnButtonTitle, for: .normal)
        learnButton.setTitleColor(.black, for: .normal)
        learnButton.layer.cornerRadius = 10
        learnButton.layer.borderWidth = 3
        learnButton.addAction(UIAction(handler: { _ in self.selectGame()}), for: .touchUpInside)
        
        wordsButton.backgroundColor = .yellow
        wordsButton.setTitle(Constants.wordsButtonTitle, for: .normal)
        wordsButton.setTitleColor(.black, for: .normal)
        wordsButton.layer.cornerRadius = 10
        wordsButton.layer.borderWidth = 3
        wordsButton.addAction(UIAction(handler: { _ in self.pushToWords()}), for: .touchUpInside)
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height / 2)
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(view.frame.width - view.frame.width / 10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func selectGame() {
        navigationController?.pushViewController(SelectGameViewController(), animated: true)
    }
    
    private func pushToWords() {
        navigationController?.pushViewController(WordsViewController(), animated: true)
    }
    
    private func logOut() {
        if LoginService().logOut() {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                .changeRootViewController(SignUpViewController())
        } else {
            print("error")
        }
    }
}
