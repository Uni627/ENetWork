//
//  DutiesModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/7.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DutiesModel: NSObject {

    public var code: String?
    public var createOrgID: String?
    public var descriptionField: String?
    public var enabled: Int?
    public var groupCode: String?
    public var groupId: String?
    public var ID: String?
    public var isDelete: String?
    public var name: String?
    public var orderNo: Int?
    public var params: String?
    public var parentID: String?
    public var path: String?
    public var version: Int?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        code = json["code"].string
        createOrgID = json["createOrgId"].string
        descriptionField = json["description"].string
        enabled = json["enabled"].int
        groupCode = json["groupCode"].string
        groupId = json["groupId"].string
        ID = json["id"].string
        isDelete = json["isDelete"].string
        name = json["name"].string
        orderNo = json["orderNo"].int
        params = json["params"].string
        parentID = json["parentId"].string
        path = json["path"].string
        version = json["version"].int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if code != nil {
            dictionary["code"] = code
        }
        if createOrgID != nil {
            dictionary["createOrgId"] = createOrgID
        }
        if descriptionField != nil {
            dictionary["description"] = descriptionField
        }
        if enabled != nil {
            dictionary["enabled"] = enabled
        }
        if groupCode != nil {
            dictionary["groupCode"] = groupCode
        }
        if groupId != nil {
            dictionary["groupId"] = groupId
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if isDelete != nil {
            dictionary["isDelete"] = isDelete
        }
        if name != nil {
            dictionary["name"] = name
        }
        if orderNo != nil {
            dictionary["orderNo"] = orderNo
        }
        if params != nil {
            dictionary["params"] = params
        }
        if parentID != nil {
            dictionary["parentId"] = parentID
        }
        if path != nil {
            dictionary["path"] = path
        }
        if version != nil {
            dictionary["version"] = version
        }
        return dictionary
    }

}
