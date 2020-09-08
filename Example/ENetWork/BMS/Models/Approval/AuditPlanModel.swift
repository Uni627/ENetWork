//
//  AuditPlanModel.swift
//  EServices
//
//  Created by pxy on 2019/11/11.
//

import Foundation

public struct AuditPlanModel {
    var auditInsID: String
    var auditTaskID: String
    var comment: String
    var actionName: String

    public init(auditInsID: String?, auditTaskID: String?, comment: String?, actionName: String?) {
        self.auditInsID = auditInsID ?? ""
        self.auditTaskID = auditTaskID ?? ""
        self.comment = comment ?? ""
        self.actionName = actionName ?? ""
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        dictionary["auditInsId"] = auditInsID
        dictionary["auditTaskId"] = auditTaskID
        dictionary["comment"] = comment
        dictionary["actionName"] = actionName

        return dictionary
    }
}
