//  计划工单列表--待跟进
//    SendPlannedWorkOrderListModel.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class SendPlannedWorkOrderListModel: NSObject {
    public var ID1: String?
    public var procInstID: String?
    public var orderCreateTime: Int? //工单创建时间
    public var deadlineTime: Int? //完成截止时间
    public var extstatus: Int? //是否延期
    public var location: String? //位置
    public var orderNo: String? //工单编号
    public var processName: String?
    public var resID: String? //资源id
    public var resName: String? //资源名称
    public var status: String? //工单状态 2-处理中 4-已完成  5：接单  6：派单
    public var lineID: String? //条线id
    public var lineCode: String? //条线编码
    public var lineName: String? //条线名称
    public var workPlanName: String?
    public var ID: String?
    public var assigneeID: String?
    public var createTime: Int? //待办生成时间
    public var orderType: Int? //工单类型
    public var ownerID: String?
    public var parentInstID: String?
    public var parentNodeID: String?
    public var proInsID: String? //流程实例id
    public var subject: String? //工单标题
    public var taskID: String? //任务id
    public var taskName: String? //任务名称
    public var taskNodeID: String? //任务节点id
    public var otstatus: Int? //是否超时 1超时 0未超时
    public var searchValue: String? //搜索字段
    public var divideID: String? //分期id
    public var period: String? //完成截止时间
    public var projectID: String?
    public var projectID1: String?

    public var isComingTimeOut: Int?   //过期标识（0为不快过期，1为快过期）

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        ID1 = json["id_"].string
        procInstID = json["PROC_INST_ID"].string
        projectID = json["projectID"].string
        projectID1 = json["F_project_id"].string
        orderCreateTime = json["F_CREATE_TIME"].int
        deadlineTime = json["F_DEADLINE_TIME"].int
        extstatus = json["F_EXT_STATUS"].int
        location = json["F_LOCATION"].string
        orderNo = json["F_ORDER_NO"].string
        otstatus = json["F_OT_STATUS"].int
        processName = json["F_PROCESS_NAME"].string
        resID = json["F_RES_ID"].string
        resName = json["F_RES_NAME"].string
        status = json["F_STATUS"].string
        lineID = json["F_TX_ID"].string
        lineCode = json["F_TX_CODE"].string
        lineName = json["F_TX_NAME"].string
        workPlanName = json["F_WP_NAME"].string
        if let orderID = json["id_"].string {
            ID = orderID
        } else {
            ID = json["ID_"].string
        }
        assigneeID = json["assigneeId"].string
        createTime = json["createTime"].int
        orderType = json["orderType"].int
        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].string
        parentNodeID = json["parentNodeId"].string
        proInsID = json["proInsId"].string
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string
        searchValue = json["searchValue"].string
        divideID = json["F_DIVIDE_ID"].string
        period = json["period"].string
        isComingTimeOut = json["is_coming_timeout"].int
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if projectID != nil {
            dictionary["projectID"] = projectID
        }
        if projectID1 != nil {
            dictionary["F_project_id"] = projectID1
        }
        if orderCreateTime != nil {
            dictionary["F_CREATE_TIME"] = orderCreateTime
        }
        if deadlineTime != nil {
            dictionary["F_DEADLINE_TIME"] = deadlineTime
        }
        if extstatus != nil {
            dictionary["F_EXT_STATUS"] = extstatus
        }
        if location != nil {
            dictionary["F_LOCATION"] = location
        }
        if orderNo != nil {
            dictionary["F_ORDER_NO"] = orderNo
        }
        if otstatus != nil {
            dictionary["F_OT_STATUS"] = otstatus
        }
        if processName != nil {
            dictionary["F_PROCESS_NAME"] = processName
        }
        if resID != nil {
            dictionary["F_RES_ID"] = resID
        }
        if procInstID != nil {
            dictionary["PROC_INST_ID"] = procInstID
        }
        if resName != nil {
            dictionary["F_RES_NAME"] = resName
        }
        if status != nil {
            dictionary["F_STATUS"] = status
        }
        if lineID != nil {
            dictionary["F_TX_ID"] = lineID
        }
        if lineCode != nil {
            dictionary["F_TX_CODE"] = lineCode
        }
        if lineName != nil {
            dictionary["F_TX_NAME"] = lineName
        }
        if workPlanName != nil {
            dictionary["F_WP_NAME"] = workPlanName
        }
        if ID != nil {
            dictionary["ID_"] = ID
        }
        if ID1 != nil {
            dictionary["id_"] = ID1
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
        if divideID != nil {
            dictionary["F_DIVIDE_ID"] = divideID
        }
        if period != nil {
            dictionary["period"] = period
        }
        if searchValue != nil {
            dictionary["searchValue"] = searchValue
        }
        if isComingTimeOut != nil {
            dictionary["is_coming_timeout"] = isComingTimeOut
        }
        return dictionary
    }
}
