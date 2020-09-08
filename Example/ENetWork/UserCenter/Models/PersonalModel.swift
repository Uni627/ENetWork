//
//  PersonalModel.swift
//  EServices
//
//  Created by pxy on 2019/11/5.
//

import Foundation
import SwiftyJSON

public class PersonalModel: NSObject, Codable {

    public var account: String?        //登录账号
    public var address: String?        //地址
    public var birthday: String?       //生日
    public var education: String?      //教育背景 学历
    public var email: String?          //邮箱地址
    public var entryDate: String?      //入职日期
    public var from: String?           //来源
    public var fullname: String?       //用户名
    public var id: String?             //用户id
    public var idCard: String?         //身份号
    public var isDelete: String?       //是否删除 （退出） 1已删除 0未删除
    public var mobile: String?         //手机号码
    public var phone: String?          //办公电话
    public var photo: String?          //头像
    public var photoUrl: String?       //头像 具体路径
    public var sex: String?            //性别 男 女
    public var status: Int?            //状态 1：正常；0：禁用；-1：待激活；-2：离职（默认为正常）
    public var updateTime: String?     //更新时间
    public var userNumber: String?     //工作编号
    public var version: Int?           //版本号
    public var workState = false        //上班状态  true: 上班   false: 下班

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        account = json["account"].string
        address = json["address"].string
        birthday = json["birthday"].string
        education = json["education"].string
        email = json["email"].string
        entryDate = json["entryDate"].string
        from = json["from"].string
        fullname = json["fullname"].string
        id = json["id"].string
        idCard = json["idCard"].string
        isDelete = json["isDelete"].string
        mobile = json["mobile"].string
        photo = json["photo"].string
        phone = json["phone"].string
        if let path = photo {
            photoUrl = EServicesConfig.BMSURL + "/media/" + path
        } else {
            photoUrl = EServicesConfig.BMSURL + "/media/" + ""
        }

        sex = json["sex"].string
        status = json["status"].int
        updateTime = json["updateTime"].string
        userNumber = json["userNumber"].string
        version = json["version"].int
    }

    public override init() {

    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if status != nil {
            dictionary["status"] = status
        }
        if account != nil {
            dictionary["account"] = account
        }
        if from != nil {
            dictionary["from"] = from
        }
        if id != nil {
            dictionary["id"] = id
        }
        if updateTime != nil {
            dictionary["updateTime"] = updateTime
        }
        if isDelete != nil {
            dictionary["isDelete"] = isDelete
        }
        if birthday != nil {
            dictionary["birthday"] = birthday
        }
        if version != nil {
            dictionary["version"] = version
        }
        if photo != nil {
            dictionary["photo"] = photo
        }
        if entryDate != nil {
            dictionary["entryDate"] = entryDate
        }
        if fullname != nil {
            dictionary["fullname"] = fullname
        }
        return dictionary
    }
}
