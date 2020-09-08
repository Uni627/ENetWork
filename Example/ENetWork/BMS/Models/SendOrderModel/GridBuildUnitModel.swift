//
//  LocationModel.swift
//  EServices
//
//  Created by pxy on 2019/11/11.
//

import Foundation
import SwiftyJSON

public class BuildUnitModel: NSObject { //楼栋 或者 单元

    public var checked: Int?
    public var code: String?
    public var id: String?
    public var level: Int?
    public var name: String?
    public var parentID: String?
    public var feeAmount: Float = 0.0

    public var unitArray: [BuildUnitModel] = [] //单元 集合

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        checked = json["checked"].int
        code = json["code"].string
        id = json["id"].string
        level = json["level"].int
        name = json["name"].string
        parentID = json["parentId"].string

        unitArray = [BuildUnitModel]()
    }
}

public class GridBuildUnitModel: NSObject {

    public var createdBy: String?
    public var creationDate: String?
    public var divideID: String?
    public var divideName: String?
    public var enabledFlag: Int?
    public var endDate: String?
    public var formatAttribute: String?
    public var gridCode: String?
    public var gridName: String?
    public var gridRange: String?
    public var gridRemark: String?
    public var gridType: String?
    public var housekeeperID: String?
    public var housekeeperName: String?
    public var id: String?
    public var isDeleted: Int?
    public var projectID: String?
    public var projectName: String?
    public var rowVersion: String?
    public var secondFormatAttribute: String?
    public var startDate: String?
    public var thirdFormatAttribute: String?
    public var updateTimes: Int?
    public var updatedBy: String?
    public var updationDate: String?

    public var buildArray: [BuildUnitModel] = []  //所有的 楼栋 集合

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        createdBy = json["createdBy"].string
        creationDate = json["creationDate"].string
        divideID = json["divideId"].string
        divideName = json["divideName"].string
        enabledFlag = json["enabledFlag"].int
        endDate = json["endDate"].string
        formatAttribute = json["formatAttribute"].string
        gridCode = json["gridCode"].string
        gridName = json["gridName"].string
        gridRange = json["gridRange"].string
        gridRemark = json["gridRemark"].string
        gridType = json["gridType"].string
        housekeeperID = json["housekeeperId"].string
        housekeeperName = json["housekeeperName"].string
        id = json["id"].string
        isDeleted = json["isDeleted"].int
        projectID = json["projectId"].string
        projectName = json["projectName"].string
        rowVersion = json["rowVersion"].string
        secondFormatAttribute = json["secondFormatAttribute"].string
        startDate = json["startDate"].string
        thirdFormatAttribute = json["thirdFormatAttribute"].string
        updateTimes = json["updateTimes"].int
        updatedBy = json["updatedBy"].string
        updationDate = json["updationDate"].string

        buildArray = [BuildUnitModel]()

        var tempBuildArray = [BuildUnitModel]() //楼栋 集合
        var tempUnitArray = [BuildUnitModel]()  //单元 集合
        var tempHouseArray = [BuildUnitModel]() //房号 集合

        let tempGridRange = json["gridRange"].stringValue
        if let jsonData = tempGridRange.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = BuildUnitModel(fromJson: tempJson)
                    if model.level == 1 {//1 是楼栋
                        tempBuildArray.append(model)
                    }
                    if model.level == 2 {//2 是单元
                        tempUnitArray.append(model)
                    }
                    if model.level == 3 {
                        tempHouseArray.append(model)
                    }
                }
            }
        }

        for buildModel in tempBuildArray {//所有楼栋
            for unitModel in tempUnitArray {//所有单元
                if buildModel.id == unitModel.parentID {
                    for houseModel in tempHouseArray {
                        if unitModel.id == houseModel.parentID {
                            unitModel.unitArray.append(houseModel)
                        }
                    }
                    buildModel.unitArray.append(unitModel)
                }
            }
            buildArray.append(buildModel)
        }

    }

}
