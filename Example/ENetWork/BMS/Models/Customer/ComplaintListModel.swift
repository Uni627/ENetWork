//
//  ComplaintListModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/17.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ComplaintListModel: NSObject {
    ///工单状态
    public var state: CustomerOrderState?
    ///投诉类别
    public var cate: String?
    ///投诉类别 id
    public var cateID: String?
    ///工单编号
    public var code: String?
    ///投诉内容
    public var content: String?
    ///分期
    public var divide: String?
    ///分期id
    public var divideID: String?
    ///分期code
    public var divideCode: String?
    ///房产
    public var house: String?
    ///房产id
    public var houseID: String?
    ///房产code
    public var houseCode: String?
    ///楼栋id
    public var buildID: String?
    public var buildName: String?

    ///单元id
    public var unitID: String?
    public var unitName: String?

    ///联系电话
    public var mobile: String?
    ///投诉性质
    public var property: String?
    ///投诉性质 id
    public var propertyID: String?
    ///投诉时间 整形 毫秒
    public var time: Int?
    ///投诉时间 整形 转 年月日时分秒
    public var timeStr: String?
    ///投诉人
    public var user: String?
    ///主键 id
    public var id: String?
    public var procinstTimeOut: String?
    ///响应超时(1：超时)
    public var responseTimeOut: String?
    public var assigneeID: String?
    //完成截止时间 整形 毫秒
    public var deadLineTime: Int?
    //完成截止时间 整形转 年月日时分秒
    public var deadLineTimeStr: String?
    //创建时间 整形 毫秒
    public var createTime: Int?
    //创建时间 整形转 年月日时分秒
    public var createTimeStr: String?
    public var instanceID: String?
    public var isReturnTimeOut: String?
    public var ownerID: String?
    ///父流程实例id
    public var parentInstID: Int?
    ///父流程节点id
    public var parentNodeID: Int?
    //实例id
    public var proInsID: String?
    public var subject: String?
    ///任务ID
    public var taskID: String?
    ///任务名称
    public var taskName: String?
    ///任务节点ID
    public var taskNodeID: String?
    //投诉方式 id
    public var wayID: String?
    //投诉方式
    public var way: String?
    //条线key
    public var lineKey: String?
    //条线名称
    public var lineName: String?
    //投诉图片 集合 字符串
    public var attachment: String?
    //过期标识（0为不快过期，1为快过期
    public var isComingTimeOut: Int?

    public var assigneeName: String?
    ///接单时间
    public var receiveTime: Int?
    public var receiveTimeStr: String? //
    public var qualfiedNames: String?
    public var qualfieds: String?
    ///回访超时
    public var returnVisitTimeOut: String?
    public var project: String?
    public var projectID: String?
    public var searchValue: String?
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        if let type = json["F_state"].string {
            state = CustomerOrderState(rawValue: type)
        }

        cate = json["F_ts_cate"].string
        cateID = json["F_ts_cate_id"].string
        code = json["F_ts_code"].string
        content = json["F_ts_content"].string
        divide = json["F_ts_dk"].string
        divideID = json["F_ts_dk_id"].string
        house = json["F_ts_house"].string
        houseID = json["F_ts_house_id"].string

        mobile = json["F_ts_mobile"].string
        property = json["F_ts_property"].string
        propertyID = json["F_ts_property_id"].string

        time = json["F_ts_time"].int
        let timeStrTemp = json["F_ts_time"].double
        if timeStrTemp != nil {
            timeStr = timeStrTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        user = json["F_ts_user"].string
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

        isComingTimeOut = json["is_coming_timeout"].int
        project = json["u_project"].string
        projectID = json["u_project_id"].string
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if state != nil {
            dictionary["F_state"] = state
        }
        if code != nil {
            dictionary["F_ts_code"] = code
        }
        if time != nil {
            dictionary["F_ts_time"] = time
        }
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
        if isComingTimeOut != nil {
            dictionary["is_coming_timeout"] = isComingTimeOut
        }

        if divide != nil {
            dictionary["F_ts_dk"] = divide
        }
        if divideID != nil {
            dictionary["F_ts_dk_id"] = divideID
        }
        if mobile != nil {
            dictionary["F_ts_mobile"] = mobile
        }
        if user != nil {
            dictionary["F_ts_user"] = user
        }
        if houseID != nil {
            dictionary["F_ts_house_id"] = houseID
        }
        if house != nil {
            dictionary["F_ts_house"] = house
        }
        if buildID != nil {
            dictionary["F_ts_build_id"] = buildID
        }
        if unitID != nil {
            dictionary["F_ts_unit_id"] = unitID
        }
        if propertyID != nil {
            dictionary["F_ts_property_id"] = propertyID
        }
        if property != nil {
            dictionary["F_ts_property"] = property
        }
        if wayID != nil {
            dictionary["F_ts_way_id"] = wayID
        }
        if way != nil {
            dictionary["F_ts_way"] = way
        }
        if cateID != nil {
            dictionary["F_ts_cate_id"] = cateID
        }
        if cate != nil {
            dictionary["F_ts_cate"] = cate
        }
        if lineKey != nil {
            dictionary["F_line_key"] = lineKey
        }
        if lineName != nil {
            dictionary["F_line_name"] = lineName
        }
        if content != nil {
            dictionary["F_ts_content"] = content
        }
        if attachment != nil {
            dictionary["F_ts_attachment"] = attachment
        }

        return dictionary
    }

    public override init() {
        super.init()
    }
}
