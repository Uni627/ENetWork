//
//  TaskCategoryModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/12.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation
import SwiftyJSON

///条线
public class TaskCategoryModel: NSObject {
    public var ID: String?
    public var key: String?
    public var name: String?

    public var parentID: String?
    public var text: String?
    public var typeID: String?
    public var isParent: Bool = false
    public var childrens: [TaskCategoryModel] = []

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        childrens = [TaskCategoryModel]()
        let childrenArray = json["childrens"].arrayValue
        for childrenJson in childrenArray {
            let value = TaskCategoryModel(fromJson: childrenJson)
            childrens.append(value)
        }
        ID = json["id"].string
        key = json["key"].string
        name = json["name"].string
        parentID = json["parentId"].string
        typeID = json["typeId"].string
        text = json["text"].string
        isParent = json["isParent"].bool ?? false
    }
}

///条线下的二级分类
public class SubTaskCategoryModel: NSObject {
    public var ID: String?
    public var key: String?
    public var name: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        ID = json["id"].string
        key = json["key"].string
        name = json["name"].string
    }
}
