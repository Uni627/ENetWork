//
//  TypeContainerModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/17.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TypeContainerModel: NSObject {

    public var children: [TypeContainerModel] = []
    public var id: String?
    public var isParent: Bool?
    public var key: String?
    public var name: String?
    public var open: Bool?
    public var parentID: String?
    public var text: String?
    public var typeID: String?

    public override init() {
        super.init()
    }
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        children = []
        id = json["id"].string
        isParent = json["isParent"].bool
        key = json["key"].string
        name = json["name"].string
        open = json["open"].bool
        parentID = json["parentId"].string
        text = json["text"].string
        typeID = json["typeId"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if children.count > 0 {
            dictionary["children"] = children
        }
        if id != nil {
            dictionary["id"] = id
        }
        if isParent != nil {
            dictionary["isParent"] = isParent
        }
        if key != nil {
            dictionary["key"] = key
        }
        if name != nil {
            dictionary["name"] = name
        }
        if open != nil {
            dictionary["open"] = open
        }
        if parentID != nil {
            dictionary["parentId"] = parentID
        }
        if text != nil {
            dictionary["text"] = text
        }
        if typeID != nil {
            dictionary["typeId"] = typeID
        }
        return dictionary
    }

}
