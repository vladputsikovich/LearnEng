//
//  WordsViewController.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 2.03.22.
//

import UIKit
import SnapKit

// MARK: - Constants

fileprivate struct Constants {
    static let cellIdentifacator = "wordCell"
    static let navigationTitle = "Слова"
}

class WordsViewController: UIViewController {

    // MARK: - Properties
    private let wordsTable = UITableView()
    
    // MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
        self.title = Constants.navigationTitle
        createTable()
    }
    
    // MARK: - Func to create UI elements
    
    private func  createTable() {
        view.addSubview(wordsTable)
        wordsTable.dataSource = self
        wordsTable.register(WordTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifacator)
        
        wordsTable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension WordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WordsService().getWords().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifacator,
            for: indexPath
        ) as? WordTableViewCell else { return UITableViewCell() }
        let word = WordsService().getWords()[indexPath.item]
        cell.configOf(word: word)
        return cell
    }
}
