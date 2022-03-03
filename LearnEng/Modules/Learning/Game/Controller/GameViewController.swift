//
//  GameViewController.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 1.03.22.
//

import UIKit
import SnapKit

// MARK: - Constants

fileprivate struct Constants {
    static let navigationTitle = "Игра"
    static let closeButtonImageName = "close"
}

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    private var words = Words(askedWord: "", asnwer: "", translates: [])
    
    private let wordView = UIView()
    private let translatedWord = UILabel()
    private let result = UILabel()
    private let buttonsStackView = UIStackView()
    private let leftUp = UIButton()
    private let leftDown = UIButton()
    private let rightUp = UIButton()
    private let rightDown = UIButton()
    private let cancelButton = UIButton()
    
    private let typeGame: TypeGame
    
    private var countRight = 0
    private var countAllWords = 0
    
    // MARK: Init
    
    init(type: TypeGame) {
        self.typeGame = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configOf()
    }
    
    private func setup() {
        view.backgroundColor = .white
        self.title = Constants.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: Constants.closeButtonImageName),
            style: .plain,
            target: self,
            action: #selector(closeGame)
        )
        
        createWordView()
        createButtons()
    }
    
    private func createWordView() {
        view.addSubview(wordView)
        wordView.addSubview(translatedWord)
        wordView.addSubview(result)
        
        wordView.backgroundColor = .systemGray5
        wordView.layer.cornerRadius = 10
        
        translatedWord.textAlignment = .center
        translatedWord.font = .systemFont(ofSize: 25)
        
        wordView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height / 10)
            make.right.equalToSuperview().inset(view.frame.height / 20)
            make.left.equalToSuperview().inset(view.frame.height / 20)
            make.bottom.equalToSuperview().inset(view.frame.height / 2)
        }
        
        translatedWord.snp.makeConstraints { make in
            make.centerX.equalTo(wordView)
            make.centerY.equalTo(wordView)
            make.height.equalTo(view.frame.height / 10)
            make.width.equalTo(view.frame.width / 2)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(view.frame.height / 10)
            make.width.equalTo(view.frame.width / 5)
        }
    }
    
    private func createButtons() {
        view.addSubview(buttonsStackView)
        let horizontalUpStack = UIStackView()
        let horizontalDownStack = UIStackView()
        
        buttonsStackView.addArrangedSubview(horizontalUpStack)
        buttonsStackView.addArrangedSubview(horizontalDownStack)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = view.frame.height / 20
        
        horizontalUpStack.addArrangedSubview(leftUp)
        horizontalUpStack.addArrangedSubview(rightUp)
        horizontalUpStack.distribution = .fillEqually
        horizontalUpStack.axis = .horizontal
        horizontalUpStack.spacing = view.frame.height / 20
        
        horizontalDownStack.addArrangedSubview(leftDown)
        horizontalDownStack.addArrangedSubview(rightDown)
        horizontalDownStack.distribution = .fillEqually
        horizontalDownStack.axis = .horizontal
        horizontalDownStack.spacing = view.frame.height / 20
        
        leftUp.layer.cornerRadius = 10
        leftUp.backgroundColor = .yellow
        leftUp.layer.borderWidth = 2
        leftUp.setTitleColor(.black, for: .normal)
        leftUp.addAction(
            UIAction(
                handler: { _ in self.checkRight(sender: self.leftUp) }
            ), for: .touchUpInside
        )
        
        leftDown.layer.cornerRadius = 10
        leftDown.backgroundColor = .yellow
        leftDown.layer.borderWidth = 2
        leftDown.setTitleColor(.black, for: .normal)
        leftDown.addAction(
            UIAction(
                handler: { _ in self.checkRight(sender: self.leftDown) }
            ), for: .touchUpInside
        )
        
        rightUp.layer.cornerRadius = 10
        rightUp.backgroundColor = .yellow
        rightUp.layer.borderWidth = 2
        rightUp.setTitleColor(.black, for: .normal)
        rightUp.addAction(
            UIAction(
                handler: { _ in self.checkRight(sender: self.rightUp) }
            ), for: .touchUpInside
        )
        
        rightDown.layer.cornerRadius = 10
        rightDown.backgroundColor = .yellow
        rightDown.layer.borderWidth = 2
        rightDown.setTitleColor(.black, for: .normal)
        rightDown.addAction(
            UIAction(
                handler: { _ in self.checkRight(sender: self.rightDown) }
            ), for: .touchUpInside
        )
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height * 0.6)
            make.right.equalToSuperview().inset(view.frame.height / 20)
            make.left.equalToSuperview().inset(view.frame.height / 20)
            make.bottom.equalToSuperview().inset(view.frame.height / 20)
        }
    }
    
    private func configOf() {
        words = WordsService().getRandomWordForGame(typeGame: .en)
        translatedWord.text = words.askedWord
        result.text = "\(countRight) / \(countAllWords)"
        leftUp.setTitle(words.translates[0], for: .normal)
        leftUp.titleLabel?.numberOfLines = 0
        leftUp.sizeToFit()
        leftUp.backgroundColor = .yellow
        
        leftDown.setTitle(words.translates[1], for: .normal)
        leftDown.titleLabel?.numberOfLines = 0
        leftDown.sizeToFit()
        leftDown.backgroundColor = .yellow
        
        rightUp.setTitle(words.translates[2], for: .normal)
        rightUp.titleLabel?.numberOfLines = 0
        rightUp.sizeToFit()
        rightUp.backgroundColor = .yellow
        
        rightDown.setTitle(words.translates[3], for: .normal)
        rightDown.titleLabel?.numberOfLines = 0
        rightDown.sizeToFit()
        rightDown.backgroundColor = .yellow
    }
    
    private func changeColor(sender: UIButton, color: UIColor) {
        sender.backgroundColor = color
    }
    
    private func nextGame() {
        configOf()
    }
    
    private func checkRight(sender: UIButton) {
        if words.asnwer == sender.currentTitle {
            changeColor(sender: sender, color: .green)
            addCount(add: 1)
        } else {
            changeColor(sender: sender, color: .red)
            addCount(add: 0)
            view.subviews.forEach { stack in
                stack.subviews.forEach { horizont in
                    horizont.subviews.forEach { but in
                        guard let button = but as? UIButton else { return }
                        if button.titleLabel?.text == words.asnwer {
                            changeColor(sender: button, color: .green)
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.nextGame()
        })
    }
    
    private func addCount(add: Int) {
        countRight += add
        countAllWords += 1
    }
    
    @objc func closeGame() {
        navigationController?.popToRootViewController(animated: true)
    }
}
