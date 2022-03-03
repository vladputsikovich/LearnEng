//
//  UserModel.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import Foundation
import RealmSwift

@objcMembers
class UserModel: Object {
    dynamic var userID = UUID().uuidString
    dynamic var email = String()
    dynamic var login = String()
    dynamic var password = String()
    dynamic var isLogined = Bool()

    override static func primaryKey() -> String? {
        return #keyPath(userID)
    }
}
