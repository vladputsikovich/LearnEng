//
//  RegisterService.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import Foundation

class RegisterService {
    private let db: DBManager = DBManagerImpl()
    
    func register(model: UserModel) -> (Bool, String) {
        db.save(object: model)
        return (true, "Пользователь зарегистрирован")
    }
}
