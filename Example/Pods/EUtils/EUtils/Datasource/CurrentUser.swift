//
//  CurrentUser.swift
//  当前用户信息
//
//  Created by LynnCheng on 2019/10/11.
//  Copyright © 2019 LynnCheng. All rights reserved.
//
import Foundation

public enum userStatus {
    case unSignUp
    case unSignIn
    case normal
    case signInTimeout
    case locked
}

//TODO: 维护用户的登录状态

///当前登录用户相关信息
public class CurrentUser:NSObject {
    ///用户ID
    static var cachedUserID:String? = nil
    public static var userID:String? {
        get {
            return cachedUserID ?? Defaults[.currentUserID] as? String
        }
        
        set {
            cachedUserID = newValue
            Defaults[.currentUserID] = newValue
        }
    }
    
    ///用户名
    public static var username:String? {
        get {
            return Defaults[.currentUserName] as? String
        }
        
        set {
            guard let name = newValue else {
                return
            }
            
            Defaults[.currentUserName] = name
            
            var array:[String] = Defaults[.userList] as? [String] ?? []
            if array.contains(name) {
                if let index = array.firstIndex(of: name) {
                    array.remove(at: index)
                }
            }
            array.insert(name, at: 0)
            Defaults[.userList] = array
        }
    }
    
    ///鉴权token
    static var cachedToken:String? = nil
    public static var token:String? {
        get {
            return cachedToken ?? EKeychain[(username ?? "") + "Token"]
        }
        
        set {
            if let user = username {
                cachedToken = newValue
                EKeychain[user + "Token"] = newValue
            }
        }
    }
    
    //租户名称
    public static var tenantCode:String? {
        get {
            return Defaults[.tenantAlias] as? String
        }
        
        set {
            Defaults[.tenantAlias] = newValue
        }
    }
    //租户ID
    static var cachedTenantID:String? = nil
    public static var tenantID:String? {
        get {
            return cachedTenantID ?? Defaults[.tenantID] as? String
        }
        
        set {
            cachedTenantID = newValue
            Defaults[.tenantID] = newValue
        }
    }
    
    ///密码
    public static var password:String? {
        get {
            if username != nil && savePassword {
                return EKeychain[username!]
            } else {
                return ""
            }
        }
        
        set {
            if let user = username {
                EKeychain[user] = newValue
            }
        }
    }
    
    ///是否保存密码
    public static var savePassword:Bool {
        get {
            return Defaults[.savePassword] as? Bool ?? true
        }
        set {
            Defaults[.savePassword] = newValue
        }
    }
    
    ///历史用户列表
    public static var userList:[String] {
        return (Defaults[.userList] as? [String]) ?? []
    }
}
