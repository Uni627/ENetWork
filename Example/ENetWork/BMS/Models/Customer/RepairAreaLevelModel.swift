//
//  RepairAreaLevelModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/17.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class RepairMajorLineModel: NSObject {

    public var key: String?
    public var name: String?

    public override init() {
        super.init()
    }
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        key = json["key"].string
        name = json["name"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if key != nil {
            dictionary["key"] = key
        }
        if name != nil {
            dictionary["name"] = name
        }
        return dictionary
    }
}

public class RepairExpandModel: NSObject {

    public var codeStr: String?
    public var linePosiKey: String?
    public var linePosiName: String?
    public var majorLine: RepairMajorLineModel?
    public var repairArea: String?

    public override init() {
        super.init()

    }
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        codeStr = json["code_str"].string
        linePosiKey = json["line_posi_key"].string
        linePosiName = json["line_posi_name"].string

        let tempMajorLine = json["majorLine"]
        if !tempMajorLine.isEmpty {
            majorLine = RepairMajorLineModel(fromJson: tempMajorLine)
        }
        repairArea = ""
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if codeStr != nil {
            dictionary["code_str"] = codeStr
        }
        if linePosiKey != nil {
            dictionary["line_posi_key"] = linePosiKey
        }
        if linePosiName != nil {
            dictionary["line_posi_name"] = linePosiName
        }
        if majorLine != nil {
            dictionary["majorLine"] = majorLine?.toDictionary()
        }
        if repairArea != nil {
            dictionary["repair_area"] = repairArea
        }
        return dictionary
    }
}

public class RepairAreaLevelModel: NSObject {

    public var categoryID: String?
    public var children: [RepairAreaLevelModel] = []
    ///数据key
    public var dataKey: String?
    ///数据name
    public var dataName: String?
    public var enabledFlag: String?
    public var expand: RepairExpandModel?
    public var id: String?
    public var parentID: String?
    public var sn: Int?

    public override init() {
        super.init()

    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        categoryID = json["categoryId"].string

        children = [RepairAreaLevelModel]()
        let childrenArray = json["children"].arrayValue
        for childrenJson in childrenArray {
            let value = RepairAreaLevelModel(fromJson: childrenJson)
            children.append(value)
        }

        dataKey = json["dataKey"].string
        dataName = json["dataName"].string
        enabledFlag = json["enabledFlag"].string

        let tempExpand = json["expand"]
        if !tempExpand.isEmpty {
            expand = RepairExpandModel(fromJson: tempExpand)
        }

        id = json["id"].string
        parentID = json["parentId"].string
        sn = json["sn"].int
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if categoryID != nil {
            dictionary["categoryId"] = categoryID
        }
        if children.count > 0 {
            dictionary["children"] = children
        }
        if dataKey != nil {
            dictionary["dataKey"] = dataKey
        }
        if dataName != nil {
            dictionary["dataName"] = dataName
        }
        if enabledFlag != nil {
            dictionary["enabledFlag"] = enabledFlag
        }
        if expand != nil {
            dictionary["expand"] = expand
        }
        if id != nil {
            dictionary["id"] = id
        }
        if parentID != nil {
            dictionary["parentId"] = parentID
        }
        if sn != nil {
            dictionary["sn"] = sn
        }
        return dictionary
    }

}
