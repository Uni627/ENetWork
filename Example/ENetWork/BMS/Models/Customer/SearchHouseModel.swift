//
//  SearchHouseModel.swift
//  EServices
//
//  Created by uni on 2020/8/24.
//  Copyright © 2020 EinYun. All rights reserved.
//

import UIKit
import SwiftyJSON

public class SearchHouseModel: NSObject {

    public var id: String?
    public var houseInnerName: String?
    public var houseCode: String?

    public var buildingId: String?
    public var buildingName: String?

    public var unitId: String?
    public var unitCode: String?
    public var unitName: String?


    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        id = json["id"].stringValue
        houseInnerName = json["houseInnerName"].stringValue
        houseCode = json["houseCode"].stringValue

        buildingId = json["buildingId"].stringValue
        buildingName = json["buildingName"].stringValue

        unitId = json["unitId"].stringValue
        unitCode = json["unitCode"].stringValue
        unitName = json["unitName"].stringValue


    }
/*
    "isDeleted" : 0,
          "measuredArea" : 143.77000000000001,
          "id" : "ops-F4C8CC90-1783-40AB-98EC-C5EF71B3219A",
          "propertyType" : "0",
          "floor" : 16,
          "updatedBy" : "509b5b71-174a-4bac-bce1-7cb2bbda64e7",
          "projectId" : null,
          "usedArea" : null,
          "creationDate" : 1482572037000,
          "buildingId" : "ops-6854C0B8-BCC4-49ED-AE61-13F692AF88D5",
          "contractId" : null,
          "platProjectId" : null,
          "contractFlag" : null,
          "batchId" : null,
          "corpId" : "",
          "feeArea" : 143.77000000000001,
          "buildingName" : "27幢2单元",
          "platDivideId" : null,
          "houseCode" : "27-02-1204",
          "restoreOriginalDate" : null,
          "createdBy" : "509b5b71-174a-4bac-bce1-7cb2bbda64e7",
          "sapId" : null,
          "updationDate" : 1592218112000,
          "actualAddress" : null,
          "unitCode" : null,
          "sfGuid" : null,
          "unitId" : "ops-0de726f4-06b8-11ea-b427-005056a13fb9",
          "projectCode" : null,
          "isInvented" : null,
          "divideId" : "ops-26B81BCE-29A0-4982-B49A-A553C973B7E7",
          "projectName" : null,
          "houseInnerName" : "27-02-27-02-1204",
          "totalArrearage" : null,
          "buildingArea" : null,
          "platProjectName" : null,
          "divideCode" : null,
          "divideName" : "ops-金域蓝湾",
          "startDate" : null,
          "wbsCode" : null,
          "predictedArea" : null,
          "enabledFlag" : 1,
          "reason" : null,
          "rowVersion" : null,
          "remark" : null,
          "platDivideName" : null,
          "houseState" : null

 */
}
