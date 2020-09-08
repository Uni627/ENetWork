//
//  ChargeAssistantClinetDetailModel.swift
//  EServices
//
//  Created by pxy on 2020/4/23.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantClinetDetailModel: NSObject {

    public var descriptionField: String?
    public var dicIndex: Int?
    public var dicKey: String = ""
    public var dicText: String = ""
    public var dicValue: String?
    public var enabledFlag: Int?
    public var ID: String?
    public var isDeleted: Int?
    public var parentID: String?
    public var rowVersion: Int?
    public var updationDate: Int?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        descriptionField = json["description"].string
        dicIndex = json["dicIndex"].int
        dicKey = json["dicKey"].string ?? ""
        dicText = json["dicText"].string ?? ""
        dicValue = json["dicValue"].string
        enabledFlag = json["enabledFlag"].int
        ID = json["id"].string
        isDeleted = json["isDeleted"].int
        parentID = json["parentId"].string
        rowVersion = json["rowVersion"].int
        updationDate = json["updationDate"].int
    }

    public override init() {
        super.init()
    }

}
