//
//  PatrolSheetModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/12.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import SwiftyJSON

public enum PatrolTaskStatus {
    case planned        //计划中
    case working        //处理中
    case cached         //已处理完成，但未上传服务器
    case finished       //已结束
}

///巡查工单
public class PatrolSheetModel: NSObject {
    public var massifID: String?            ///分期id
    public var massifName: String?          ///分期名称
    public var type: String?                ///条线
    public var itemName: String?            ///线路名称
    public var grid: String?                ///网格
    public var building: String?            ///楼栋
    public var unit: String?                ///单元
    public var taskID: String?              ///工单编号
    public var plannedTime: String?         ///任务截止时间
    public var isTimeout: Bool = false      ///超时
    public var status: PatrolTaskStatus?

    init(fromJson json: JSON) {
        if json.isEmpty {
            return
        }
        massifID = json["massifId"].string
        massifName = json["massifName"].string
        type = json["type"].string

        itemName = json["itemName"].string
        grid = json["grid"].string
        building = json["building"].string
        unit = json["unit"].string

        taskID = json["taskId"].string
        plannedTime = json["plannedTime"].string
        isTimeout = json["isTimeout"].bool ?? false

        let statusStr = json["status"].string
        switch statusStr {
        case "finished":
            status = .finished
        case "working":
            status = .working
        case "cached":
            status = .cached
        default:
            status = .planned
        }
    }
}
