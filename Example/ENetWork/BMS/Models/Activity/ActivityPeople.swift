//
//  ActivityPeople.swift
//  EServices
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 uni. All rights reserved.
//

import SwiftyJSON

public class ActivityPeople: NSObject {

    public override init() {
        super.init()
    }

    public var activityId: String? //活动ID
    public var memberId: String?
//    public var fullname:String?
    public var nikeName: String?
    public var sex: String?
    public var divide: String?
    public var building: String?
    public var unit: String?
    public var roomNumber: String?
    public var telephone: String?
    public var placeholder: String?
    public var cellID: String?
    public var email: String?
    public var houseJson: String?

    public var type = 1 //0不显示，1 显示添加 2 显示删除和添加 3 显示删除
    public var sourceType = 0 //0 用户添加 1 通讯录添加

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if houseJson != nil {
            dictionary["houseJson"] = houseJson
        }
        if email != nil {
            dictionary["email"] = email
        }
        if activityId != nil {
            dictionary["activityId"] = activityId
        }
        if memberId != nil {
            dictionary["memberId"] = memberId
        }
//        if fullname != nil{
//            dictionary["fullname"] = fullname
//        }
        if nikeName != nil {
            dictionary["nikeName"] = nikeName
        }
        if sex != nil {
            dictionary["sex"] = sex
        }
        if divide != nil {
            dictionary["divide"] = divide
        }
        if building != nil {
            dictionary["building"] = building
        }
        if telephone != nil {
            dictionary["telephone"] = telephone
        }
        if roomNumber != nil {
            dictionary["roomNumber"] = roomNumber
        }

        return dictionary
    }

}
