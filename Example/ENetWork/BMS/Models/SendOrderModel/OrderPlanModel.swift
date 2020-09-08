//
//  OrderPlanModel.swift
//  EServices
//
//  Created by pxy on 2019/11/12.
//

import Foundation
import SwiftyJSON

public class OrderPlanModel: NSObject {
    public var createTime: String?                     //工单创建时间
    public var deadLineTime: String?                   //完成截止时间
    public var divideID: String?                       //分期ID
    public var divideName: String?                     //分期名称
    public var extendStatus: String?                   //是否延期     1:延期  0:未延期
    public var location: String?                       //位置
    public var opercontent: String?                    //操作要领
    public var orderNo: String?                        //工单编号
    public var overTimeStatus: String?                 //是否超时     1:超时  0:未超时
    public var ownerID: String?                        //工单负责人ID
    public var projectID: String?                      //项目ID
    public var projectName: String?                    //项目名称
    public var resourceID: String?                     //资源分类ID
    public var resourceName: String?                   //资源分类名称
    public var status: String?                         //工单状态      2:处理中 4:已完成
    public var lineID: String?                         //条线ID
    public var lineName: String?                       //条线名称
    public var lineCode: String?                       //条线编码
    public var workGuideID: String?                    //工作指导ID
    public var workGuideName: String?                  //工作指导名称
    public var workPlanID: String?                     //工作计划ID
    public var workPlanName: String?                   //工作计划名称
    public var ID: String?                             //主键

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        createTime = json["F_CREATE_TIME"].string
        deadLineTime = json["F_DEADLINE_TIME"].string
        divideID = json["f_DIVIDE_ID"].string
        divideName = json["f_DIVIDE_NAME"].string
        extendStatus = json["f_EXT_STATUS"].string
        location = json["f_LOCATION"].string
        opercontent = json["f_OPER_CONTENT"].string
        orderNo = json["f_ORDER_NO"].string
        overTimeStatus = json["f_OT_STATUS"].string
        ownerID = json["f_OWNER_ID"].string
        projectID = json["f_PROJECT_ID"].string
        projectName = json["f_PROJECT_NAME"].string
        resourceID = json["f_RES_ID"].string
        resourceName = json["f_RES_NAME"].string
        status = json["f_STATUS"].string
        lineID = json["f_TX_ID"].string
        lineCode = json["f_TX_CODE"].string
        lineName = json["f_TX_NAME"].string
        workGuideID = json["f_WG_ID"].string
        workGuideName = json["f_WG_NAME"].string
        workPlanID = json["f_WP_ID"].string
        workPlanName = json["f_WP_NAME"].string
        ID = json["id_"].string
    }
}
