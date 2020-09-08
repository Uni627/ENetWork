//  获取派工单列表--待跟进
//    SendOrderTrackModel.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class SendOrderTrackModel: NSObject {
    ///实例ID
    public var procinstID: String?
    ///1计划工单，2巡查工单
    public var originalType: Int?
    ///原工单id
    public var originalID: String?
    ///原工单编号
    public var originalCode: String?
    ///原实例ID
    public var originalProcinstID: String?
    ///处理后照片
    public var afterPic: String?
    ///处理前照片
    public var beforePic: String?
    ///验收人id
    public var checkID: String?
    ///验收人名称
    public var checkName: String?
    ///工单创建时间
    public var orderCreateTime: String?
    ///完成截止时间
    public var deadlineTime: Int?
    ///问题描述
    public var desc: String?
    ///分期id
    public var divideID: String?
    ///分期名称
    public var divideName: String?
    ///项目id
    public var projectID: String?
    ///项目名称
    public var projectName: String?
    public var envirmentType2Code: String?
    public var envirmentType2Name: String?
    public var envirmentType3Code: String?
    public var envirmentType3Name: String?
    ///是否延期  1 已延期 0 未延期
    public var extstatus: Int?
    ///是否挂起
    public var hangStatus: Int?
    ///位置
    public var location: String?
    ///工单编号
    public var orderNo: String?
    ///超时级别  1:普通,2:一般,3:严重
    public var overTimeLevel: String?
    public var overTimeLevelName: String?
    ///是否超时 //0 超时 1 未超时
    public var overTimestatus: Int?
    ///处理内容
    public var procContent: String?
    ///处理时间
    public var procDate: Int?
    ///处理人id
    public var procID: String?
    ///处理人名称
    public var procName: String?
    ///资源id
    public var resourcesID: String?
    ///资源名称
    public var resourcesName: String?
    ///资源分类名称
    public var resourcesTypeName: String?
    ///工单状态 1:待响应，2:处理中，3:验收中，4:已完成
    public var status: String?
    ///条线编码
    public var lineCode: String?
    ///条线id
    public var lineID: String?
    ///条线名称
    public var lineName: String?
    ///工单类型
    public var type: String?
    ///分类名称
    public var typeName: String?
    public var selectTypeName: String?
    ///工单id
    public var ID: String?
    public var refID: String?
    public var assigneeID: String?
    ///待办生成时间
    public var createTime: String?
    public var ownerID: String?
    public var parentInstID: String?
    public var parentNodeID: String?
    ///实例id
    public var proInsID: String?
    ///工单标题
    public var subject: String?
    ///任务Id
    public var taskID: String?
    ///任务名称
    public var taskName: String?
    ///任务节点id
    public var taskNodeID: String?
    ///分期code
    public var divideCode: String?
    ///图片集合
    public var pgdAttachment: String?
    ///本地图片
    public var imageArray: [UIImage]?
    ///本地图片data
    public var imageDataArray: [Data]?
    ///0.不需要批复 1.批复
    public var isReply: Int?
    ///过期标识（0为不快过期，1为快过期）
    public var isComingTimeOut: Int?
    
    public var jointHandle: String?
    public var searchValue: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        procinstID = json["PROC_INST_ID"].string
        afterPic = json["F_AFT_PIC"].string
        beforePic = json["F_BEF_PIC"].string
        checkID = json["F_CHECK_ID"].string
        checkName = json["F_CHECK_NAME"].string

        if let orderCreateTimeStr = json["F_CREATE_TIME"].string {
            orderCreateTime = orderCreateTimeStr
        } else {
            let orderCreateTimeTemp = json["F_CREATE_TIME"].double
            if orderCreateTimeTemp != nil {
                orderCreateTime = orderCreateTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
            }
        }

        deadlineTime = json["F_DEADLINE_TIME"].int
        desc = json["F_DESC"].string
        divideID = json["F_DIVIDE_ID"].string
        divideName = json["F_DIVIDE_NAME"].string
        envirmentType2Code = json["F_ENVIRMENT_TYPE2_CODE"].string
        envirmentType2Name = json["F_ENVIRMENT_TYPE2_NAME"].string
        envirmentType3Code = json["F_ENVIRMENT_TYPE3_CODE"].string
        envirmentType3Name = json["F_ENVIRMENT_TYPE3_NAME"].string
        extstatus = json["F_EXT_STATUS"].int
        hangStatus = json["F_HANG_STATUS"].int
        location = json["F_LOCATION"].string
        orderNo = json["F_ORDER_NO"].string
        overTimeLevel = json["F_OT_LEVEL"].string
        overTimestatus = json["F_OT_STATUS"].int
        procContent = json["F_PROC_CONTENT"].string
        procDate = json["F_PROC_DATE"].int
        procID = json["F_PROC_ID"].string
        procName = json["F_PROC_NAME"].string
        projectID = json["F_PROJECT_ID"].string
        projectName = json["F_PROJECT_NAME"].string
        resourcesID = json["F_RES_ID"].string
        resourcesName = json["F_RES_NAME"].string
        status = json["F_STATUS"].string
        lineCode = json["F_TX_CODE"].string
        lineID = json["F_TX_ID"].string
        lineName = json["F_TX_NAME"].string
        type = json["F_TYPE"].string
        typeName = json["F_TYPE_NAME"].string
        ID = json["ID_"].string
        refID = json["REF_ID_"].string
        assigneeID = json["assigneeId"].string
        createTime = json["createTime"].string
        ownerID = json["ownerId"].string
        parentInstID = json["parentInstId"].string
        parentNodeID = json["parentNodeId"].string
        proInsID = json["proInsId"].string
        subject = json["subject"].string
        taskID = json["taskId"].string
        taskName = json["taskName"].string
        taskNodeID = json["taskNodeId"].string
        isReply = json["isReply"].int
        originalCode = json["F_ORIGINAL_CODE"].string
        isComingTimeOut = json["is_coming_timeout"].int
        originalProcinstID = json["F_ORIGINAL_PROLNSTLD"].string
        originalType = json["F_ORIGINAL_TYPE"].int
        originalID = json["F_ORIGINAL_ID"].string
        jointHandle = json["joint_processor"].string
    }

    public override init() {
        super.init()
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if afterPic != nil {
            dictionary["F_AFT_PIC"] = afterPic
        }
        if beforePic != nil {
            dictionary["F_BEF_PIC"] = beforePic
        }
        if checkID != nil {
            dictionary["F_CHECK_ID"] = checkID
        }
        if checkName != nil {
            dictionary["F_CHECK_NAME"] = checkName
        }
        if orderCreateTime != nil {
            dictionary["F_CREATE_TIME"] = orderCreateTime
        }
        if deadlineTime != nil {
            dictionary["F_DEADLINE_TIME"] = deadlineTime
        }
        if desc != nil {
            dictionary["F_DESC"] = desc
        }
        if isComingTimeOut != nil {
            dictionary["is_coming_timeout"] = isComingTimeOut
        }
        if divideID != nil {
            dictionary["F_DIVIDE_ID"] = divideID
        }
        if divideName != nil {
            dictionary["F_DIVIDE_NAME"] = divideName
        }
        if envirmentType2Code != nil {
            dictionary["F_ENVIRMENT_TYPE2_CODE"] = envirmentType2Code
        }
        if envirmentType2Name != nil {
            dictionary["F_ENVIRMENT_TYPE2_NAME"] = envirmentType2Name
        }
        if envirmentType3Code != nil {
            dictionary["F_ENVIRMENT_TYPE3_CODE"] = envirmentType3Code
        }
        if envirmentType3Name != nil {
            dictionary["F_ENVIRMENT_TYPE3_NAME"] = envirmentType3Name
        }
        if extstatus != nil {
            dictionary["F_EXT_STATUS"] = extstatus
        }
        if hangStatus != nil {
            dictionary["F_HANG_STATUS"] = hangStatus
        }
        if location != nil {
            dictionary["F_LOCATION"] = location
        }
        if orderNo != nil {
            dictionary["F_ORDER_NO"] = orderNo
        }
        if originalCode != nil {
            dictionary["F_ORIGINAL_CODE"] = originalCode
        }
        if overTimeLevel != nil {
            dictionary["F_OT_LEVEL"] = overTimeLevel
        }
        if overTimestatus != nil {
            dictionary["F_OT_STATUS"] = overTimestatus
        }
        if procContent != nil {
            dictionary["F_PROC_CONTENT"] = procContent
        }
        if procDate != nil {
            dictionary["F_PROC_DATE"] = procDate
        }
        if procID != nil {
            dictionary["F_PROC_ID"] = procID
        }
        if procName != nil {
            dictionary["F_PROC_NAME"] = procName
        }
        if projectID != nil {
            dictionary["F_PROJECT_ID"] = projectID
        }
        if projectName != nil {
            dictionary["F_PROJECT_NAME"] = projectName
        }
        if resourcesID != nil {
            dictionary["F_RES_ID"] = resourcesID
        }
        if resourcesName != nil {
            dictionary["F_RES_NAME"] = resourcesName
        }
        if status != nil {
            dictionary["F_STATUS"] = status
        }
        if lineCode != nil {
            dictionary["F_TX_CODE"] = lineCode
        }
        if lineID != nil {
            dictionary["F_TX_ID"] = lineID
        }
        if lineName != nil {
            dictionary["F_TX_NAME"] = lineName
        }
        if type != nil {
            dictionary["F_TYPE"] = type
        }
        if typeName != nil {
            dictionary["F_TYPE_NAME"] = typeName
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if refID != nil {
            dictionary["REF_ID_"] = refID
        }
        if assigneeID != nil {
            dictionary["assigneeId"] = assigneeID
        }
        if createTime != nil {
            dictionary["createTime"] = createTime
        }
        if ownerID != nil {
            dictionary["ownerId"] = ownerID
        }
        if parentInstID != nil {
            dictionary["parentInstId"] = parentInstID
        }
        if parentNodeID != nil {
            dictionary["parentNodeId"] = parentNodeID
        }
        if proInsID != nil {
            dictionary["PROC_INST_ID"] = proInsID
        }
        if subject != nil {
            dictionary["subject"] = subject
        }
        if taskID != nil {
            dictionary["taskId"] = taskID
        }
        if taskName != nil {
            dictionary["taskName"] = taskName
        }
        if taskNodeID != nil {
            dictionary["taskNodeId"] = taskNodeID
        }
        if divideCode != nil {
            dictionary["F_DIVIDE_CODE"] = divideCode
        }
        if pgdAttachment != nil {
            dictionary["pgd_attachment"] = pgdAttachment
        }
        if procinstID != nil {
            dictionary["PROC_INST_ID"] = procinstID
        }
        if originalProcinstID != nil {
            dictionary["F_ORIGINAL_PROLNSTLD"] = originalProcinstID
        }
        if originalType != nil {
            dictionary["F_ORIGINAL_TYPE"] = originalType
        }
        if originalID != nil {
            dictionary["F_ORIGINAL_ID"] = originalID
        }
        if jointHandle != nil {
            dictionary["joint_processor"] = jointHandle
        }
        return dictionary
    }
}
