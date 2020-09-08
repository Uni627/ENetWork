//
//  CheckRecordScanModel.swift
//  EServices
//
//  Created by orichy on 2020/8/25.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON


public class CheckRecordScanModel : NSObject {

    public var checkName : String?
    public var createID : String?
    public var createTime : String?
    public var ID : String?
    public var isDelete : Int?
    public var massifId : String?
    public var massifName : String?
    public var objectId : String?
    public var updateID : String?
    public var updateTime : String?

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        checkName = json["checkName"].string
        createID = json["createId"].string
        createTime = json["createTime"].string
        ID = json["id"].string
        isDelete = json["isDelete"].int
        massifId = json["massifId"].string
        massifName = json["massifName"].string
        objectId = json["objectId"].string
        updateID = json["updateId"].string
        updateTime = json["updateTime"].string
    }
}
