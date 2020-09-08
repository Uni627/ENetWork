//
//  ApprovalHistoryFlowModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/10.
//  Copyright © 2019 uni. All rights reserved.
//

import ENetWork
import SwiftyJSON

public class ApprovalHistoryFlowModel: NSObject {

    public var assignTime: String?
    public var auditor: String?       //执行人id
    public var auditorName: String?   //执行人名称
    public var completeTime: String?  //处理时间
    public var createOrgID: String?
    public var createTime: Int?    //创建时间
    public var durMs: Int?
    public var files: String?
    public var filesArray: [PictureModel] = [] //附件 图片转model
    public var formDefID: String?
    public var formName: String?
    public var ID: String?
    public var interpose: Int?
    public var isRowSpan: Bool?
    public var opinion: String?       //意见
    public var procDefID: String?
    public var procInstID: String?
    public var qualfiedNames: String?  //待执行人名称
    public var qualfieds: String?
    public var rowSpan: Int?
    public var status: String?       //状态
    public var statusVal: String?    //具体状态 用这个就可以
    public var supInstID: String?
    public var taskID: String?
    public var taskKey: String?
    public var taskName: String?     //任务节点名称
    public var taskeyName: String?   //任务节点名称 新加

    public var token: String?


    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        
        assignTime = json["assignTime"].string
        auditor = json["auditor"].string
        auditorName = json["auditorName"].string
        completeTime = json["completeTime"].string
        createOrgID = json["createOrgId"].string
        createTime = json["createTime"].int
        durMs = json["durMs"].int

        files = json["files"].string
        filesArray = [PictureModel]() //图片集合
        let tempFiles = json["files"].stringValue
        if let jsonData = tempFiles.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    filesArray.append(model)
                }
            }
        }

        formDefID = json["formDefId"].string
        formName = json["formName"].string
        ID = json["id"].string
        interpose = json["interpose"].int
        isRowSpan = json["isRowSpan"].bool
        opinion = json["opinion"].string
        procDefID = json["procDefId"].string
        procInstID = json["procInstId"].string
        qualfiedNames = json["qualfiedNames"].string
        qualfieds = json["qualfieds"].string
        rowSpan = json["rowSpan"].int
        status = json["status"].string
        statusVal = json["statusVal"].string
        supInstID = json["supInstId"].string
        taskID = json["taskId"].string
        taskKey = json["taskKey"].string
        if let taskKeyStr = json["taskKey"].string {
            switch taskKeyStr {
            case "NewComplain":
                taskeyName = "创建工单"
            case "DispatchOrder":
                taskeyName = "创建工单"
            case "NewEnquiry":
                taskeyName = "创建工单"
            case "NewRepair":
                taskeyName = "创建工单"
            case "Confirm":
                taskeyName = "派单"
            case "Response":
                taskeyName = "响应"
            case "RaiseLv21":
                taskeyName = "响应超时批复"
            case "Handle":
                taskeyName = "处理"
            case "ProcessOrder":
                taskeyName = "处理"
            case "CheckOrder":
                taskeyName = "验收"
            case "ReturnVisit":
                taskeyName = "评价"
            case "RaiseLv1":
                taskeyName = "处理超时(第一次)"
            case "RaiseLv2":
                taskeyName = "处理超时(第二次)"
            case "RaiseLv3":
                taskeyName = "处理超时(第三次)"
            case "ConfirmCateAndAssignOrBrab":
                taskeyName = "派单"
            case "WorkOrderPoolGrab":
                taskeyName = "抢单"
            case "OvertimeMandatoryAssign":
                taskeyName = "强制派单"
            case "EndEvent":
                taskeyName = "结束"
            case "UserTask6":
                taskeyName = "批复"
            case "UserTask7":
                taskeyName = "批复"
            case "UserTask3":
                taskeyName = "创建工单"
            case "waiting":
                taskeyName = "等待"
            case "Waiting":
                taskeyName = "等待"
            case "UserTask4":
                taskeyName = "接单"
            case "UserTask5":
                taskeyName = "强制派单"
            case "UserTask1":
                taskeyName = "处理"
            case "EndEvent1":
                taskeyName = "结束"
                
            default:
                  taskeyName = ""
              }
        }
       
        
        taskName = json["taskName"].string
        token = json["token"].string
        
    }

}
