//
//  EnquiryListModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/18.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class EnquiryListModel: NSObject {
    ///工单状态
    public var state: CustomerOrderState?
    ///主键
    public var id: String?
    public var procinstTimeOut: String?
    ///响应超时(1：超时)
    public var responseTimeOut: String?
    public var assigneeID: String?
    ///完成截止时间 整形 毫秒
    public var deadLineTime: Int?
    ///完成截止时间 整形转 年月日时分秒
    public var deadLineTimeStr: String?
    ///创建时间 整形 毫秒
    public var createTime: Int?
    ///创建时间 整形转 年月日时分秒
    public var createTimeStr: String?
    public var instanceID: String?
    ///是否超时
    public var isReturnTimeOut: String?
    ///任务所属人Id
    public var ownerID: String?
    ///父流程实例ID
    public var parentInstID: Int?
    ///父流程节点ID
    public var parentNodeID: Int?
    public var proInsID: String?
    public var subject: String?
    ///任务ID
    public var taskID: String?
    ///任务名字
    public var taskName: String?
    ///任务节点ID
    public var taskNodeID: String?
    public var projectID: String?
    ///问询大类别
    public var cate: String?
    ///问询大类别 id
    public var cateID: String?
    ///问询小类别
    public var subCate: String?
    ///问询小类别 id
    public var subCateID: String?
    ///工单编号
    public var code: String?
    ///问询内容
    public var content: String?
    ///分期
    public var divide: String?
    ///分期 id
    public var divideID: String?
    ///分期code
    public var divideCode: String?
    ///房产
    public var house: String?
    ///房产id
    public var houseID: String?
    ///房产code
    public var houseCode: String?
    ///联系电话
    public var mobile: String?
    ///问询时间 整形 毫秒
    public var time: Int?
    ///问询时间 整形 转 年月日时分秒
    public var timeStr: String?
    ///问询人
    public var user: String?
    ///问询方式
    public var way: String?
    ///问询方式 id
    public var wayID: String?
    ///条线key
    public var lineKey: String?
    ///条线名称
    public var lineName: String?
    ///楼栋id
    public var buildID: String?
    public var buildName: String?
    ///单元id
    public var unitID: String?
    public var unitName: String?
    ///问询图片 集合 字符串
    public var attachment: String?
    ///过期标识（0为不快过期，1为快过期
    public var isComingTimeOut: Int?

    public var assigneeName: String?
    public var qualfiedNames: String?
    public var qualfieds: String?
    ///回访超时
    public var returnVisitTimeOut: String?
    public var project: String?
    public var searchValue: String?

    init(fromOrderlistJson json: JSON!) {
        if json.isEmpty {
            return
        }

        assigneeID = json["AssigneeId"].string

        assigneeName = json["AssigneeName"].string
        qualfiedNames = json["QualfiedNames"].string
        qualfieds = json["Qualfieds"].string
        returnVisitTimeOut = json["RETURN_VISIT_TIMEOUT"].string
        project = json["u_project"].string

        id = json["ID_"].string
        procinstTimeOut = json["PROC_INST_TIMEOUT"].string

        responseTimeOut = json["RESPONSE_TIMEOUT"].string

        deadLineTime = json["c_deadline_time"].int
        let deadLineTimeTemp = json["c_deadline_time"].double
        if deadLineTimeTemp != nil {
            deadLineTimeStr = deadLineTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        instanceID = json["instance_id"].string
        lineKey = json["line_key"].string
        lineName = json["line_name"].string

        if let type = json["state"].string {
            state = CustomerOrderState(rawValue: type)
        }

        taskID = json["taskId"].string

        cate = json["wx_cate"].string
        cateID = json["wx_cate_id"].string
        subCate = json["wx_sub_cate"].string
        subCateID = json["wx_sub_cate_id"].string
        
        code = json["wx_code"].string
        content = json["wx_content"].string
        divide = json["wx_dk"].string
        mobile = json["wx_mobile"].string

        time = json["wx_time"].int
        let timeTemp = json["wx_time"].double
        if timeTemp != nil {
            timeStr = timeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        user = json["wx_user"].string
        way = json["wx_way"].string
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        if let type = json["state"].string {
            state = CustomerOrderState(rawValue: type)
        }
        id = json["ID_"].string
        procinstTimeOut = json["PROC_INST_TIMEOUT"].string
        responseTimeOut = json["RESPONSE_TIMEOUT"].string
        assigneeID = json["assigneeId"].string

        deadLineTime = json["c_deadline_time"].int
        let deadLineTimeTemp = json["c_deadline_time"].double
        if deadLineTimeTemp != nil {
            deadLineTimeStr = deadLineTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        createTime = json["createTime"].int
        let createTimeTemp = json["createTime"].double
        if createTimeTemp != nil {
            createTimeStr = createTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        //实例id 转换
        proInsID = json["proInsId"].string
        let proInsIDStr = proInsID ?? ""
        if proInsIDStr == "" {
            proInsID = json["instance_id"].string
        }
        instanceID = json["instance_id"].string

        isReturnTimeOut = json["isReturnTimeOut"].string
        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].int
        parentNodeID = json["parentNodeId"].int
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string
        projectID = json["u_project_id"].string
        cate = json["wx_cate"].string
        cateID = json["wx_cate_id"].string
        code = json["wx_code"].string
        subCate = json["wx_sub_cate"].string
        subCateID = json["wx_sub_cate_id"].string
        content = json["wx_content"].string
        divide = json["wx_dk"].string
        divideID = json["wx_dk_id"].string
        house = json["wx_house"].string
        houseID = json["wx_house_id"].string
        mobile = json["wx_mobile"].string

        time = json["wx_time"].int
        let timeTemp = json["wx_time"].double
        if timeTemp != nil {
            timeStr = timeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        user = json["wx_user"].string
        way = json["wx_way"].string

        isComingTimeOut = json["is_coming_timeout"].int
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if id != nil {
            dictionary["ID_"] = id
        }
        if procinstTimeOut != nil {
            dictionary["PROC_INST_TIMEOUT"] = procinstTimeOut
        }
        if responseTimeOut != nil {
            dictionary["RESPONSE_TIMEOUT"] = responseTimeOut
        }
        if assigneeID != nil {
            dictionary["assigneeId"] = assigneeID
        }
        if deadLineTime != nil {
            dictionary["c_deadline_time"] = deadLineTime
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if instanceID != nil {
            dictionary["instance_id"] = instanceID
        }
        if isReturnTimeOut != nil {
            dictionary["isReturnTimeOut"] = isReturnTimeOut
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
        if state != nil {
            dictionary["state"] = state
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
        if projectID != nil {
            dictionary["u_project_id"] = projectID
        }
        if code != nil {
            dictionary["wx_code"] = code
        }
        if time != nil {
            dictionary["wx_time"] = time
        }
        if isComingTimeOut != nil {
            dictionary["is_coming_timeout"] = isComingTimeOut
        }

        if divide != nil {
            dictionary["wx_dk"] = divide
        }
        if divideID != nil {
            dictionary["wx_dk_id"] = divideID
        }
        if mobile != nil {
            dictionary["wx_mobile"] = mobile
        }
        if user != nil {
            dictionary["wx_user"] = user
        }
        if wayID != nil {
            dictionary["wx_way_id"] = wayID
        }
        if way != nil {
            dictionary["wx_way"] = way
        }
        if cateID != nil {
            dictionary["wx_cate_id"] = cateID
        }
        if cate != nil {
            dictionary["wx_cate"] = cate
        }
        if subCateID != nil {
            dictionary["wx_sub_cate_id"] = subCateID
        }
        if subCate != nil {
            dictionary["wx_sub_cate"] = subCate
        }
        if lineKey != nil {
            dictionary["line_key"] = lineKey
        }
        if lineName != nil {
            dictionary["line_name"] = lineName
        }
        if houseID != nil {
            dictionary["wx_house_id"] = houseID
        }
        if house != nil {
            dictionary["wx_house"] = house
        }
        if buildID != nil {
            dictionary["wx_build_id"] = buildID
        }
        if unitID != nil {
            dictionary["wx_unit_id"] = unitID
        }
        if content != nil {
            dictionary["wx_content"] = content
        }
        if attachment != nil {
            dictionary["wx_attachment"] = attachment
        }

        return dictionary
    }

    public override init() {
        super.init()
    }
}
