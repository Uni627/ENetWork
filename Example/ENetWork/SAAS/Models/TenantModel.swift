//
//  TenantModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/25.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import SwiftyJSON

class TenantModel: NSObject {

    public var address: String?
    public var code: String?
    public var createTime: String?
    public var id: String?
    public var isDeleted: Bool = false
    public var isEnabled: Bool = false
    public var linkman: AnyObject?
    public var logo: String?
    public var name: String?
    public var phone: String?
    public var remark: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        isDeleted = json["isDeleted"].boolValue
        isEnabled = json["isEnabled"].boolValue
        address = json["address"].string
        code = json["code"].string
        createTime = json["createTime"].string
        id = json["id"].string
        logo = json["appLogo"].string
        name = json["name"].string
        phone = json["phone"].string
        remark = json["remark"].string

    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if code != nil {
            dictionary["code"] = code
        }
        if id != nil {
            dictionary["id"] = id
        }

        dictionary["isDeleted"] = isDeleted
        dictionary["isEnabled"] = isEnabled

        if logo != nil {
            dictionary["appLogo"] = logo
        }
        if name != nil {
            dictionary["name"] = name
        }
        return dictionary
    }
}
