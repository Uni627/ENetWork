//
//  ApproveWaitModel.swift
//  EServices
//
//  Created by pxy on 2019/11/8.
//

import Foundation
import SwiftyJSON

public class ApproveWaitModel: NSObject {

    public var ID: String?
    public var applyDate: Int?
    public var applyFlowKey: String?
    public var applyInstanceID: String?
    public var applyUser: String?                          //申请人
    public var applyUserID: String?
    public var approvalRole: String?
    public var assigneeID: String?
    public var auditCode: String?                          //审批单号
    public var auditType: AuditType?                       //审批类型 大类
    public var auditSubType: AuditSubtype?                 //审批类型 小类
    public var createTime: Int?
    public var divideID: String?
    public var divideName: String?                         //分期\分期
    public var formData: String?
    public var formDataModel: FormDataModel?
    public var ownerID: String?
    public var parentInstID: Int?
    public var parentNodeID: Int?
    public var proInsID: String?
    public var status: ApprovalState?                      //审批状态
    public var userAuditStatus: ApprovalState?
    public var userAuditStatusName: String?
    public var statusName: String?
    public var subject: String?
    public var taskID: String?
    public var taskName: String?
    public var taskNodeID: String?
    public var tenantID: String?
    public var auditDate: Int?
    public var rowTime: Int?
    public var zoneName: String?
    public var applyBizID: String?
    public var zoneID: String?
    public var districtName: String?
    public var refID: String?
    public var procInstID: String?
    public var rowVersion: Int?

    public var applyKeyTitle: String?
    public var districtID: String?
    public var detailApplyDate: String?
    public var detailAuditDate: String?

    public var applyOrderRecorderID: String?
    public var detailID: String?
    public var callbackStatus: String?
    public var currentStepStatus: String?
    public var auditInstanceID: String?
    public var projectName: String?
    public var projectID: String?

    public var cellModelArr: [Any] = []
    public var cellSubModelArr: [Any] = []
    public var auditedArr: [Any] = []

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        ID = json["id_"].string
        applyDate = json["apply_date"].int
        applyFlowKey = json["apply_flow_key"].string
        applyInstanceID = json["apply_instance_id"].string
        applyUser = json["apply_user"].string
        applyUserID = json["apply_user_id"].string
        approvalRole = json["approvalRole"].string
        assigneeID = json["assigneeId"].string
        auditCode = json["audit_code"].string

        if let type = json["audit_type"].string {
            auditType  = AuditType(rawValue: type)
        }
        if let type = json["audit_sub_type"].string {
            auditSubType = AuditSubtype(rawValue: type)
        }
        if let type = json["status"].string {
            status = ApprovalState(rawValue: type)
        }
        if let auditStatus = json["userAuditStatus"].string {
            userAuditStatus = ApprovalState(rawValue: auditStatus)
        }

        statusName = json["statusName"].string
        userAuditStatusName = json["userAuditStatusName"].string
        createTime = json["createTime"].int
        divideID = json["divide_id"].string
        divideName = json["divide_name"].string

        let form = json["form_data"].string

        if let form = form {
            formDataModel = FormDataModel(fromJson: JSON(parseJSON: form))
        }

        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].int
        parentNodeID = json["parentNodeId"].int
        proInsID = json["proInsId"].string
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string

        tenantID = json["tenant_id"].string
        auditDate = json["audit_date"].int
        rowTime = json["row_time"].int
        zoneName = json["zone_name"].string
        applyBizID = json["apply_biz_id"].string
        zoneID = json["zone_id"].string
        districtName = json["district_name"].string
        refID = json["REF_ID_"].string
        procInstID = json["proc_inst_id_"].string

        applyKeyTitle = json["apply_key_title"].string
        districtID = json["district_id"].string

        detailApplyDate = json["apply_date"].string
        detailAuditDate = json["audit_date"].string
        detailID = json["id_"].string
        callbackStatus = json["callback_status"].string
        applyOrderRecorderID = json["apply_order_recorder_id"].string
        currentStepStatus = json["current_step_status"].string
        auditInstanceID = json["audit_instance_id"].string
        projectName = json["project_name"].string
        projectID = json["project_id"].string
    }

    public override init() {
        super.init()
    }
}
