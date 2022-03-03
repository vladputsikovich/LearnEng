//
//  WordModel.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 2.03.22.
//

import Foundation
import RealmSwift

@objcMembers
class WordModel: Object {
    dynamic var wordID = UUID().uuidString
    dynamic var en = String()
    dynamic var ru = String()

    override static func primaryKey() -> String? {
        return #keyPath(wordID)
    }
}
