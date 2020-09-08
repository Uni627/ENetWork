//  待处理巡查工单--待跟进
//	SendOrderPatrolModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class SendOrderPatrolModel: NSObject {

    ///完成截止时间
    public var completionDeadLine: Int?
    public var configType: String?
    ///创建时间
    public var creationDate: Int?
    ///巡查工作计划名称
    public var inspectionWorkPlanName: String?
    ///工单编号
    public var planWorkOrderCode: String?
    ///工单状态 2-处理中，4-已完成
    public var planWorkOrderState: Int?
    ///工单负责人名称
    public var principalName: String?
    public var ID: String?
    public var assigneeID: String?
    ///待办生成时间
    public var createTime: Int?
    ///工单类型  0计划工单１派工单２巡查工单
    public var orderType: Int?
    public var ownerID: String?
    public var parentInstID: String?
    public var parentNodeID: String?
    ///实例id
    public var proInsID: String?
    ///工单标题
    public var subject: String?
    ///任务id
    public var taskID: String?
    ///任务名称
    public var taskName: String?
    ///任务节点id
    public var taskNodeID: String?
    ///长度>0是巡更 ，否则巡查
    public var patrolLineID: String?
    public var patrolLineName: String?
    ///条线Code
    public var lineCode: String?
    ///条线名称
    public var lineName: String?
    ///分类ID
    public var typeID: String?
    ///分类名称
    public var typeName: String?
    ///分期id
    public var divideID: String?
    ///网格id
    public var gridID: String?
    ///楼栋id
    public var buildingID: String?
    ///单元id
    public var unitID: String?
    ///工单是否超时  0否 1是
    public var isTimeOut: Int?
    ///完成截止时间
    public var period: String?
    public var projectID: String?
    ///过期标识（0为不快过期，1为快过期）
    public var isComingTimeOut: Int?
    ///搜索字段
    public var searchValue: String?
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        projectID = json["F_project_id"].string
        completionDeadLine = json["F_completion_deadline"].int
        configType = json["F_config_type"].string
        creationDate = json["F_creation_date"].int
        inspectionWorkPlanName = json["F_inspection_work_plan_name"].string
        lineCode = json["F_line_code"].string
        lineName = json["F_line_name"].string
        planWorkOrderCode = json["F_plan_work_order_code"].string
        planWorkOrderState = json["F_plan_work_order_state"].int
        principalName = json["F_principal_name"].string
        ID = json["ID_"].string
        assigneeID = json["assigneeId"].string
        createTime = json["createTime"].int
        orderType = json["orderType"].int
        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].string
        parentNodeID = json["parentNodeId"].string

        //实例id 转换
        proInsID = json["proInsId"].string
        let proInsIDStr = proInsID ?? ""
        if proInsIDStr == "" {
            proInsID = json["PROC_INST_ID"].string
        }

        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string

        patrolLineID = json["F_patrol_line_id"].string
        patrolLineName = json["F_patrol_line_name"].string
        typeID = json["F_type_id"].string
        typeName = json["F_type_name"].string

        divideID = json["F_massif_id"].string
        gridID = json["F_grid_id"].string
        buildingID = json["F_building_id"].string
        unitID = json["F_unit_id"].string
        isTimeOut = json["F_is_time_out"].int
        period = json["period"].string
        searchValue = json["searchValue"].string

        isComingTimeOut = json["is_coming_timeout"].int
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if projectID != nil {
            dictionary["F_project_id"] = projectID
        }
        
        if completionDeadLine != nil {
            dictionary["F_completion_deadline"] = completionDeadLine
        }
        if configType != nil {
            dictionary["F_config_type"] = configType
        }
        if creationDate != nil {
            dictionary["F_creation_date"] = creationDate
        }
        if inspectionWorkPlanName != nil {
            dictionary["F_inspection_work_plan_name"] = inspectionWorkPlanName
        }
        if lineCode != nil {
            dictionary["F_line_code"] = lineCode
        }
        if lineName != nil {
            dictionary["F_line_name"] = lineName
        }
        if planWorkOrderCode != nil {
            dictionary["F_plan_work_order_code"] = planWorkOrderCode
        }
        if planWorkOrderState != nil {
            dictionary["F_plan_work_order_state"] = planWorkOrderState
        }
        if principalName != nil {
            dictionary["F_principal_name"] = principalName
        }
        if ID != nil {
            dictionary["ID_"] = ID
        }
        if assigneeID != nil {
            dictionary["assigneeId"] = assigneeID
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if orderType != nil {
            dictionary["orderType"] = orderType
        }
        if ownerID != nil {
            dictionary["ownerId"] = ownerID
        }
        if parentInstID != nil {
            dictionary["parentInstId"] = parentInstID
        }
        if parentNodeID != nil {
            dictionary["parentNodeId"] = parentNodeID
        }
        if proInsID != nil {
            dictionary["proInsId"] = proInsID
        }
        if subject != nil {
            dictionary["subject"] = subject
        }
        if taskID != nil {
            dictionary["taskId"] = taskID
        }
        if taskName != nil {
            dictionary["taskName"] = taskName
        }
        if taskNodeID != nil {
            dictionary["taskNodeId"] = taskNodeID
        }

        if patrolLineID != nil {
            dictionary["F_patrol_line_id"] = patrolLineID
        }
        if patrolLineName != nil {
            dictionary["F_patrol_line_name"] = patrolLineName
        }
        if typeID != nil {
            dictionary["F_type_id"] = typeID
        }
        if typeName != nil {
            dictionary["F_type_name"] = typeName
        }

        if divideID != nil {
            dictionary["F_massif_id"] = divideID
        }
        if gridID != nil {
            dictionary["F_grid_id"] = gridID
        }
        if buildingID != nil {
            dictionary["F_building_id"] = buildingID
        }
        if unitID != nil {
            dictionary["F_unit_id"] = unitID
        }
        if isTimeOut != nil {
            dictionary["F_is_time_out"] = isTimeOut
        }
        if period != nil {
            dictionary["period"] = period
        }
        if isComingTimeOut != nil {
            dictionary["is_coming_timeout"] = isComingTimeOut
        }
        if searchValue != nil {
            dictionary["searchValue"] = searchValue
        }
        return dictionary
    }
}
