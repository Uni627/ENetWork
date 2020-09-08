//
//  LineTypeModel.swift
//  EServices
//
//  Created by pxy on 2019/11/8.
//

import Foundation
import SwiftyJSON

public class LineTypeModel: NSObject {

    public var childrenArray: [LineTypeModel] = []  //子集
    public var children: [Any]?
    public var typeID: String?
    public var parentID: String?
    public var ID: String?
    public var open: Bool?
    public var text: String?
    public var key: String?
    public var isParent: Bool?
    public var name: String?

    public override init() {
        super.init()
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        //子集
        childrenArray = [LineTypeModel]()

        children = json["children"].arrayObject
        typeID = json["typeId"].string
        parentID = json["parentId"].string
        ID = json["id"].string
        open = json["open"].bool
        text = json["text"].string
        key = json["key"].string
        isParent = json["isParent"].bool
        name = json["name"].string
    }

     public func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if key != nil {
            dictionary["key"] = key
        }
        if text != nil {
            dictionary["text"] = text
        }

        return dictionary
    }

}
