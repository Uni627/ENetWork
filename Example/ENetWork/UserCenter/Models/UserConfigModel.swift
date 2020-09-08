//
//  UserConfigModel.swift
//  EServices
//
//  Created by pxy on 2019/11/7.
//

import Foundation
import SwiftyJSON

public class UserConfigModel: NSObject {

    public var createBy: String?       //创建人id
    public var createTime: String?     //创建时间
    public var id: String?             //用户id
    public var isDele: String?         //是否已删，0已删除，1未删除
    public var isNightPattern: Int?    //是否夜间模式（1：是；0：否）
    public var updateBy: String?       //更新人 id
    public var updateTime: String?     //更新时间 年月日 时分秒
    public var userId: String?         //用户id
    public var version: String?        //版本号

    init?(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        createBy = json["createBy"].string
        createTime = json["createTime"].string
        id = json["id"].string
        isDele = json["isDele"].string
        isNightPattern = json["isNightPattern"].int
        updateBy = json["updateBy"].string
        updateTime = json["updateTime"].string
        userId = json["userId"].string
        version = json["version"].string
    }
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if createBy != nil {
            dictionary["createBy"] = createBy
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if id != nil {
            dictionary["id"] = id
        }
        if isDele != nil {
            dictionary["isDele"] = isDele
        }
        if isNightPattern != nil {
            dictionary["isNightPattern"] = isNightPattern
        }
        if updateBy != nil {
            dictionary["updateBy"] = updateBy
        }
        if updateTime != nil {
            dictionary["updateTime"] = updateTime
        }
        if userId != nil {
            dictionary["userId"] = userId
        }
        if version != nil {
            dictionary["version"] = version
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}
