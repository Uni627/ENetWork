//
//  LineDetailTypeModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/4.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class LineDetailTypeModel: NSObject {

    public var ID: String?
    public var typeKey: String?
    public var parentID: String?
    public var isLeaf: String?
    public var typeGroupKey: String?
    public var struType: Int?
    public var path: String?
    public var ownerID: String?
    public var createTime: String?
    public var children: [Any]?
    public var depth: Int?
    public var text: String?
    public var sn: Int?
    public var name: String?
    public var createBy: String?

    public override init() {
        super.init()

    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        children = json["children"].arrayObject

        ID = json["id"].string
        typeKey = json["typeKey"].string
        parentID = json["parentId"].string
        isLeaf = json["isLeaf"].string
        typeGroupKey = json["typeGroupKey"].string
        struType = json["struType"].int
        path = json["path"].string
        ownerID = json["ownerId"].string
        createTime = json["createTime"].string
        depth = json["depth"].int
        text = json["text"].string
        sn = json["sn"].int
        name = json["name"].string
        createBy = json["createBy"].string

    }
}
