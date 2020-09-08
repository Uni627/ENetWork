//  获取分期--分期列表
//	SendAddressListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class SendAddressListModel: NSObject {

    public var code: String?
    public var demID: String?
    public var disabled: String?
    public var grade: String?
    public var ID: String?
    public var isDele: String?
    public var level: Int?
    public var name: String?
    public var orderNo: Int? //工单编号
    public var parentCode: String?
    public var parentID: String? //父类id
    public var path: String?
    public var pathName: String?
    public var refID: AnyObject?
    public var updateTime: String?
    public var version: Int?

    public var dimCode: String?
    public var dimName: String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        code = json["code"].string
        demID = json["demId"].string
        disabled = json["disabled"].string
        grade = json["grade"].string
        ID = json["id"].string
        isDele = json["isDele"].string
        level = json["level"].int
        name = json["name"].string
        orderNo = json["orderNo"].int
        parentCode = json["parentCode"].string
        parentID = json["parentId"].string
        path = json["path"].string
        pathName = json["pathName"].string
        refID = json["refId"].string as AnyObject?
        updateTime = json["updateTime"].string
        version = json["version"].int

        dimCode = json["dimCode"].string
        dimName = json["dimName"].string
    }

    public override init() {
        super.init()
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if code != nil {
            dictionary["code"] = code
        }
        if demID != nil {
            dictionary["demId"] = demID
        }
        if disabled != nil {
            dictionary["disabled"] = disabled
        }
        if grade != nil {
            dictionary["grade"] = grade
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if isDele != nil {
            dictionary["isDele"] = isDele
        }
        if level != nil {
            dictionary["level"] = level
        }
        if name != nil {
            dictionary["name"] = name
        }
        if orderNo != nil {
            dictionary["orderNo"] = orderNo
        }
        if parentCode != nil {
            dictionary["parentCode"] = parentCode
        }
        if parentID != nil {
            dictionary["parentId"] = parentID
        }
        if path != nil {
            dictionary["path"] = path
        }
        if pathName != nil {
            dictionary["pathName"] = pathName
        }
        if refID != nil {
            dictionary["refId"] = refID
        }
        if updateTime != nil {
            dictionary["updateTime"] = updateTime
        }
        if version != nil {
            dictionary["version"] = version
        }
        if dimCode != nil {
            dictionary["dimCode"] = dimCode
        }
        if dimName != nil {
            dictionary["dimName"] = dimName
        }

        return dictionary
    }
}
