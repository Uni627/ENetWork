//
//  PatrolPointModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/12.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import SwiftyJSON

public class PatrolPointModel: NSObject {
    public var index: Int = 0
    public var ID: String?
    public var location: String?    ///位置
    public var type: Int = 0        //TODO: enum类型？

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        index = json["index"].int ?? 0
        location = json["location"].string
        ID = json["id"].string
        type = json["type"].int ?? 0
    }
}
