//
//  RealmManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    static func addEntity<T: Object>(object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .all)
                print("DEBUG: realm added")
            }
        } catch let error as NSError {
            print("RealmManager.addEntity: " + error.localizedDescription)
        }
        // print("DEBUG: realmファイル場所:: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }

    static func deleteOneObject<T: Object>(type: T.Type, id: String) {
        do {
            let realm = try Realm()
            let object = realm.objects(type.self).filter("id == '\(id)'")
            try realm.write {
                realm.delete(object)
                print("DEBUG: realm deleted")
            }
        } catch let error as NSError {
            print("RealmManager.deleteObject: " + error.localizedDescription)
        }
    }

    static func getEntityList<T: Object>(type: T.Type) -> Results<T>? {
        let realm = try? Realm()
        return realm?.objects(type.self)
    }
}
