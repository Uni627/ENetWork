//
//  UnqualifiedOrderListModel.swift
//  EServices
//
//  Created by 刘小白 on 2020/1/9.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

//不合格单 状态
public enum UnqualifiedOrderState: String {

    case createStep = "createStep"          //新生成
    case processingStep = "processingStep"  //处理中
    case completedStep = "completedStep"    //已完成
    
    public var description: String {
        switch self {
        case .createStep:
            return "新生成"
        case .processingStep:
            return "处理中"
        case .completedStep:
            return "已完成"
        }
    }
}

public class UnqualifiedOrderListModel: NSObject {
    public var searchValue: String? //搜索字段
    public var isCache = false //是否缓存
    public var status: UnqualifiedOrderState?         //工单状态 取自数据字典
    public var id: String?                         //工单ID
    public var procinstID: String?                 //查看详情需要用到的id 实例id
    public var originalProcinstID: String?          //查看详情需要用到的id 实例id
    public var refID: String?
    public var tenantID: String?                   //租户Id
    public var assigneeID: String?                 //任务执行人ID
    public var checkDate: Int?                     //检查日期 整形 时间戳
    public var checkDateStr: String?               //检查日期 整形 时间戳 转 年月日
    public var checkUserID: String?                //检查人Id
    public var checkUserName: String?              //检查人姓名
    public var checkedUserID: String?              //被检查人Id
    public var checkedUserName: String?            //被检查人姓名
    public var code: String?                       //不合格单编号
    public var correctionDate: Int?                //纠正截至日期 整形 时间戳
    public var correctionDateStr: String?          //纠正截至日期 整形 时间戳 转 年月日
    public var correctiveAction: String?           //纠正预防措施
    public var createTime: Int?                    //任务创建时间 整形 时间戳
    public var createTimeStr: String?              //任务创建时间 整形 时间戳 转 年月日时分秒
    public var createdTime: Int?                   //工单创建时间 整形 时间戳
    public var createdTimeStr: String?             //工单创建时间 整形 时间戳 转 年月日时分秒
    public var divideID: String?                   //分期id
    public var divideName: String?                 //分期名称
    public var feedbackDate: Int?                  //反馈日期 整形 时间戳
    public var feedbackDateStr: String?            //反馈日期 整形 时间戳 转 年月日
    public var feedbackTime: Int?                  //反馈时间 整形 时间戳
    public var feedbackTimeStr: String?            //反馈时间 整形 时间戳 转 年月日时分秒
    public var feedbackEnclosure: String?          //反馈附件(json字符串)--图片集合字符串
    public var feedbackUserID: String?
    public var feedbackUserName: String?
    public var line: String?                       //条线 取自数据字典
    public var ownerID: String?                    //任务所属人Id
    public var parentInstID: String?
    public var parentNodeID: String?
    public var proInsID: String?
    public var instanceID: String?
    public var problemDescription: String?         //问题描述
    public var reason: String?                     //原因分析
    public var severity: String?                   //严重程度  取自数据字典
    public var subject: String?                    //任务主题
    public var taskID: String?                     //任务Id(处理详情接口需要的任务Id)
    public var taskName: String?                   //任务名称
    public var taskNodeID: String?
    public var parentID: String?                   //父级不合格工单Id
    public var parentCode: String?                 //父级不合格工单编号
    public var createEnclosure: String?            //创建时附件(json格式字符串) 图片 集合字符串
    public var originalType: Int?
    public var originalCode: String?            //原工单编号
    public var originalID: String?


    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        isCache = json["isCache"].bool ?? false

        id = json["ID_"].string
        procinstID = json["PROC_INST_ID_"].string
        refID = json["REF_ID_"].string
        tenantID = json["Tenant_ID"].string
        assigneeID = json["assigneeId"].string

        checkDate = json["check_date"].int
        let checkDateTemp = json["check_date"].double
        if checkDateTemp != nil {
            checkDateStr = checkDateTemp?.dateString(outputFormatter: "yyyy-MM-dd")
        }
        checkUserID = json["check_user_id"].string
        checkUserName = json["check_user_name"].string
        checkedUserID = json["checked_user_id"].string
        checkedUserName = json["checked_user_name"].string
        code = json["code"].string
        correctionDate = json["correction_date"].int
        let correctionDateTemp = json["correction_date"].double
        if correctionDateTemp != nil {
            correctionDateStr = correctionDateTemp?.dateString(outputFormatter: "yyyy-MM-dd")
        }

        correctiveAction = json["corrective_action"].string
        createTime = json["createTime"].int
        let createTimeTemp = json["createTime"].double
        if createTimeTemp != nil {
            createTimeStr = createTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        createdTime = json["created_time"].int
        let createdTimeTemp = json["created_time"].double
        if createdTimeTemp != nil {
            createdTimeStr = createdTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        divideID = json["divide_id"].string
        divideName = json["divide_name"].string

        feedbackDate = json["feedback_date"].int
        let feedbackDateTemp = json["feedback_date"].double
        if feedbackDateTemp != nil {
            feedbackDateStr = feedbackDateTemp?.dateString(outputFormatter: "yyyy-MM-dd")
        }

        feedbackTime = json["feedback_time"].int
        let feedbackTimeTemp = json["feedback_time"].double
        if feedbackTimeTemp != nil {
            feedbackTimeStr = feedbackTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        feedbackEnclosure = json["feedback_enclosure"].string
        feedbackUserID = json["feedback_user_id"].string
        feedbackUserName = json["feedback_user_name"].string
        line = json["line"].string
        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].string
        parentNodeID = json["parentNodeId"].string

        //实例id 转换
        proInsID = json["proInsId"].string
        originalProcinstID = json["original_prolnstld"].string
        let proInsIDStr = proInsID ?? ""
        if proInsIDStr == "" {
            proInsID = json["instance_id"].string
        }
        instanceID = json["instance_id"].string

        problemDescription = json["problem_description"].string
        reason = json["reason"].string
        severity = json["severity"].string
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string
        originalType = json["original_type"].int
        originalCode = json["original_code"].string
        originalID = json["original_id"].string
        if let type = json["status"].string {
            status = UnqualifiedOrderState(rawValue: type)
        }
    }

    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        dictionary["isCache"] = isCache
        if id != nil {
            dictionary["ID_"] = id
        }
        if procinstID != nil {
            dictionary["PROC_INST_ID_"] = procinstID
        }
        if refID != nil {
            dictionary["REF_ID_"] = refID
        }
        if tenantID != nil {
            dictionary["Tenant_ID"] = tenantID
        }
        if assigneeID != nil {
            dictionary["assigneeId"] = assigneeID
        }
        if correctiveAction != nil {
            dictionary["corrective_action"] = correctiveAction
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if createdTime != nil {
            dictionary["created_time"] = createdTime
        }
        if feedbackDate != nil {
            dictionary["feedback_date"] = feedbackDate
        }
        if feedbackEnclosure != nil {
            dictionary["feedback_enclosure"] = feedbackEnclosure
        }
        if feedbackTime != nil {
            dictionary["feedback_time"] = feedbackTime
        }
        if feedbackUserID != nil {
            dictionary["feedback_user_id"] = feedbackUserID
        }
        if feedbackUserName != nil {
            dictionary["feedback_user_name"] = feedbackUserName
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
        if originalProcinstID != nil {
            dictionary["original_prolnstld"] = originalProcinstID
        }
        if originalCode != nil {
            dictionary["original_code"] = originalCode
        }
        if reason != nil {
            dictionary["reason"] = reason
        }
        if status != nil {
            dictionary["status"] = status
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
            dictionary["divide_id"] = divideID
        }
        if divideName != nil {
            dictionary["divide_name"] = divideName
        }
        if code != nil {
            dictionary["code"] = code
        }
        if line != nil {
            dictionary["line"] = line
        }
        if severity != nil {
            dictionary["severity"] = severity
        }
        if problemDescription != nil {
            dictionary["problem_description"] = problemDescription
        }
        if parentID != nil {
            dictionary["parent_id"] = parentID
        }
        if parentCode != nil {
            dictionary["parent_code"] = parentCode
        }
        if parentCode != nil {
            dictionary["parent_code"] = parentCode
        }
        if checkUserID != nil {
            dictionary["check_user_id"] = checkUserID
        }
        if checkUserName != nil {
            dictionary["check_user_name"] = checkUserName
        }
        if checkedUserID != nil {
            dictionary["checked_user_id"] = checkedUserID
        }
        if checkedUserName != nil {
            dictionary["checked_user_name"] = checkedUserName
        }
        if checkDateStr != nil {
            dictionary["check_date"] = checkDateStr
        }
        if correctionDateStr != nil {
            dictionary["correction_date"] = correctionDateStr
        }
        if createEnclosure != nil {
            dictionary["create_enclosure"] = createEnclosure
        }
        if originalType != nil {
            dictionary["original_type"] = originalType
        }
        if originalID != nil {
            dictionary["original_id"] = originalID
        }
        return dictionary
    }

    public override init() {
        super.init()
    }

}
