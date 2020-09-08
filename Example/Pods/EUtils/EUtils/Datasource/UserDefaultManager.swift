//
//  UserDefaultManager.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/11.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation

public enum UserDefaultKeys:String {
    //登陆用户相关数据
    case currentUserID      = "UDKCurrentUser"          //当前用户id
    case currentUserName    = "UDKCurrentUserName"      //当前用户名
    case tenantID           = "UDKtenantID"             //所属企业ID
    case tenantAlias        = "UDKtenantAlias"          //所属企业编码
    case savePassword       = "UDKSavePassword"         //是否保存密码
    case cookie             = "UDFMCookie"
    case token              = "UDFMToken"
    case userList           = "UDUserList"              //历史用户列表
    
    //APP属性相关
    case version            = "UDKVersion"              //app版本号
    case UUID               = "UDKUUID"                 //app UUID
}

public let Defaults = UserDefaults.standard

public extension UserDefaults {
    subscript(key:UserDefaultKeys) -> Any? {
        get {
            return self.object(forKey: key.rawValue)
        }
        set {
            self.set(newValue, forKey: key.rawValue)
        }
    }
}
