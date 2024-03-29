//
//  Produtc.swift
//  EasyNotes
//

import Foundation
import RealmSwift

@objcMembers class Notes: Object {
    @objc dynamic var notes = ""
    @objc dynamic var tag = ""
    @objc dynamic var dateCreated = ""
    @objc dynamic var updatedDate = ""
    @objc dynamic var expireDate = "" //By defualt we are giving empty string
    @objc dynamic var noteID = NSUUID().uuidString  // unique ID
    @objc dynamic var isBolded = false
    @objc dynamic var isItalic = false
    @objc dynamic var isUnderLine = false
    @objc dynamic var isZommedUp = false
    @objc dynamic var isZoomedLow = false
    override static func primaryKey() -> String? {
        return "noteID"
    }
}

