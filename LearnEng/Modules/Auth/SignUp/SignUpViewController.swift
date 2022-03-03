//
//  SignUpViewController.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import UIKit
import SnapKit

// MARK: - Constants

fileprivate struct Constants {
    static let logoImageName = "logo"
    static let loginTextFieldPlaceholder = "Логин"
    static let passwordTextFieldPlaceholder = "Пароль"
    static let applyButtonTitle = "Войти"
    static let registerButtonTitle = "Зарегистрироваться"
}

class SignUpViewController: UIViewController {

    // MARK: - Properties
    
    private let logoImageView = UIImageView()
    
    private let textFieldsStackView = UIStackView()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let buttonsStackView = UIStackView()
    private let applyButton = UIButton()
    private let registerButton = UIButton()
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
        createLogoImageView()
        createTextFieldsStackView()
        createButtonsStackView()
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
    
    private func createTextFieldsStackView() {
        view.addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.distribution = .fillEqually
        textFieldsStackView.spacing = view.frame.height / 30
        textFieldsStackView.alignment = .fill
        
        loginTextField.placeholder = Constants.loginTextFieldPlaceholder
        loginTextField.borderStyle = .roundedRect
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.cornerRadius = 5
        
        passwordTextField.placeholder = Constants.passwordTextFieldPlaceholder
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height / 2)
            make.height.equalTo(view.frame.height / 6)
            make.width.equalTo(view.frame.width - view.frame.width / 6)
            make.centerX.equalToSuperview()
        }
    }
    
    private func createButtonsStackView() {
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(applyButton)
        buttonsStackView.addArrangedSubview(registerButton)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = view.frame.height / 30
        buttonsStackView.alignment = .fill
        
        applyButton.setTitle(Constants.applyButtonTitle, for: .normal)
        applyButton.backgroundColor = .gray
        applyButton.layer.cornerRadius = 5
        applyButton.layer.borderWidth = 3
        applyButton.setTitleColor(.black, for: .normal)
        applyButton.addAction(
            UIAction(
                handler: { _ in self.loginUser() }
            ), for: .touchUpInside
        )
        
        registerButton.setTitle(Constants.registerButtonTitle, for: .normal)
        registerButton.backgroundColor = .yellow
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 3
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.addAction(
            UIAction(
                handler: { _ in self.pushToRegistration() }
            ), for: .touchUpInside
        )
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height - view.frame.height / 4)
            make.height.equalTo(view.frame.height / 6)
            make.width.equalTo(view.frame.width - view.frame.width / 6)
            make.centerX.equalToSuperview()
        }
    }
    
    private func loginUser() {
        let result = LoginService().login(
            loginName: loginTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
        if result {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                .changeRootViewController(MenuViewController())
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Неверный логин и пароль", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func pushToRegistration() {
        navigationController?.pushViewController(
            RegistrationViewController(),
            animated: true
        )
    }
}
