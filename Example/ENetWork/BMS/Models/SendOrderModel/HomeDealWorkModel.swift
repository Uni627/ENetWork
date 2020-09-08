//
//  HomeDealWorkModel.swift
//  EServices
//
//  Created by pxy on 2019/11/6.
//

import Foundation
import SwiftyJSON

public class HomeDealWorkModel: NSObject {

    public var lineOrderArray: [LineOrderModel] = []
    public var workOrderArray: [WorkDetailOrderModel] = []
    public var rate: RateModel?

    public override init() {

    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        lineOrderArray = [LineOrderModel]()
        let lineOrderList = json["lineOrder"].arrayValue
        for lineOrderJson in lineOrderList {
            let value = LineOrderModel(fromJson: lineOrderJson)
            lineOrderArray.append(value)
        }

        workOrderArray = [WorkDetailOrderModel]()
        let workOrderList = json["workOrder"].arrayValue
        for workOrderJson in workOrderList {
            let value = WorkDetailOrderModel(fromJson: workOrderJson)
            workOrderArray.append(value)
        }

        let rateJson = json["rate"]
        if !rateJson.isEmpty {
            rate = RateModel(fromJson: rateJson)
        }
    }
}

public class LineOrderModel: NSObject {

    public var timelyNum: Int?
    public var unfinishedNum: Int = 0
    public var count: Int?
    public var name: String?
    public var completedNum: Int = 0
    public var type: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        timelyNum = json["timely_num"].int
        unfinishedNum = json["unfinished_num"].int ?? 0
        count = json["count"].int
        name = json["name"].string
        completedNum = json["completed_num"].int ?? 0
        type = json["type"].string
    }
}

public class WorkDetailOrderModel: NSObject {

    public var timelyNum: Int?
    public var unfinishedNum: Int?
    public var count: Int = 0
    public var name: String?
    public var completedNum: Int?
    public var type: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        timelyNum = json["timely_num"].int
        unfinishedNum = json["unfinished_num"].int
        count = json["count"].int ?? 0
        name = json["name"].string
        completedNum = json["completed_num"].int
        type = json["type"].string
    }
}

public class RateModel: NSObject {

    public var completedRate: String?
    public var timelyRate: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        completedRate = json["completedRate"].string
        timelyRate = json["timelyRate"].string

    }
}
