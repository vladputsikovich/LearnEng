//
//  DBManager.swift
//  LearnEng
//
//  Created by Владислав Пуцыкович on 28.02.22.
//

import Foundation
import RealmSwift

protocol DBManager {
    func save<T: Object>(object: T)
    func removeObject<T: Object>(object: T)
    func obtain<T: Object>() -> [T]
    func clearAll()
}

class DBManagerImpl: DBManager {
    
    fileprivate var realm: Realm {
        get {
            do {
                let realm = try Realm(
                  configuration: .defaultConfiguration,
                  queue: .none
                )
                return realm
            } catch let error as NSError {
                print(error)
            }
            return self.realm
        }
    }
    
    func save<T: Object>(object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func removeObject<T: Object>(object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func clearAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func obtain<T: Object>() -> [T] {
        let models = realm.objects(T.self)
        return Array(models)
    }
}

