//
//  RegistrationViewController.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import UIKit
import SnapKit

// MARK: - Constats

fileprivate struct Constants {
    static let navigationTitle = "Регистрация"
    static let loginTextFieldPlaceholder = "Логин"
    static let emailTextFieldPlaceholder = "Email"
    static let passwordTextFieldPlaceholder = "Пароль"
    static let applyButtonTitle = "Зарегистрироваться"
}

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let loginTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let applyButton = UIButton()
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
        self.title = Constants.navigationTitle
        createElements()
    }
    
    // MARK: - Func for create UI elements
    
    private func createElements() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(applyButton)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height / 20
        
        loginTextField.borderStyle = .roundedRect
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.cornerRadius = 5
        loginTextField.placeholder = Constants.loginTextFieldPlaceholder
        
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 5
        emailTextField.placeholder = Constants.emailTextFieldPlaceholder
        
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.placeholder = Constants.passwordTextFieldPlaceholder
        
        applyButton.backgroundColor = .yellow
        applyButton.layer.cornerRadius = 5
        applyButton.setTitle(Constants.applyButtonTitle, for: .normal)
        applyButton.setTitleColor(.black, for: .normal)
        applyButton.layer.borderWidth = 3
        applyButton.addAction(UIAction(handler: { _ in self.register() }), for: .touchUpInside)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height / 4)
            make.bottom.equalToSuperview().inset(view.frame.height / 4)
            make.left.equalToSuperview().inset(view.frame.height / 20)
            make.right.equalToSuperview().inset(view.frame.height / 20)
        }
    }
    
    private func register() {
        let model = UserModel()
        model.email = emailTextField.text ?? ""
        model.login = loginTextField.text ?? ""
        model.password = passwordTextField.text ?? ""
        model.isLogined = false
        
        let result = RegisterService().register(model: model)
        
        if result.0 {
            let alert = UIAlertController(title: "Успешно", message: result.1, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            let queue = DispatchQueue(label: "com.parse.words", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
            queue.async {
                if WordsService().checkWords() {
                    WordsService().parseWord()
                }
            }
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: result.1, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
