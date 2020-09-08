//
//  DealPeopleModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/5.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DealPeopleModel: NSObject {

    public var code: String?
    public var groupType: String?
    public var ID: String?
    public var name: String?    //名字
    public var postName: String? //职位

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        code = json["code"].string
        groupType = json["groupType"].string
        ID = json["id"].string
        name = json["name"].string
        postName = json["postName"].string
    }

    public override init() {
        super.init()
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if code != nil {
            dictionary["code"] = code
        }
        if groupType != nil {
            dictionary["groupType"] = groupType
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if name != nil {
            dictionary["name"] = name
        }
        if postName != nil {
            dictionary["postName"] = postName
        }

        return dictionary
    }

}
