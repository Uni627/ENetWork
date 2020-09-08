//
//  CustomerTypeModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/18.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CustomerMajorLineModel: NSObject {

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

public class CustomerTypeModel: NSObject {

    public var codeStr: String?
    public var dataKey: String?
    public var dataName: String?
    public var id: String?
    public var linePosiKey: String?
    public var linePosiName: String?
    public var majorLine: CustomerMajorLineModel?
    public var repairArea: String?

    public override init() {
        super.init()
    }
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        codeStr = json["code_str"].string
        dataKey = json["dataKey"].string
        dataName = json["dataName"].string
        id = json["id"].string
        linePosiKey = json["line_posi_key"].string
        linePosiName = json["line_posi_name"].string

        let tempMajorLine = json["majorLine"]
        if !tempMajorLine.isEmpty {
            majorLine = CustomerMajorLineModel(fromJson: tempMajorLine)
        }
        repairArea = ""
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if codeStr != nil {
            dictionary["code_str"] = codeStr
        }
        if dataKey != nil {
            dictionary["dataKey"] = dataKey
        }
        if dataName != nil {
            dictionary["dataName"] = dataName
        }
        if id != nil {
            dictionary["id"] = id
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
