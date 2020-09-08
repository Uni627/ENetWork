//
//  TotalRateModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/11/28.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TotalRateModel: NSObject {

    public var todayIncomeRiseRank: Double?
    public var todayArrearsRate: Double?
    public var todayArrearsRiseRank: Double?
    public var orgId: String?
    public var todayIncomeRate: Double?
    public var todayArrearsRise: Double?
    public var todayIncomeRise: Double?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        todayIncomeRiseRank = json["todayIncomeRiseRank"].double
        todayArrearsRate = json["todayArrearsRate"].double
        todayArrearsRiseRank = json["todayArrearsRiseRank"].double
        orgId = json["orgId"].string
        todayIncomeRate = json["todayIncomeRate"].double
        todayArrearsRise = json["todayArrearsRise"].double
        todayIncomeRise = json["todayIncomeRise"].double
    }
}
