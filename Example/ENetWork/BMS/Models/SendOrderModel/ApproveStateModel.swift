//
//  ApproveStateModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/11/29.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

//审批状态
public enum ApprovalState: String {
    case submit = "submit" //"name":"提交审批"
    case approvaling = "in_approval" //"name":"审批中"
    case approved = "approve" //"name":"已通过"
    case rejected = "reject" //"name":"已驳回"

    public var description: String {
        switch self {
        case .submit:
            return "待审批"
        case .approvaling:
            return "审批中"
        case .approved:
            return "已通过"
        case .rejected:
            return "已驳回"
        }
    }

    public var filterDescription: String {
        switch self {
        case .submit:
            return "提交审批"
        case .approvaling:
            return "审批中"
        case .approved:
            return "已通过"
        case .rejected:
            return "已驳回"
        }
    }
}

public class ApproveStateModel: NSObject {

    public var typeID: String?
    public var parentID: String?
    public var ID: String?
    public var open: Bool?
    public var children: [Any]?
    public var text: String?
    public var key: String?
    public var isParent: Bool?
    public var name: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        typeID = json["typeId"].string
        parentID = json["parentId"].string
        ID = json["id"].string
        open = json["open"].bool
        children = json["children"].arrayObject
        text = json["text"].string
        key = json["key"].string
        isParent = json["isParent"].bool
        name = json["name"].string
    }

}
