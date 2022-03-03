//
//  WordsService.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 2.03.22.
//

import Foundation
import SwiftSoup

class WordsService {
    private let dbManager: DBManager = DBManagerImpl()
    
    func parseWord() {
        let urlString = "https://studynow.ru/dicta/allwords"
        guard let myURL = URL(string: urlString) else {
            print("Error: \(urlString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
            do {
                let doc: Document = try SwiftSoup.parse(myHTMLString)
                do{
                    let link: Elements = try doc.select("table").select("tr")
                    link.forEach{word in
                        let model = WordModel()
                        model.en = "\(word.childNode(1))"
                            .replacingOccurrences(of: "<td>", with: "")
                            .replacingOccurrences(of: "</td>", with: "")
                        model.ru = "\(word.childNode(2))"
                            .replacingOccurrences(of: "<td>", with: "")
                            .replacingOccurrences(of: "</td>", with: "")
                        addWord(model: model)
                    }
                }
            } catch {
                print("error")
            }
        } catch {
            print("error")
        }
    }
    
    func addWord(model: WordModel) {
        dbManager.save(object: model)
    }
    
    func getWords() -> [WordModel] {
        return dbManager.obtain()
    }
    
    func checkWords() -> Bool {
        let words: [WordModel] = dbManager.obtain()
        return words.isEmpty
    }
    
    func getRandomWordForGame(typeGame: TypeGame) -> Words {
        let words: [WordModel] = dbManager.obtain()
        guard let word = words.randomElement() else { return Words(askedWord: "", asnwer: "", translates: []) }
        return Words(
            askedWord: word.en,
            asnwer: word.ru,
            translates: [
                word.ru,
                words.randomElement()?.ru ?? "empty",
                words.randomElement()?.ru ?? "empty",
                words.randomElement()?.ru ?? "empty"
            ].shuffled()
        )
    }
    
    func removeWord(model: WordModel) {
        dbManager.removeObject(object: model)
    }
}
