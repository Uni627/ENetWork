//
//  DutiesUserModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/7.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DutiesUserModel: NSObject {

    public var account: String?
    public var address: String?
    public var birthday: String?
    public var createTime: String?
    public var education: String?
    public var email: String?
    public var entryDate: String?
    public var from: String?
    public var fullName: String?
    public var hasSyncToWx: String?
    public var ID: String?
    public var idCard: String?
    public var isDele: String?
    public var leaveDate: String?
    public var mobile: String?
    public var notifyType: String?
    public var password: String?
    public var pendingCount: Int?  //待处理工单数量
    public var phone: String?
    public var photo: String?
    public var sex: String?
    public var status: Int?
    public var updateTime: String?
    public var userNumber: String?
    public var version: String?
    public var weixin: String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        account = json["account"].string
        address = json["address"].string
        birthday = json["birthday"].string
        createTime = json["createTime"].string
        education = json["education"].string
        email = json["email"].string
        entryDate = json["entryDate"].string
        from = json["from"].string
        fullName = json["fullname"].string
        hasSyncToWx = json["hasSyncToWx"].string
        ID = json["id"].string
        idCard = json["idCard"].string
        isDele = json["isDele"].string
        leaveDate = json["leaveDate"].string
        mobile = json["mobile"].string
        notifyType = json["notifyType"].string
        password = json["password"].string
        pendingCount = json["pendingCount"].int
        phone = json["phone"].string
        photo = json["photo"].string
        sex = json["sex"].string
        status = json["status"].int
        updateTime = json["updateTime"].string
        userNumber = json["userNumber"].string
        version = json["version"].string
        weixin = json["weixin"].string
    }

}
