//
//  BuildUnitHouseModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/19.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class BuildUnitHouseModel: NSObject {

    public var children: [BuildUnitHouseModel] = []
    public var code: String?
    public var id: String?
    public var level: Int?
    public var name: String?
    public var parentCode: String?
    public var parentID: Int?
    public var parentName: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        children = [BuildUnitHouseModel]()
        let childrenArray = json["children"].arrayValue
        for childrentJson in childrenArray {
            let value = BuildUnitHouseModel(fromJson: childrentJson)
            children.append(value)
        }
        code = json["code"].string
        id = json["id"].string
        level = json["level"].int
        name = json["name"].string
        parentCode = json["parentCode"].string
        parentID = json["parentId"].int
        parentName = json["parentName"].string
    }

}
