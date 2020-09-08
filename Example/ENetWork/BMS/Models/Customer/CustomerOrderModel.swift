//
//  CustomerOrderModel.swift
//  EServices
//
//  Created by pxy on 2019/12/16.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CustomerOrderModel: NSObject {

    public var id: String?                             //主键
    public var pocinstTimeOut: String?                 //
    public var responseTimeOut: String?                //
    public var assigneeID: String?                     //
    public var area: String?                           //报修区域
    public var areaID: String?                         //报修区域id
    public var firstCateLevel: String?                 //报修类别（一级）
    public var secondCateLevel: String?                //报修类别（二级）
    public var secondCateLevelID: String?              //报修类别id（二级）
    public var thirdCateLevel: String?                 //报修类别（三级）
    public var thirdCateLevelID: String?               //报修类别id（三级）
    public var code: String?                           //工单编号
    public var content: String?                        //报修内容
    public var plot: String?                           //地块名称
    public var plotID: String?                         //地块id
    public var mobile: String?                         //联系电话
    public var time: Int?                              //报修时间
    public var user: String?                           //报修人
    public var way: String?                            //报修方式
    public var deadlineTime: Int?                      //完成截止时间
    public var createTime: Int?                        //创建时间
    public var instanceID: String?                     //
    public var isReturnTimeOut: String?                //是否超时
    public var ownerID: String?                        //
    public var parentInstID: Int?                      //
    public var parentNodeID: Int?                      //
    public var proInsID: String?                       //
    public var returnScore: String?                    //
    public var serviceQualityScore: String?            //
    public var state: String?                          //
    public var subject: String?                        //
    public var taskID: String?                         //
    public var taskName: String?                       //
    public var taskNodeID: String?                     //
    public var cellList: [Any] = []                     //cell数据源

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        id = json["ID_"].string
        pocinstTimeOut = json["PROC_INST_TIMEOUT"].string
        responseTimeOut = json["RESPONSE_TIMEOUT"].string
        assigneeID = json["assigneeId"].string
        area = json["bx_area"].string
        areaID = json["bx_area_id"].string
        firstCateLevel = json["bx_cate_lv1"].string
        secondCateLevel = json["bx_cate_lv2"].string
        secondCateLevelID = json["bx_cate_lv2_id"].string
        thirdCateLevel = json["bx_cate_lv3"].string
        thirdCateLevelID = json["bx_cate_lv3_id"].string
        code = json["bx_code"].string
        content = json["bx_content"].string
        plot = json["bx_dk"].string
        plotID = json["bx_dk_id"].string
        mobile = json["bx_mobile"].string
        time = json["bx_time"].int
        user = json["bx_user"].string
        way = json["bx_way"].string
        deadlineTime = json["c_deadline_time"].int
        createTime = json["createTime"].int
        instanceID = json["instance_id"].string
        isReturnTimeOut = json["isReturnTimeOut"].string
        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].int
        parentNodeID = json["parentNodeId"].int
        proInsID = json["proInsId"].string
        returnScore = json["return_score"].string
        serviceQualityScore = json["service_quality_score"].string
        state = json["state"].string
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string
    }
}
