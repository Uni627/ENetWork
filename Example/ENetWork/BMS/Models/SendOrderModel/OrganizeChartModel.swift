//
//  OrganizeChartModel.swift
//  EServices
//
//  Created by pxy on 2019/11/5.
//

import Foundation
import SwiftyJSON

public class OrganizeChartModel: NSObject {

    public var code: String?
    public var demID: String?
    public var disabled: String? //权限判断 1 有权限 
    public var grade: String?
    public var ID: String?
    public var isDele: String?
    public var level: Int?
    public var name: String?
    public var orderNo: Int?
    public var parentID: String?
    public var path: String?
    public var pathName: String?
    public var refID: String?
    public var updateTime: String?
    public var version: Int?

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
        parentID = json["parentId"].string
        path = json["path"].string
        pathName = json["pathName"].string
        refID = json["refId"].string
        updateTime = json["updateTime"].string
        version = json["version"].int
    }
}
