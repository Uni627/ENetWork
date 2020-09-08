//
//  UserModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class UserModel {
    public var id: String
    public var username: String
    public var password: String
    public var nickname: String
    public var token: String

    public init?(fromJson json: JSON!) {
        if json.isEmpty {
            return nil
        }

        id = json["userId"].stringValue
        username = json["account"].stringValue
        nickname = json["username"].stringValue
        token = json["token"].stringValue
        password = json["password"].stringValue
    }

    public init() {
        id = ""
        username = ""
        nickname = ""
        token = ""
        password = ""
    }
}
