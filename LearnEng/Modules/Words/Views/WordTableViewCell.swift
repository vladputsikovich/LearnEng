//
//  WordTableViewCell.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 2.03.22.
//

import UIKit

struct Word {
    var en: String
    var ru: String
}

class WordTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let enLabel = UILabel()
    private let ruLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for create UI elements
    
    private func createLabels(){
        addSubview(enLabel)
        addSubview(ruLabel)
        
        enLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(200)
            make.bottom.equalToSuperview().inset(10)
        }
        
        ruLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(200)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Config
    
    func configOf(word: WordModel) {
        enLabel.text = word.en
        ruLabel.text = word.ru
    }

}
