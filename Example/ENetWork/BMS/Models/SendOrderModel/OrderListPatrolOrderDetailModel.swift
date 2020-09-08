//
//  OrderListPatrolOrderDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/11.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PatrolOrderDetailMasterModel: NSObject {

    public var actualCompletionTime: String?//实际完成时间
    public var buildingID: String?
    public var buildingName: String?
    public var close: String?
    public var completionDeadLine: String?//完成截止时间
    public var creationDate: String?//工单创建时间
    public var buildDescription: String?
    public var duration: String?
    public var extStatus: String?
    public var files: String?
    public var filesArray: [PictureModel] = [] //附件 图片转model 集合
    public var floor: String?
    public var gridID: String?
    public var gridName: String?//网格
    public var inspectionWorkGuidanceID: String?
    public var inspectionWorkGuidanceName: String?//工作指导
    public var inspectionWorkPlanID: String?
    public var inspectionWorkPlanName: String?//计划名称
    public var isTimeOut: Int?//是否超时
    public var lineID: String?
    public var lineName: String?//条线
    public var massifID: String?
    public var massifName: String?//分期
    public var patrolLineID: String?
    public var patrolLineName: String?
    public var planWorkOrderCode: String?//工单编号
    public var planWorkOrderState: Int?//判断状态2，3 处理中，4已关闭，1新生成
    public var principalID: String?
    public var principalName: String?
    public var processingDate: String?
    public var processingInstructions: String?//处理说明
    public var processingPersonID: String?
    public var processingPersonName: String?//工单处理人
    public var processingTime: String?
    public var projectID: String?
    public var projectName: String?
    public var realDuration: String?
    public var typeID: String?
    public var typeName: String?//分类
    public var unitID: String?
    public var unitName: String?
    public var configType: String?
    public var houseCode: String?
    public var lineCode: String?
    public var ID: String?
    public var refID: String?
    public var isSort: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        actualCompletionTime = json["fActualCompletionTime"].string
        buildingID = json["fBuildingId"].string
        buildingName = json["fBuildingName"].string
        close = json["fClose"].string
        completionDeadLine = json["fCompletionDeadline"].string
        creationDate = json["fCreationDate"].string
        buildDescription = json["fDescription"].string
        duration = json["fDuration"].string
        extStatus = json["fExtStatus"].string

        files = json["fFiles"].string
        filesArray = [PictureModel]() //图片集合
        let tempFiles = json["fFiles"].stringValue
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
                    filesArray.append(model)
                }
            }
        }

        floor = json["fFloor"].string
        gridID = json["fGridId"].string
        gridName = json["fGridName"].string
        inspectionWorkGuidanceID = json["fInspectionWorkGuidanceId"].string
        inspectionWorkGuidanceName = json["fInspectionWorkGuidanceName"].string
        inspectionWorkPlanID = json["fInspectionWorkPlanId"].string
        inspectionWorkPlanName = json["fInspectionWorkPlanName"].string
        isTimeOut = json["fIsTimeOut"].int
        lineID = json["fLineId"].string
        lineName = json["fLineName"].string
        massifID = json["fMassifId"].string
        massifName = json["fMassifName"].string
        patrolLineID = json["fPatrolLineId"].string
        patrolLineName = json["fPatrolLineName"].string
        planWorkOrderCode = json["fPlanWorkOrderCode"].string
        planWorkOrderState = json["fPlanWorkOrderState"].int
        principalID = json["fPrincipalId"].string
        principalName = json["fPrincipalName"].string
        processingDate = json["fProcessingDate"].string
        processingInstructions = json["fProcessingInstructions"].string
        processingPersonID = json["fProcessingPersonId"].string
        processingPersonName = json["fProcessingPersonName"].string
        processingTime = json["fProcessingTime"].string
        projectID = json["fProjectId"].string
        projectName = json["fProjectName"].string
        realDuration = json["fRealDuration"].string
        typeID = json["fTypeId"].string
        typeName = json["fTypeName"].string
        unitID = json["fUnitId"].string
        unitName = json["fUnitName"].string
        configType = json["fconfigType"].string
        houseCode = json["fhouseCode"].string
        lineCode = json["flineCode"].string
        ID = json["id"].string
        isSort = json["isSort"].string
        refID = json["refId"].string
    }
}

public class PatrolOrderDetailNodeModel: NSObject {

    public var wkContent: String?
    public var wkID: String?
    public var wkNode: String?
    public var wkResult: String?
    public var ID: String?
    public var isPhoto: String?
    public var patrolItems: String?
    public var picExampleUrl: String?
    public var picUrl: String?
    public var refId: String?
    public var signResult: String?
    public var signTime: String?
    public var signType: String?
    public var sort: String?

    public var isAgree: Bool?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        wkContent = json["fWkContent"].string
        wkID = json["fWkId"].string
        wkNode = json["fWkNode"].string
        wkResult = json["fWkResult"].string
        ID = json["id"].string
        isPhoto = json["isPhoto"].string
        patrolItems = json["patrolItems"].string
        picExampleUrl = json["picExampleUrl"].string
        picUrl = json["picUrl"].string
        refId = json["refId"].string
        signResult = json["signResult"].string
        signTime = json["signTime"].string
        signType = json["signType"].string
        sort = json["sort"].string
    }
}

public class OrderListPatrolOrderDetailModel: NSObject {

    public var master: PatrolOrderDetailMasterModel?
    public var node: [PatrolOrderDetailNodeModel] = []

    public var extensionApplication: PatrolOrderCloseModel?      //闭单
    public var delayExtensionApplication: PatrolOrderDelayModel? //延期

    public override init() {
        super.init()
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        let extensionApplicationJson = json["extensionApplication"]
        if !extensionApplicationJson.isEmpty {
            extensionApplication = PatrolOrderCloseModel(fromJson: extensionApplicationJson)
        }

        let delayExtensionApplicationJson = json["delayExtensionApplication"]
        if !delayExtensionApplicationJson.isEmpty {
            delayExtensionApplication = PatrolOrderDelayModel(fromJson: delayExtensionApplicationJson)
        }

//        master = json["master"].string
        let masterJson = json["master"]
        if !masterJson.isEmpty {
            master = PatrolOrderDetailMasterModel(fromJson: masterJson)
        }

//        node = json["node"].string
        node = [PatrolOrderDetailNodeModel]()
        let nodeArray = json["node"].arrayValue
        for nodeJson in nodeArray {
            let value = PatrolOrderDetailNodeModel(fromJson: nodeJson)
            node.append(value)
        }

    }
}
