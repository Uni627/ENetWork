//
//  RepairListModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/17.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

//客户三类工单 状态
public enum CustomerOrderState: String {

    /*
    投诉工单状态（待响应for_response、处理中dealing、待评价return_visit、已关闭closed）
    问询工单状态（处理中dealing、待评价return_visit、已关闭closed）
    报修工单状态（待抢单for_grab、待派单for_comfirm、待响应for_response、处理中dealing、待评价return_visit、已关闭closed）
    */

    ///新生成
    case added              = "added"
    ///待抢单
    case waitGrab           = "for_grab"
    ///待派单
    case waitDistribute     = "for_comfirm"
    ///待派单
    case waitDistribute2    = "for_confirm"
    ///待响应
    case waitResponse       = "for_response"
    ///处理中
    case dealing            = "dealing"
    ///待评价
    case waitComment        = "return_visit"
    ///已关闭
    case closed             = "closed"

    public var description: String {

        switch self {
        case .added:
            return "新生成"
        case .waitGrab:
            return "待抢单"
        case .waitDistribute:
            return "待派单"
        case .waitDistribute2:
            return "待派单"
        case .waitResponse:
            return "待响应"
        case .dealing:
            return "处理中"
        case .waitComment:
            return "待评价"
        case .closed:
            return "已关闭"
        }
    }
}

public class RepairListModel: NSObject {
    ///工单状态
    public var state: CustomerOrderState?
    ///主键
    public var id: String?
    public var procinstTimeOut: String?
    ///响应超时(1：超时)
    
    public var responseTimeOut: String?
    public var assigneeID: String?
    ///报修区域
    public var area: String?
    ///报修区域 id
    public var areaID: String?
    ///报修类别
    public var repairType: String?
    ///报修一级
    public var firstCateLevel: String?
    ///报修一级 id
    public var firstCateLevelID: String?
    ///报修二级
    public var secondCateLevel: String?
    ///报修二级 id
    public var secondCateLevelID: String?
    ///报修三级
    public var thirdCateLevel: String?
    ///报修三级 id
    public var thirdCateLevelID: String?
    ///工单编号
    public var code: String?
    ///报修内容
    public var content: String?
    ///分期
    public var divide: String?
    ///分期 id
    public var divideID: String?
    ///联系电话
    public var mobile: String?
    ///报修时间  整形 毫秒
    public var time: Int?
    ///报修时间  整形转 年月日时分秒
    public var timeStr: String?
    ///报修人
    public var user: String?
    ///报修方式
    public var way: String?
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
    public var ownerID: String?
    ///父流程ID
    public var parentInstID: Int?
    ///父流程节点ID
    public var parentNodeID: Int?
    ///实例id
    
    public var proInsID: String?
    public var returnScore: String?
    public var serviceQualityScore: String?
    public var subject: String?
    ///任务ID
    public var taskID: String?
    ///任务名称
    public var taskName: String?
    ///任务节点ID
    public var taskNodeID: String?
    ///预约上门时间
    public var appointTime: String?
    ///报修预约上门时间段id
    public var appointTimePeriodID: String?
    ///报修预约上门时间段
    public var appointTimePeriod: String?
    ///房产id
    public var houseID: String?
    ///房产信息
    public var house: String?
    /// 房产code
    public var houseCode: String?
    ///楼栋id
    public var buildID: String?
    ///单元id
    public var unitID: String?
    ///报修方式id
    public var wayID: String?
    ///性质评估id
    public var propertyAssID: String?
    ///性质评估
    public var propertyAss: String?
    ///报修图片 集合 字符串
    public var attachment: String?
    ///条线key
    public var lineKey: String?
    ///条线名称
    public var lineName: String?
    ///子cell数据
    ///过期标识（0为不快过期，1为快过期）
    public var isComingTimeOut: Int?

    public var assigneeName: String?
    public var qualfiedNames: String?
    public var qualfieds: String?
    public var returnVisitTimeOut: String?
    public var appState: String?
    public var project: String?
    public var projectID: String?
    public var searchValue: String?


    public var buildName: String?
    public var unitName: String?

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
        area = json["bx_area"].string
        areaID = json["bx_area_id"].string
        firstCateLevel = json["bx_cate_lv1"].string
        firstCateLevelID = json["bx_cate_lv1_id"].string
        secondCateLevel = json["bx_cate_lv2"].string
        secondCateLevelID = json["bx_cate_lv2_id"].string
        thirdCateLevel = json["bx_cate_lv3"].string
        thirdCateLevelID = json["bx_cate_lv3_id"].string
        code = json["bx_code"].string
        content = json["bx_content"].string
        divide = json["bx_dk"].string
        divideID = json["bx_dk_id"].string
        mobile = json["bx_mobile"].string

        time = json["bx_time"].int
        let timeTemp = json["bx_time"].double
        if timeTemp != nil {
            timeStr = timeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        user = json["bx_user"].string
        way = json["bx_way"].string

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

    ///实例id 转换
        
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
        returnScore = json["return_score"].string
        serviceQualityScore = json["service_quality_score"].string
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string
        projectID = json["u_project_id"].string
        isComingTimeOut = json["is_coming_timeout"].int
        house = json["bx_house"].string

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
        if code != nil {
            dictionary["bx_code"] = code
        }
        if time != nil {
            dictionary["bx_time"] = time
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
        if returnScore != nil {
            dictionary["return_score"] = returnScore
        }
        if serviceQualityScore != nil {
            dictionary["service_quality_score"] = serviceQualityScore
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

        if isComingTimeOut != nil {
            dictionary["is_coming_timeout"] = isComingTimeOut
        }

        if divide != nil {
            dictionary["bx_dk"] = divide
        }
        if divideID != nil {
            dictionary["bx_dk_id"] = divideID
        }
        if appointTime != nil {
            dictionary["bx_appoint_time"] = appointTime
        }
        if appointTimePeriodID != nil {
            dictionary["bx_appoint_time_period_id"] = appointTimePeriodID
        }
        if appointTimePeriod != nil {
            dictionary["bx_appoint_time_period"] = appointTimePeriod
        }
        if mobile != nil {
            dictionary["bx_mobile"] = mobile
        }
        if user != nil {
            dictionary["bx_user"] = user
        }
        if houseID != nil {
    ///房产id
            dictionary["bx_house_id"] = houseID
        }
        if house != nil {
    ///房产信息
            dictionary["bx_house"] = house
        }
        if buildID != nil {
    ///楼栋id
            dictionary["bx_build_id"] = buildID
        }
        if unitID != nil {
    ///单元id
            dictionary["bx_unit_id"] = unitID
        }
        if wayID != nil {
            dictionary["bx_way_id"] = wayID
        }
        if way != nil {
            dictionary["bx_way"] = way
        }
        if areaID != nil {
            dictionary["bx_area_id"] = areaID
        }
        if area != nil {
            dictionary["bx_area"] = area
        }
        if propertyAssID != nil {
            dictionary["bx_property_ass_id"] = propertyAssID
        }
        if propertyAss != nil {
            dictionary["bx_property_ass"] = propertyAss
        }
        if content != nil {
            dictionary["bx_content"] = content
        }
        if attachment != nil {
            dictionary["bx_attachment"] = attachment
        }
        if lineKey != nil {
            dictionary["line_key"] = lineKey
        }
        if lineName != nil {
            dictionary["line_name"] = lineName
        }
        if firstCateLevel != nil {
            dictionary["bx_cate_lv1"] = firstCateLevel
        }
        if firstCateLevelID != nil {
            dictionary["bx_cate_lv1_id"] = firstCateLevelID
        }
        if secondCateLevel != nil {
            dictionary["bx_cate_lv2"] = secondCateLevel
        }
        if secondCateLevelID != nil {
            dictionary["bx_cate_lv2_id"] = secondCateLevelID
        }
        if thirdCateLevel != nil {
            dictionary["bx_cate_lv3"] = thirdCateLevel
        }
        if thirdCateLevelID != nil {
            dictionary["bx_cate_lv3_id"] = thirdCateLevelID
        }
        if projectID != nil {
            dictionary["u_project_id"] = thirdCateLevelID
        }

        return dictionary
    }
    public override init() {
        super.init()
    }
}
