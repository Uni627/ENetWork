//
//  CheckRecordModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/11.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import ENetWork
import SwiftyJSON

public class ContentList: NSObject {
    ///点检内容名称
    public var checkContent: String?
    public var checkProjectID: String?
    ///点检结果(1数据：填写数据 2判断：填写0或者1 0为不合格 1为合格)
    public var checkResult: Double?
    ///点检类型 (1为数值范围 2为判断)
    public var checkType: Int?
    public var createID: String?
    public var createTime: String?
    public var ID: String?
    ///范围最大值
    public var maxVal: String?
    ///范围最小值
    public var minValue: String?
    ///点检结果( 判断：0为异常1为不异常）
    public var qualified: Int?
    public var remark: String?
    public var updateID: String?
    public var updateTime: String?

    init(fromJson json: JSON) {
        if json.isEmpty {
            return
        }

        checkContent = json["checkContent"].string
        checkProjectID = json["checkProjectId"].string
        checkResult = json["checkResult"].double
        checkType = json["checkType"].int
        createID = json["createId"].string
        createTime = json["createTime"].string
        ID = json["id"].string
        maxVal = json["maxVal"].string
        minValue = json["minValue"].string
        qualified = json["qualified"].int
        remark = json["remark"].string
        updateID = json["updateId"].string
        updateTime = json["updateTime"].string
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if checkContent != nil {
            dictionary["checkContent"] = checkContent
        }
        if checkProjectID != nil {
            dictionary["checkProjectId"] = checkProjectID
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
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if maxVal != nil {
            dictionary["maxVal"] = maxVal
        }
        if minValue != nil {
            dictionary["minValue"] = minValue
        }
        if qualified != nil {
            dictionary["qualified"] = qualified
        }
        if remark != nil {
            dictionary["remark"] = remark
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

public class CheckRecordModel: NSObject {
    public var key: String?
    public var parentID: String?
    public var cellDataType: Int = 0
    public var cellRow: Int = 0
    public var cellSection: Int = 0
    public var checkContentID: String?
    public var checkName: String?
    public var checkProjectID: String?
    public var checkRecordCode: String?
    public var checkResult: Int?
    public var checkType: Int?
    public var code: Int?
    public var contentList: [ContentList] = []
    public var createID: String?
    public var createName: String?
    public var createTime: String?
    public var endTime: String?
    public var ID: String?
    public var isPic: Int?
    public var isUnusual: Int?
    public var massifID: String?
    public var massifName: String?
    public var objectID: String?
    public var objectName: String?
    public var picUrl: String?
    public var picUrlArray: [PictureModel] = []  //图片 model 集合
    public var recordSource: String?
    public var remark: String?
    public var resourceName: String?
    public var results: [Any] = []
    public var specificLocation: String?
    public var startTime: String?
    public var updateID: String?
    public var updateTime: String?
    public var isDelete: String?
    public var recordResource: Int?

    init(fromJson json: JSON) {
        if json.isEmpty {
            return
        }
        checkContentID = json["checkContentId"].string
        checkName = json["checkName"].string
        checkProjectID = json["checkProjectId"].string
        checkRecordCode = json["checkRecordCode"].string
        checkResult = json["checkResult"].int
        checkType = json["checkType"].int
        code = json["code"].int
        contentList = [ContentList]()
        let contentListArray = json["contentList"].arrayValue
        for contentListJson in contentListArray {
            let value = ContentList(fromJson: contentListJson)
            contentList.append(value)
        }
        createID = json["createId"].string
        createName = json["createName"].string
        createTime = json["createTime"].string
        endTime = json["endTime"].string
        ID = json["id"].string
        isPic = json["isPic"].int
        isUnusual = json["isUnusual"].int
        massifID = json["massifId"].string
        massifName = json["massifName"].string
        objectID = json["objectId"].string
        objectName = json["objectName"].string

        picUrl = json["picUrl"].string
        picUrlArray = [PictureModel]() //图片集合
        let tempFiles = json["picUrl"].stringValue
        if let jsonData = tempFiles.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    picUrlArray.append(model)
                }
            }
        }

        recordSource = json["recordSource"].string
        remark = json["remark"].string
        resourceName = json["resourceName"].string
        specificLocation = json["specificLocation"].string
        startTime = json["startTime"].string
        updateID = json["updateId"].string
        updateTime = json["updateTime"].string
        isDelete = json["isDelete"].string
    }

    /*
     dic.updateValue(picUrl, forKey: "picUrl")
     dic.updateValue(remark, forKey: "remark")
     dic.updateValue(checkProjectId, forKey: "checkProjectId")
     dic.updateValue(massifId, forKey: "massifId")
     dic.updateValue(results, forKey: "results")
     dic.updateValue(createId, forKey: "createId")
     dic.updateValue(recordResource, forKey: "recordResource")
     */

    public init(picUrl: String, remark: String, checkProjectID: String, massifID: String, results: [Any], createID: String, recordResource: Int) {

        self.picUrl = picUrl
        self.remark = remark
        self.checkProjectID = checkProjectID
        self.massifID = massifID
        self.results = results
        self.createID = createID
        self.recordResource = recordResource
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
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
        if code != nil {
            dictionary["code"] = code
        }

        var dictionaryElements = [[String: Any]]()
        for contentListElement in contentList {
            dictionaryElements.append(contentListElement.toDictionary())
        }
        dictionary["contentList"] = dictionaryElements

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
        if results.count > 0 {
            dictionary["results"] = results
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
        if recordResource != nil {
            dictionary["recordResource"] = recordResource
        }

        return dictionary
    }
}
