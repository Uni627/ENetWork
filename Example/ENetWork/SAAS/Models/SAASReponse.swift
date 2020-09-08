//
//  SAASReponse.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/25.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import SwiftyJSON

public class SAASReponse: NSObject {

    public var code: String?
    public var data: JSON?
    public var msg: String  = "未知错误"
    public var requestId: String?
    public var state: Bool = false

    public init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        code = json["code"].stringValue
        data = json["data"]
        msg = json["msg"].string ?? "未知错误"
        requestId = json["request_id"].stringValue
        state = json["state"].boolValue
    }
}
