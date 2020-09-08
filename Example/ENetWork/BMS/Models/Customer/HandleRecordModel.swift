//
//  HandleRecordModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/19.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class HandleRecordModel: NSObject {

    public var procinstID: String?
    public var tenantID: String?
    public var bizID: String?
    public var enableFlag: String?
    public var handleResult: String?
    public var handleTime: Int?
    public var handleUser: String?
    public var handleUserID: String?
    public var id: String?
    public var orderFlowKey: String?
    public var orderType: Int?
    public var rowTime: Int?
    public var rowVersion: Int?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        procinstID = json["PROC_INST_ID_"].string
        tenantID = json["TENANT_ID"].string
        bizID = json["biz_id"].string
        enableFlag = json["enable_flag"].string
        handleResult = json["handle_result"].string
        handleTime = json["handle_time"].int
        handleUser = json["handle_user"].string
        handleUserID = json["handle_user_id"].string
        id = json["id_"].string
        orderFlowKey = json["order_flow_key"].string
        orderType = json["order_type"].int
        rowTime = json["row_time"].int
        rowVersion = json["row_version"].int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if procinstID != nil {
            dictionary["PROC_INST_ID_"] = procinstID
        }
        if tenantID != nil {
            dictionary["TENANT_ID"] = tenantID
        }
        if bizID != nil {
            dictionary["biz_id"] = bizID
        }
        if enableFlag != nil {
            dictionary["enable_flag"] = enableFlag
        }
        if handleResult != nil {
            dictionary["handle_result"] = handleResult
        }
        if handleTime != nil {
            dictionary["handle_time"] = handleTime
        }
        if handleUser != nil {
            dictionary["handle_user"] = handleUser
        }
        if handleUserID != nil {
            dictionary["handle_user_id"] = handleUserID
        }
        if id != nil {
            dictionary["id_"] = id
        }
        if orderFlowKey != nil {
            dictionary["order_flow_key"] = orderFlowKey
        }
        if orderType != nil {
            dictionary["order_type"] = orderType
        }
        if rowTime != nil {
            dictionary["row_time"] = rowTime
        }
        if rowVersion != nil {
            dictionary["row_version"] = rowVersion
        }
        return dictionary
    }

}
