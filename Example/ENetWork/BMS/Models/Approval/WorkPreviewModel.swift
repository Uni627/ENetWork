//
//  WorkPreviewModel.swift
//  EServices
//
//  Created by pxy on 2019/11/11.
//

import Foundation
import SwiftyJSON

public enum LineType: String {
    case order = "order_classification"
    case multi = "multi_battalion_classification"
    case enginer = "engineering_classification"
    case environmental = "environmental_classification"
    case service = "customer_service_classification"

    public var description: String {
        switch self {
        case .order:
            return "秩序"
        case .multi:
            return "多营"
        case .enginer:
            return "工程"
        case .environmental:
            return "环境"
        case .service:
            return "客服"
        }
    }
}

public class WorkPreviewModel: NSObject {

    public var creationDate: String?
    public var enabledFlag: Int?
    public var ID: String?
    public var isDeleted: Int?
    public var line: String?
    public var lineCode: LineType?
    public var massifID: String?
    public var massifName: String?
    public var planExecutionDate: String?
    public var projectID: String?
    public var projectName: String?
    public var rowTime: String?
    public var rowVersion: String?
    public var updationDate: String?
    public var workGuidanceName: String?
    public var workPlanName: String?

    public var lineName: String?
    public var workPlanID: String?
    public var inspectionType: String?
    public var inspectionTypeName: String?
    public var inspectionWorkPlanName: String?

    public var tenantID: String?
    public var inspectionWorkGuidanceName: String?
    public var desc: String?

    public var cellModelArr: [Any] = []

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        creationDate = json["creationDate"].string
        ID = json["id"].string
        isDeleted = json["isDeleted"].int
        line = json["line"].string
        if let code = json["lineCode"].string {
            lineCode = LineType(rawValue: code)
        }
        massifID = json["massifId"].string
        massifName = json["massifName"].string
        planExecutionDate = json["planExecutionDate"].string
        projectID = json["projectId"].string
        projectName = json["projectName"].string
        rowTime = json["rowTime"].string
        rowVersion = json["rowVersion"].string
        updationDate = json["updationDate"].string
        workGuidanceName = json["workGuidanceName"].string
        workPlanName = json["workPlanName"].string
        lineName = json["lineName"].string
        inspectionType = json["inspectionType"].string
        inspectionTypeName = json["inspectionTypeName"].string
        inspectionWorkPlanName = json["inspectionWorkPlanName"].string
        tenantID = json["tenantId"].string
        inspectionWorkGuidanceName = json["inspectionWorkGuidanceName"].string
        desc = json["description"].string

        workPlanID = json["wpID"].string
        enabledFlag = json["enabledFlag"].int
        isDeleted = json["isDeleted"].int
        inspectionWorkGuidanceName = json["inspectionWorkGuidanceName"].string
        workPlanName = json["workPlanName"].string

//        workPlanID = "87403248038403"
//        projectID = "703803843843434"
//        projectName = "测试工作预览数据"
//        massifID = "230803840384"
//        massifName = "第十六届洛杉矶"
//        line = "2982938"
//        lineName = "工程"
//        inspectionType = "30483048"
//        inspectionTypeName = "kshshjdklshjdskld"
//        inspectionWorkPlanName = "代理商肯德基老实交代老实交代"
//        planExecutionDate = "1574928286033"
//        creationDate = "1574928286000"
//        rowTime = ""
//        rowVersion = ""
//        tenantID = "118302830"
//        enabledFlag = 1
//        isDeleted = 1
//        inspectionWorkGuidanceName = "单身快乐好客山东空手道可"
//        workPlanName = "你菜你猜铲泥"

    }
}
