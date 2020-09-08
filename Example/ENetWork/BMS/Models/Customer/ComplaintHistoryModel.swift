//
//  ComplaintHistoryModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/18.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ComplaintHistoryModel: NSObject {

    public var state: CustomerOrderState?      //工单状态

    public var attachment: String?
    public var buildID: String?
    public var cate: String?
    public var cateID: String?
    public var code: String?
    public var content: String?
    public var divide: String?
    public var divideID: String?
    public var house: String?
    public var houseID: String?
    public var mobile: String?
    public var property: String?
    public var propertyID: String?
    public var recorder: String?
    public var recorderID: String?
    public var time: Int?
    public var unitID: String?
    public var user: String?
    public var userID: String?
    public var way: String?
    public var wayID: String?
    public var id: String?
    public var procinstID: String?
    public var refID: String?
    public var tenantID: String?
    public var deadLineTime: Int?
    public var isSolve: Int?
    public var createTime: Int?            //创建时间 整形 毫秒
    public var createTimeStr: String?      //创建时间 整形转 年月日时分秒
    public var closeIsApplying: Int?
    public var parentInstID: String?
    public var proInsID: String?
    public var responseTimeout: Int?
    public var rowTime: Int?
    public var rowVersion: Int?
    public var status: String?
    public var taskNodeID: String?
    public var project: String?
    public var projectID: String?
    public var workOrderTimeOut: Int?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        if let type = json["F_state"].string {
            state = CustomerOrderState(rawValue: type)
        }

        attachment = json["F_ts_attachment"].string
        buildID = json["F_ts_build_id"].string
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
        recorder = json["F_ts_recorder"].string
        recorderID = json["F_ts_recorder_id"].string
        time = json["F_ts_time"].int
        unitID = json["F_ts_unit_id"].string
        user = json["F_ts_user"].string
        userID = json["F_ts_user_id"].string
        way = json["F_ts_way"].string
        wayID = json["F_ts_way_id"].string
        id = json["ID_"].string
        procinstID = json["PROC_INST_ID_"].string
        refID = json["REF_ID_"].string
        tenantID = json["TENANT_ID"].string
        deadLineTime = json["c_deadline_time"].int
        isSolve = json["c_is_solve"].int

        createTime = json["createTime"].int
        let createTimeTemp = json["createTime"].double
        if createTimeTemp != nil {
            createTimeStr = createTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        closeIsApplying = json["fclose_is_applying"].int
        parentInstID = json["parentInstId"].string
        proInsID = json["proInsId"].string
        responseTimeout = json["response_timeout"].int
        rowTime = json["row_time"].int
        rowVersion = json["row_version"].int
        status = json["status"].string
        taskNodeID = json["taskNodeId"].string
        project = json["u_project"].string
        projectID = json["u_project_id"].string
        workOrderTimeOut = json["work_order_timeout"].int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if state != nil {
            dictionary["F_state"] = state
        }
        if attachment != nil {
            dictionary["F_ts_attachment"] = attachment
        }
        if buildID != nil {
            dictionary["F_ts_build_id"] = buildID
        }
        if cate != nil {
            dictionary["F_ts_cate"] = cate
        }
        if cateID != nil {
            dictionary["F_ts_cate_id"] = cateID
        }
        if code != nil {
            dictionary["F_ts_code"] = code
        }
        if content != nil {
            dictionary["F_ts_content"] = content
        }
        if divide != nil {
            dictionary["F_ts_dk"] = divide
        }
        if divideID != nil {
            dictionary["F_ts_dk_id"] = divideID
        }
        if house != nil {
            dictionary["F_ts_house"] = house
        }
        if houseID != nil {
            dictionary["F_ts_house_id"] = houseID
        }
        if mobile != nil {
            dictionary["F_ts_mobile"] = mobile
        }
        if property != nil {
            dictionary["F_ts_property"] = property
        }
        if propertyID != nil {
            dictionary["F_ts_property_id"] = propertyID
        }
        if recorder != nil {
            dictionary["F_ts_recorder"] = recorder
        }
        if recorderID != nil {
            dictionary["F_ts_recorder_id"] = recorderID
        }
        if time != nil {
            dictionary["F_ts_time"] = time
        }
        if unitID != nil {
            dictionary["F_ts_unit_id"] = unitID
        }
        if user != nil {
            dictionary["F_ts_user"] = user
        }
        if userID != nil {
            dictionary["F_ts_user_id"] = userID
        }
        if way != nil {
            dictionary["F_ts_way"] = way
        }
        if wayID != nil {
            dictionary["F_ts_way_id"] = wayID
        }
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
            dictionary["TENANT_ID"] = tenantID
        }
        if deadLineTime != nil {
            dictionary["c_deadline_time"] = deadLineTime
        }
        if isSolve != nil {
            dictionary["c_is_solve"] = isSolve
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if closeIsApplying != nil {
            dictionary["fclose_is_applying"] = closeIsApplying
        }
        if parentInstID != nil {
            dictionary["parentInstId"] = parentInstID
        }
        if proInsID != nil {
            dictionary["proInsId"] = proInsID
        }
        if responseTimeout != nil {
            dictionary["response_timeout"] = responseTimeout
        }
        if rowTime != nil {
            dictionary["row_time"] = rowTime
        }
        if rowVersion != nil {
            dictionary["row_version"] = rowVersion
        }
        if status != nil {
            dictionary["status"] = status
        }
        if taskNodeID != nil {
            dictionary["taskNodeId"] = taskNodeID
        }
        if project != nil {
            dictionary["u_project"] = project
        }
        if projectID != nil {
            dictionary["u_project_id"] = projectID
        }
        if workOrderTimeOut != nil {
            dictionary["work_order_timeout"] = workOrderTimeOut
        }
        return dictionary
    }
}
