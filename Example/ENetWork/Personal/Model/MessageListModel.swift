//
//  MessageListModel.swift
//  EServices
//
//  Created by pxy on 2020/3/10.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum NoticeMessageMainType: String {
    case grab               = "grab"            //抢单
    case reminder           = "reminder"        //新待处理工单提醒
    case copyto             = "copyto"          //抄送提醒
    case end                = "end"             //强制闭单通过提醒-关单提醒
    case approval           = "approval"        //审批
    case turn               = "turn"            //转单提醒
    case commuSend          = "commuSend"       //沟通
    case commuFeedBack      = "commuFeedBack"   //沟通反馈
    case bpmnApproval       = "bpmnApproval"    //强制闭单通过提醒-关单提醒
    case bpmnApprovalEnd    = "bpmnApprovalEnd" //审批结果提醒
    case none               = "none"
}

public enum NoticeMessageSubType: String {
    case repair         = "repair"      //报修
    case audit          = "audit"       //审批
    case dispatch       = "dispatch"    //派工单
    case plan           = "plan"        //计划工单
    case inspection     = "inspection"  //巡查工单
    case patrol         = "patrol"      //巡更工单
    case unqualified    = "unqualified" //不合格单
    case complain       = "complain"    //客户投诉
    case enquiry        = "enquiry"     //客户问询
    case none           = "none"
}

public class MessageListModel: NSObject {

    public var canReply: Int?
    public var content: String?
    public var createOrgId: String?
    public var detailUrl: String?
    public var extendVars: String?
    public var fileMsg: String?
    public var hasRead: Bool = false
    public var ID: String?
    public var isPublic: Int?
    public var messageType: String?
    public var owner: String?
    public var ownerId: String?
    public var receiveTime: String?
    public var receiverId: String?
    public var receiverName: String?
    public var receiverOrgId: String?
    public var receiverOrgName: String?
    public var rid: String?
    public var subject: String?
    public var templateKey: String?
    public var sendTime: String?
    public var mainType: NoticeMessageMainType = .none
    public var subType: NoticeMessageSubType = .none
    public var taskID: String?
    public var proInstanceID: String?
    public var cateName: String?
    public var approvalID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        canReply = json["canReply"].int
        content = json["content"].string
        createOrgId = json["createOrgId"].string
        detailUrl = json["detailUrl"].string
        extendVars = json["extendVars"].string
        fileMsg = json["fileMsg"].string
        hasRead = json["hasRead"].bool ?? false
        ID = json["id"].string
        isPublic = json["isPublic"].int
        messageType = json["messageType"].string
        owner = json["owner"].string
        ownerId = json["ownerId"].string
        receiveTime = json["receiveTime"].string
        receiverId = json["receiverId"].string
        receiverName = json["receiverName"].string
        receiverOrgId = json["receiverOrgId"].string
        receiverOrgName = json["receiverOrgName"].string
        rid = json["rid"].string
        subject = json["subject"].string
        templateKey = json["templateKey"].string
        sendTime = json["sendTime"].string

        if let extend = extendVars {
            if let jsonData = extend.data(using: .utf8) {
                let extendJson = JSON(jsonData)
                if let m_type = extendJson["type"].string {
                    mainType = NoticeMessageMainType.init(rawValue: m_type) ?? .none
                }
                if let m_subType = extendJson["subType"].string {
                    subType = NoticeMessageSubType.init(rawValue: m_subType) ?? .none
                }
                taskID = extendJson["content"]["taskId"].string
                proInstanceID = extendJson["content"]["procInstId"].string
                cateName = extendJson["content"]["cateName"].string
                approvalID = extendJson["content"]["id"].string
            }
        }
    }

    override init() {
        super.init()
    }
}
