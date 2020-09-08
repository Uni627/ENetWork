//
//  CustomerDelayModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/21.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CustomerDelayModel: NSObject {

    public var delayDayNum: Int?       //不需要用
    public var delayNum: Int?          //延期次数
    public var isComplete: Bool?       //true可发起申请，false代表当前正在申请中
    public var sum: Int?               //延期总时

    public override init() {
        super.init()
    }
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        delayDayNum = json["delayDayNum"].int
        delayNum = json["delayNum"].int
        isComplete = json["isComplete"].bool
        sum = json["sum"].int
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if delayDayNum != nil {
            dictionary["delayDayNum"] = delayDayNum
        }
        if delayNum != nil {
            dictionary["delayNum"] = delayNum
        }
        if isComplete != nil {
            dictionary["isComplete"] = isComplete
        }
        if sum != nil {
            dictionary["sum"] = sum
        }
        return dictionary
    }
}
