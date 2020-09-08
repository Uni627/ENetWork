//
//  AuditDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/3.
//  Copyright © 2019 uni. All rights reserved.
//

import ENetWork
import SwiftyJSON

public class AuditDetailModel: NSObject {

    public var workOrderAuditModel: ApproveWaitModel? //审批详情
    //    public var formDataModel : FormDataModel?
    public var formResult: String?
    //    public var opinionModel: OpinionModel?
    public var permission: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        let auditJson = json["data"]["workorder_audit_model"]
        if !auditJson.isEmpty {
            workOrderAuditModel = ApproveWaitModel(fromJson: auditJson)
        }
    }

}

public class FormDataModel: NSObject {

    public var applyReason: String? //申请原因
    public var code: String? //工单编号
    public var attachmentArray: [PictureModel] = [] //图片model集合
    public var parentID: String? //实例ID
    public var delaySumTime: String? //总延时天数
    public var delayNumber: Int? //已延期次数
    public var taskID: String?
    public var category: String? //工单类型
    public var delayTime: String? //延期时间
    public var nodeID: String? //当前节点名称
    public var setToInvalID: String? //是否设为无效
    public var workOrderCategory: String? //工单类型
    public var invalidReasonCategory: String? //无效原因分类
    public var property: String? //投诉性质
    public var type: String? //类别
    public var repairArea: String? //报修区域
    public var flowType: String? //工单类型
    public var inspectionName: String?//计划名称
    var inspectionTypeName: String? //分类
    var inspectionWorkGuidanceName: String? //工作指导
    public var principal: String? //工单负责人
    public var gridName: String? //网格
    public var buildingName: String? //楼栋
    public var unitName: String? //单元
    public var floor: String? //楼层
    public var planName: String? //计划名称
    public var resourceName: String? //资源类型
    public var creationTime: String? //工单创建时间
    public var deadlineTime: String? //完成截止时间
    public var extensionDays: String? //延期天数
    public var dispatchFlowType: String? //派工单类型
    public var procName: String? //工单负责人
    public var lineName: String? //条线
    var line: String? //条线
    public var workPlanName: String? //计划名称
    public var resourceClassificationName: String? //资源分类
    public var workGuidanceName: String? //工作指导
    public var effectivePeriod: String? //有效期
    public var gridHouseKeeper: String? //网络管家
    public var adaptationFloor: String? //适用楼层
    public var extensionApplicationID: String?
    public var applyTaskID: String?
    public var approvalID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        //申请原因 字段转换 或者 是 执行频率
        let tempApplyReason = json["applyReason"]
        if tempApplyReason.isEmpty {
            let tempApplicationDescription = json["applicationDescription"].string
            let tpApplyReason = json["apply_reason"].string
            if (tempApplicationDescription?.count ?? 0) > 0 {
                applyReason = tempApplicationDescription
            } else if (tpApplyReason?.count ?? 0) > 0 {
                applyReason = tpApplyReason
            }
        } else {
            applyReason = json["applyReason"].string
        }

        let frequencyArray = json["frequency"].arrayValue
        if frequencyArray.count > 0 {
            var tempStr = ""
            for frequencyStr in frequencyArray {
                tempStr.append("\(frequencyStr)\n")
            }
            applyReason = tempStr
        }

        attachmentArray = [PictureModel]() //图片集合
        let tempAttachment = json["attachment"].stringValue
        let applyFilesString = json["applyFiles"].stringValue

        if tempAttachment.count > 0 {
            if let jsonData = tempAttachment.data(using: .utf8) {
                let picJson = JSON(jsonData)
                if picJson.arrayValue.count > 0 {
                    for tempJson in picJson.arrayValue {
                        let model = PictureModel(fromJson: tempJson)
                        if let path = model.filePath {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + path
                        } else {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                        }
                        attachmentArray.append(model)
                    }
                }
            }
        } else if applyFilesString.count > 0 {
            if let jsonData = applyFilesString.data(using: .utf8) {
                let picJson = JSON(jsonData)
                if picJson.arrayValue.count > 0 {
                    for tempJson in picJson.arrayValue {
                        let model = PictureModel(fromJson: tempJson)
                        if let path = model.filePath {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + path
                        } else {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                        }
                        attachmentArray.append(model)
                    }
                }
            }
        }

        code = json["code"].string //工单编号
        parentID = json["parent_id"].string //实例ID
        delaySumTime = json["delay_sum_time"].string //总延时天数
        delayNumber = json["delay_number"].int //已延期次数
        taskID = json["task_id"].string
        category = json["category"].string //工单类型
        delayTime = json["delay_time"].stringValue //延期时间
        nodeID = json["node_id"].string //当前节点名称
        setToInvalID = json["setToInvalid"].string //是否设为无效
        workOrderCategory = json["workOrderCategory"].string //工单类型
        invalidReasonCategory = json["invalidReasonCategory"].string //无效原因分类
        property = json["property"].string //投诉性质
        type = json["type"].string //类别
        repairArea = json["repairArea"].string //报修区域
        flowType = json["flowType"].string //工单类型
        line = json["line"].string //条线
        inspectionName = json["inspectionName"].string //计划名称
        inspectionTypeName = json["inspectionTypeName"].string //分类
        inspectionWorkGuidanceName = json["inspectionWorkGuidanceName"].string //工作指导
        principal = json["principal"].string //工单负责人
        gridName = json["gridName"].string //网格
        buildingName = json["buildingName"].string //楼栋
        unitName = json["unitName"].string //单元
        floor = json["floor"].string //楼层
        planName = json["planName"].string //计划名称
        resourceName = json["resourceName"].string //资源类型
        creationTime = json["creationTime"].string //工单创建时间
        deadlineTime = json["deadlineTime"].string //完成截止时间
        extensionDays = json["extensionDays"].string //延期天数
        dispatchFlowType = json["dispatchFlowType"].string//派工单类型
        procName = json["procName"].string //工单负责人
        lineName = json["lineName"].string //条线
        workPlanName = json["workPlanName"].string //计划名称
        resourceClassificationName = json["resourceClassificationName"].string //资源分类
        workGuidanceName = json["workGuidanceName"].string //工作指导
        effectivePeriod = json["effectivePeriod"].string //有效期
        gridHouseKeeper = json["gridHousekeeper"].string //网络管家
        adaptationFloor = json["adaptationFloor"].string //适用楼层
        extensionApplicationID = json["extensionApplicationId"].string
        applyTaskID = json["applyTaskId"].string
        approvalID = json["approvalId"].string

        if lineName == nil {//条线
            lineName = line
        }

        if workPlanName == nil {//计划名称
            workPlanName = inspectionName
        }

        if resourceClassificationName == nil {
            resourceClassificationName = inspectionTypeName
        }

        if workGuidanceName == nil {
            workGuidanceName = inspectionWorkGuidanceName
        }
    }
}

public class WorkOrderAuditModel: NSObject {

    public var auditType: AuditType?         //审批类型 大类
    public var auditSubtype: AuditSubtype?   //审批类型 小类
    public var status: ApprovalState?        //审批状态
    public var procInstID: String?
    public var applyKeyTitle: String?
    public var applyFlowKey: String?
    public var applyInstanceID: String?
    public var districtID: String?
    public var applyOrderRecorderID: String?
    public var applyDate: String?
    public var applyUser: String?
    public var applyUserID: String?
    public var initData: Any?
    public var projectName: String?
    public var districtName: String?
    public var refID: String?
    public var projectID: String?
    public var applyBizID: String?
    public var auditCode: String?
    public var auditDate: String?
    public var zoneID: String?
    public var auditInstanceID: String?
    public var ID: String?
    public var zoneName: String?
    public var divideName: String?
    public var currentStepStatus: String?
    public var tenantID: String?
    public var callbackStatus: Int?
    public var divideID: String?
    public var formDataModel: FormDataModel?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        if let type = json["audit_type"].string {
            auditType  = AuditType(rawValue: type)
        }
        if let type = json["audit_sub_type"].string {
            auditSubtype = AuditSubtype(rawValue: type)
        }
        if let type = json["status"].string {
            status = ApprovalState(rawValue: type)
        }

        procInstID = json["proc_inst_id_"].string
        applyKeyTitle = json["apply_key_title"].string
        applyFlowKey = json["apply_flow_key"].string
        applyInstanceID = json["apply_instance_id"].string
        districtID = json["district_id"].string
        applyOrderRecorderID = json["apply_order_recorder_id"].string
        applyDate = json["apply_date"].string
        applyUser = json["apply_user"].string
        applyUserID = json["apply_user_id"].string
        initData = json["initData"]
        projectName = json["project_name"].string
        districtName = json["district_name"].string
        refID = json["ref_id_"].string
        projectID = json["project_id"].string
        applyBizID = json["apply_biz_id"].string
        auditCode = json["audit_code"].string
        auditDate = json["audit_date"].string
        zoneID = json["zone_id"].string
        auditInstanceID = json["audit_instance_id"].string
        ID = json["id_"].string
        zoneName = json["zone_name"].string
        divideName = json["divide_name"].string
        currentStepStatus = json["current_step_status"].string
        tenantID = json["tenant_id"].string
        callbackStatus = json["callback_status"].int
        divideID = json["divide_id"].string

        let formJson = json["form_data"]
        if !formJson.isEmpty {
            formDataModel = FormDataModel(fromJson: formJson)
        }
    }

}
