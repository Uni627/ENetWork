//
//  ApproveMessageModel.swift
//  EServices
//
//  Created by pxy on 2019/11/11.
//

import Foundation
import SwiftyJSON

public class ApproveMessageModel: NSObject {

    public var ID: String?
    public var approvalRole: String?
    public var auditDate: Int?
    public var auditID: String?
    public var auditor: String?
    public var auditorID: String?
    public var comment: String?
    public var status: String?
    public var statusName: String?
    public var procInstID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        ID = json["ID_"].string
        approvalRole = json["approvalRole"].string
        auditDate = json["audit_date"].int
        auditID = json["audit_id"].string
        auditor = json["auditor"].string
        auditorID = json["auditor_id"].string
        comment = json["comment"].string
        status = json["status"].string
        statusName = json["statusName"].string
        procInstID = json["PROC_INST_ID"].string
    }

    public init(auditor: String, approvalRole: String) {
        super.init()
        self.auditor = auditor
        self.approvalRole = approvalRole
    }
}
