//
//  LoginService.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import Foundation
import RealmSwift

class LoginService {
    private let db: DBManager = DBManagerImpl()
    
    func login(loginName: String, password: String) -> Bool {
        let users: [UserModel] = db.obtain()
        guard let user = users.first(where: { $0.login == loginName }) else { return false }
        if user.password == password {
            changeUserLogined(user: user, logined: true)
            return true
        }
        return false
    }
    
    func logOut() -> Bool {
        guard let user = getAuthUser() else { return false}
        changeUserLogined(user: user, logined: false)
        return true
    }
    
    func getAuthUser() -> UserModel? {
        let users: [UserModel] = db.obtain()
        return users.first(where: { $0.isLogined })
    }
    
    func userIsLogined() -> Bool {
        let users: [UserModel] = db.obtain()
        return users.contains(where: { $0.isLogined })
    }
    
    func changeUserLogined(user: UserModel, logined: Bool) {
        do {
            let realm = try Realm(
                configuration: .defaultConfiguration,
                queue: .none
            )
            try realm.write {
                user.isLogined = true
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
