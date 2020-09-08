//
//  CheckRecordResumeModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/11.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CheckRecordResumeModel: NSObject {

    public var checkContentID: String?
    ///点检内容名称
    public var checkName: String?
    public var checkProjectID: String?
    ///点检记录编码
    public var checkRecordCode: String?
    public var checkResult: Int?
    public var checkType: Int?
    public var createID: String?
    public var createName: String?
    public var createTime: String?
    public var endTime: String?
    public var ID: String?
    public var isDelete: Int?
    public var isPic: Int?
    ///是否异常（1为异常）
    public var isUnusual: Int?
    ///分期id
    public var massifID: String?
    ///分期名称
    public var massifName: String?
    public var objectID: String?
    public var objectName: String?
    public var picUrl: String?
    public var recordSource: String?
    public var remark: String?
    public var resourceName: String?
    ///对象位置
    public var specificLocation: String?
    public var startTime: String?
    public var updateID: String?
    public var updateTime: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        checkContentID = json["checkContentId"].string
        checkName = json["checkName"].string
        checkProjectID = json["checkProjectId"].string
        checkRecordCode = json["checkRecordCode"].string
        checkResult = json["checkResult"].int
        checkType = json["checkType"].int
        createID = json["createId"].string
        createName = json["createName"].string
        createTime = json["createTime"].string
        endTime = json["endTime"].string
        ID = json["id"].string
        isDelete = json["isDelete"].int
        isPic = json["isPic"].int
        isUnusual = json["isUnusual"].int
        massifID = json["massifId"].string
        massifName = json["massifName"].string
        objectID = json["objectId"].string
        objectName = json["objectName"].string
        picUrl = json["picUrl"].string
        recordSource = json["recordSource"].string
        remark = json["remark"].string
        resourceName = json["resourceName"].string
        specificLocation = json["specificLocation"].string
        startTime = json["startTime"].string
        updateID = json["updateId"].string
        updateTime = json["updateTime"].string
    }

    public override init() {
        super.init()
    }

    public func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if checkContentID != nil {
            dictionary["checkContentId"] = checkContentID
        }
        if checkName != nil {
            dictionary["checkName"] = checkName
        }
        if checkProjectID != nil {
            dictionary["checkProjectId"] = checkProjectID
        }
        if checkRecordCode != nil {
            dictionary["checkRecordCode"] = checkRecordCode
        }
        if checkResult != nil {
            dictionary["checkResult"] = checkResult
        }
        if checkType != nil {
            dictionary["checkType"] = checkType
        }
        if createID != nil {
            dictionary["createId"] = createID
        }
        if createName != nil {
            dictionary["createName"] = createName
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if endTime != nil {
            dictionary["endTime"] = endTime
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if isDelete != nil {
            dictionary["isDelete"] = isDelete
        }
        if isPic != nil {
            dictionary["isPic"] = isPic
        }
        if isUnusual != nil {
            dictionary["isUnusual"] = isUnusual
        }
        if massifID != nil {
            dictionary["massifId"] = massifID
        }
        if massifName != nil {
            dictionary["massifName"] = massifName
        }
        if objectID != nil {
            dictionary["objectId"] = objectID
        }
        if objectName != nil {
            dictionary["objectName"] = objectName
        }
        if picUrl != nil {
            dictionary["picUrl"] = picUrl
        }
        if recordSource != nil {
            dictionary["recordSource"] = recordSource
        }
        if remark != nil {
            dictionary["remark"] = remark
        }
        if resourceName != nil {
            dictionary["resourceName"] = resourceName
        }
        if specificLocation != nil {
            dictionary["specificLocation"] = specificLocation
        }
        if startTime != nil {
            dictionary["startTime"] = startTime
        }
        if updateID != nil {
            dictionary["updateId"] = updateID
        }
        if updateTime != nil {
            dictionary["updateTime"] = updateTime
        }
        return dictionary
    }
}
