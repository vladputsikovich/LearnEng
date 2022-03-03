//
//  Words.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 1.03.22.
//

import Foundation


struct Words {
    var askedWord: String
    var asnwer: String
    var translates: [String]
}

class WordsGame {
    let words = [
        Words(askedWord: "time", asnwer: "время", translates: ["слон", "время", "стол", "кирпич"]),
        Words(askedWord: "elephant", asnwer: "слон", translates: ["слон", "часы", "ручка", "буква"]),
        Words(askedWord: "letter", asnwer: "буква", translates: ["огонь", "яма", "стол", "буква"]),
    ]
}
