//
//  ApproveTypeModel.swift
//  EServices
//
//  Created by pxy on 2019/11/8.
//

import Foundation
import SwiftyJSON

public enum AuditRequestType: String {
    case POSTPONED_PLAN         //计划延期
    case POSTPONED_PATROL       //巡查延期
    case POSTPONED_ALLOCATE     //派工单延期

}

//审批类型 大类
public enum AuditType: String {
    case updatePlan = "INNER_AUDIT_UPDATE_PLAN" //"name":"修改计划"
    case forceClose = "INNER_AUDIT_FORCE_CLOSE" //"name":"强制闭单"
    case createPlan = "INNER_AUDIT_CREATE_PLAN" //"name":"创建计划"
    case postponed = "INNER_AUDIT_POSTPONED" //"name":"工单延期"

    public var description: String {
        switch self {
        case .updatePlan:
            return "修改计划"
        case .forceClose:
            return "强制闭单"
        case .createPlan:
            return "创建计划"
        case .postponed:
            return "工单延期"
        }
    }
}
//审批类型 小类
public enum AuditSubtype: String {

    case updatePatrolPlan = "UPDATE_PATROL_PLAN" //"name":"修改巡查计划"-------修改计划
    case updateWorkPlan = "UPDATE_WORK_PLAN" //"name":"修改工作计划"   --------修改计划

    case forceCloseComPlain = "FORCE_CLOSE_COMPLAIN" //"name":"客户投诉工单"---强制闭单
    case forceCloseEnquiry = "FORCE_CLOSE_ENQUIRY" //"name":"客户问询工单"-----强制闭单
    case forceCloseRepair = "FORCE_CLOSE_REPAIR" //"name":"客户报修工单"-------强制闭单
    case forceClosePatrol = "FORCE_CLOSE_PATROL" //"name":"巡查工单"----------强制闭单
    case forceClosePlan = "FORCE_CLOSE_PLAN" //"name":"计划工单"--------------强制闭单
    case forceCloseAllocate = "FORCE_CLOSE_ALLOCATE" //"name":"派工单"--------强制闭单

    case createWorkPlan = "CREATE_WORK_PLAN" //"name":"创建工作计划"-----------创建计划
    case createPatrolPlan = "CREATE_PATROL_PLAN" //"name":"创建巡查计划"-------创建计划

    case postponedRepair = "POSTPONED_REPAIR" //"name":"客户报修工单"----------工单延期
    case postponedComPlain = "POSTPONED_COMPLAIN" //"name":"客户投诉工单"------工单延期
    case postponedPatrol = "POSTPONED_PATROL" //"name":"巡查工单"-------------工单延期
    case postponedPlan = "POSTPONED_PLAN" //"name":"计划工单"-----------------工单延期
    case postponedAllocate = "POSTPONED_ALLOCATE" //name":"派工单"------------工单延期

    public var description: String {
        switch self {
        case .updatePatrolPlan:
            return "修改巡查计划"
        case .updateWorkPlan:
            return "修改工作计划"
        case .forceCloseComPlain:
            return "客户投诉工单"
        case .forceCloseEnquiry:
            return "客户问询工单"
        case .forceCloseRepair:
            return "客户报修工单"
        case .forceClosePatrol:
            return "巡查工单"
        case .forceClosePlan:
            return "计划工单"
        case .forceCloseAllocate:
            return "派工单"
        case .createWorkPlan:
            return "创建工作计划"
        case .createPatrolPlan:
            return "创建巡查计划"
        case .postponedRepair:
            return "客户报修工单"
        case .postponedComPlain:
            return "客户投诉工单"
        case .postponedPatrol:
            return "巡查工单"
        case .postponedPlan:
            return "计划工单"
        case .postponedAllocate:
            return "派工单"
        }
    }

}

public class ApproveTypeModel: NSObject {

    public var children: [ApproveTypeModel]?
    public var ID: String?
    public var isParent: Bool?
    public var key: String?
    public var name: String?
    public var open: Bool?
    public var parentID: String?
    public var text: String?
    public var typeID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        children = [ApproveTypeModel]()
        let childrenArray = json["children"].arrayValue
        for childrenJson in childrenArray {
            let value = ApproveTypeModel(fromJson: childrenJson)
            children?.append(value)
        }
        ID = json["id"].string
        isParent = json["isParent"].bool
        key = json["key"].string
        name = json["name"].string
        open = json["open"].bool
        parentID = json["parentId"].string
        text = json["text"].string
        typeID = json["typeId"].string
    }

}
