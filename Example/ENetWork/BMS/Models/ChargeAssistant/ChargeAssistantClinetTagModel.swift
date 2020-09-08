//
//  ChargeAssistantClinetTagModel.swift
//  EServices
//
//  Created by pxy on 2020/4/24.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ChargeAssistantClinetTagModel: NSObject {

    public var tagName: String?
    public var tagValue: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        tagName = json["tagName"].string
        tagValue = json["tagValue"].string
    }

    public override init() {
        super.init()
    }

}
