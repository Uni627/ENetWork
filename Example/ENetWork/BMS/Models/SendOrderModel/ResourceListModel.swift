//
//  ResourceListModel.swift
//  EServices
//
//  Created by pxy on 2020/5/9.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum ResourceOrderStatus: String { //工单状态 1:待响应，2:处理中，3:验收中，4:已完成
    case none       = "0"
    case new        = "1"
    case handle     = "2"
    case acceptance = "3"
    case done       = "4"
    case receive    = "5"
    case designate  = "6"
    
    public var description: String {
        switch self {
        case .new:
            return "新生成"
        case .handle:
            return "处理中"
        case .acceptance:
            return "待验收"
        case .receive:
            return "待接单"
        case .designate:
            return "待派单"
        case .done:
            return "已关闭"
        case .none:
            return ""
        }
    }

    public var image: String {
        switch self {
        case .new, .receive, .designate:
            return "repair_status_grab"
        case .handle:
            return "repair_status_process"
        case .acceptance:
            return "repair_status_respond"
        case .done:
            return "repair_status_close"
        case .none:
            return ""
        }
    }
}

public enum PatrolOrderStatus: Int { //工单状态 1:新生成，2:处理中，3:验收中，4:已完成
    case none       = 0
    case new        = 1
    case handle     = 2
    case acceptance = 3
    case done       = 4
    case receive    = 5
    case designate  = 6

    public var description: String {
        switch self {
        case .new:
            return "新生成"
        case .handle:
            return "处理中"
        case .acceptance:
            return "待验收"
        case .done:
            return "已关闭"
        case .receive:
            return "待接单"
        case .designate:
            return "待派单"
        case .none:
            return ""
        }
    }

    public var image: String {
        switch self {
        case .new, .receive, .designate:
            return "repair_status_grab"
        case .handle:
            return "repair_status_process"
        case .acceptance:
            return "repair_status_respond"
        case .done:
            return "repair_status_close"
        case .none:
            return ""
        }
    }
}

public enum ResourceMessageType: String { //工单状态 1:待响应，2:处理中，3:验收中，4:已完成
    case dispatch   = "dispatch_order"   //派工单
    case plan       = "plan_order"      //计划工单
    case patrol     = "patrol_order"    //巡更工单
}

public class ResourceListModel: NSObject {

    public var createDate: Int?
    public var deadline: Int?
    public var divideName: String?
    public var ID: String?
    public var lineCode: String?
    public var lineID: String?
    public var lineName: String?
    public var location: String?
    public var orderNo: String?
    public var overTime = false
    public var status: ResourceOrderStatus = .none
    public var patrolStatus: PatrolOrderStatus = .none

    public var orderTitle: String?
    public var planName: String?

    public var orderType: String?
    public var postponeStatus: Int?
    public var principalName: String?
    public var resName: String?
    public var workOrderType: ResourceMessageType?
    public var workflowID: String?
    public var taskNodeID: String?
    public var taskID: String?
    public var proInsID: String?
    public var inspectionPlanName: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        createDate = json["createDate"].int
        deadline = json["deadline"].int
        divideName = json["divideName"].string
        ID = json["id"].string
        lineCode = json["lineCode"].string
        lineID = json["lineId"].string
        lineName = json["lineName"].string
        location = json["location"].string
        orderNo = json["orderNo"].string
        overTime = json["orderOverTime"].int == 1 ? true : false
        status = ResourceOrderStatus.init(rawValue: json["orderStatus"].string ?? "0") ?? .none
        patrolStatus = PatrolOrderStatus.init(rawValue: json["orderStatus"].int ?? 0) ?? .none

        orderTitle = json["orderTitle"].string
        orderType = json["orderType"].string
        postponeStatus = json["postponeStatus"].int
        principalName = json["principalName"].string
        resName = json["resName"].string
        workOrderType = ResourceMessageType.init(rawValue: json["workOrderType"].string ?? "" )
        workflowID = json["workflowId"].string
        taskNodeID = json["taskNodeId"].string

        taskID = json["taskId"].string
        proInsID = json["PROC_INST_ID_"].string
        inspectionPlanName = json["F_inspection_work_plan_name"].string
        planName = json["planName"].string
    }

}
