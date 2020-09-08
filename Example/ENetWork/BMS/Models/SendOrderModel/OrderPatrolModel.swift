//
//  OrderPatrolModel.swift
//  EServices
//
//  Created by pxy on 2019/11/12.
//

import ENetWork
import SwiftyJSON

public class OrderPatrolModel: NSObject {

    public var actualCompletionTime: String?                       //实际完成时间
    public var buildingID: String?                                 //楼栋ID
    public var buildingName: String?                               //楼栋名称
    public var close: String?                                      //
    public var completionDeadline: String?                         //完成截止时间
    public var creationDate: String?                               //创建时间
    public var descript: String?                                   //说明
    public var duration: String?                                   //
    public var extendStatus: String?                               //是否延期
    public var files: String?                                      //附件图片
    public var filesArray: [PictureModel] = []                     //附件 图片转model
    public var floor: String?                                      //楼层
    public var gridID: String?                                     //网格ID
    public var gridName: String?                                   //网格名称
    public var inspectionWorkGuidanceID: String?                   //工作指导ID
    public var inspectionWorkGuidanceName: String?                 //工作指导名称
    public var inspectionWorkPlanId: String?                       //巡查工作计划ID
    public var inspectionWorkPlanName: String?                     //巡查工作计划名称
    public var isTimeOut: Int?                                     //是否超时     1：超时   0：未超时
    public var lineID: String?                                     //
    public var lineName: String?                                   //条线ID
    public var massifID: String?                                   //分期ID
    public var massifName: String?                                 //分期名称
    public var patrolLineID: String?
    public var patrolLineName: String?                             //
    public var planWorkOrderCode: String?                          //工单编号
    public var planWorkOrderState: Int?                            //计划工单状态    2：处理中   4：已完成
    public var principalID: String?                                //工单负责人ID
    public var principalName: String?                              //工单负责人名称
    public var processingDate: String?                             //处理时间
    public var processingInstructions: String?                     //处理用时
    public var processingPersonID: String?                         //处理人ID
    public var processingPersonName: String?                       //处理人名称
    public var processingTime: String?                             //
    public var projectID: String?                                  //项目ID
    public var projectName: String?                                //项目名称
    public var realDuration: String?                               //
    public var typeID: String?                                     //分类ID
    public var typeName: String?                                   //分类名称
    public var unitID: String?                                     //单元ID
    public var unitName: String?                                   //单元名称
    public var configType: String?                                 //
    public var houseCode: String?                                  //
    public var lineCode: String?                                   //
    public var ID: String?                                         //主键
    public var isSort: String?                                     //
    public var refID: String?                                      //

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        actualCompletionTime = json["fActualCompletionTime"].string
        buildingID = json["fBuildingId"].string
        buildingName = json["fBuildingName"].string
        close = json["fClose"].string
        completionDeadline = json["fCompletionDeadline"].string
        creationDate = json["fCreationDate"].string
        descript = json["fDescription"].string
        duration = json["fDuration"].string
        extendStatus = json["fExtStatus"].string

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
        inspectionWorkPlanId = json["fInspectionWorkPlanId"].string
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
