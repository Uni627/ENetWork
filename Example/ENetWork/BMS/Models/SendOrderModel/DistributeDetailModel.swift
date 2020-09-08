//
//  DistributeDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/5.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum ResourceOrderState: String {
    case new = "1"       //待响应
    case processing = "2"           //处理中
    case acceptance = "3"           //待验收
    case done = "4"                 //已完成
    case accept = "5"               //待接单
    case dispatch = "6"             //待派单

    var localizedDescription: String {
        switch self {
        case .new:
            return "待响应"
        case .processing:
            return "处理中"
        case .acceptance:
            return "待验收"
        case .done:
            return "已完成"
        case .accept:
            return "待接单"
        case .dispatch:
            return "待派单"
        }
    }
}



public class DistributeButtonModel: NSObject {
    public var afterScript: String?
    public var alias: String?
    public var beforeScript: String?
    public var groovyScript: String?
    public var name: String?
    public var supportScript: Bool?
    public var urlForm: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        afterScript = json["afterScript"].string
        alias = json["alias"].string
        beforeScript = json["beforeScript"].string
        groovyScript = json["groovyScript"].string
        name = json["name"].string
        supportScript = json["supportScript"].bool
        urlForm = json["urlForm"].string
    }

    public override init() {
        super.init()
    }

    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if afterScript != nil {
            dictionary["afterScript"] = afterScript
        }
        if alias != nil {
            dictionary["alias"] = alias
        }
        if beforeScript != nil {
            dictionary["beforeScript"] = beforeScript
        }
        if groovyScript != nil {
            dictionary["groovyScript"] = groovyScript
        }
        if name != nil {
            dictionary["name"] = name
        }
        if supportScript != nil {
            dictionary["supportScript"] = supportScript
        }
        if urlForm != nil {
            dictionary["urlForm"] = urlForm
        }
        return dictionary
    }

}

public class DistributeInitDataModel: NSObject {

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        let dictionary = [String: Any]()
        return dictionary
    }
}

public class DistributeDataModel: NSObject {

    public var actFinishTime: String? //实际完成时间
    var actFinishTime2: Double?
    public var checkDate: String?  //验收日期
    var checkDate2: Double?
    public var createTime: String? //工单创建时间
    var createTime2: Double?
    public var deadLineTime: String? //完成截止时间
    var deadLineTime2: Double?
    public var procDate: String? //处理时间
    var procDate2: Double?
    public var aftPic: String? //处理后照片
    public var aftPicModelArr: [PictureModel] = [] //处理后照片 model 集合
    public var befPic: String? //处理前照片
    public var checkContent: String? //验收意见
    public var checkID: String?  //验收人id
    public var checkName: String? //验收人名称
    public var checkResult: String? //验收结果
    public var desc: String? //问题描述
    public var divideID: String? //分期id
    public var divideName: String? ////分期名称
    public var type: String? //工单类型 （一级）
    public var typeName: String? //工单名称 （一级）
    public var envirmentType2Code: String?
    public var envirmentType2Name: String?
    public var envirmentType3Code: String?
    public var envirmentType3Name: String?
    public var evaluation: String? //评价
    public var executorName: String?
    public var extStatus: Int? //是否延期
    public var hangStatus: Int? //是否挂起
    public var location: String? //位置
    public var orderNo: String? //工单编号
    public var originalCode: String?
    public var originalProInsID: String?
    public var originalID: String?
    public var originalType: String?
    public var otLevel: String? //超时级别 1:普通,2:一般,3:严重
    public var otStatus: Int? //是否超时 // 1超时，0未超时
    public var procContent: String? //处理内容
    public var procID: String?  //处理人id
    public var procName: String?  //负责人名称
    public var handleName: String?  //处理人名称
    public var projectID: String? //项目id
    public var jointHandle: String? //联合处理人
    public var projectName: String? //项目名称
    public var resID: String? //资源id
    public var resName: String? //资源名称
    public var returnReason: String? //退回原因
    public var score: Int?
    public var status: String? //1:待响应，2:处理中，3:验收中，4:已完成
    public var state: ResourceOrderState = .new //1:待响应，2:处理中，3:验收中，4:已完成
    public var titID: String? //岗位id
    public var titName: String? //岗位名称
    public var txCode: String? //条线Code
    public var txID: String? //条线id
    public var txName: String? ////条线名称
    public var ID: String? //工单id
    public var initData: DistributeInitDataModel?
    public var pgdAttachment: String? //创建派工单时的图片
    public var pgdAttachmentArray: [PictureModel] = [] ////图片model 集合
    public var procInstID: String? //实例ID
    public var refID: String?
    public var tenantID: String?
    public var close: String?

    ///派工单 待跟进 或者 已跟进 详情 数据
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        actFinishTime = json["F_ACT_FINISH_TIME"].string
        aftPic = json["F_AFT_PIC"].string
        aftPicModelArr = [PictureModel]() //图片集合 model
        let aftPicString = json["F_AFT_PIC"].stringValue
        if let jsonData = aftPicString.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    aftPicModelArr.append(model)
                }
            }
        }

        befPic = json["F_BEF_PIC"].string
        checkContent = json["F_CHECK_CONTENT"].string
        checkDate = json["F_CHECK_DATE"].string
        checkID = json["F_CHECK_ID"].string
        checkName = json["F_CHECK_NAME"].string
        checkResult = json["F_CHECK_RESULT"].string
        createTime = json["F_CREATE_TIME"].string
        deadLineTime = json["F_DEADLINE_TIME"].string
        desc = json["F_DESC"].string
        divideID = json["F_DIVIDE_ID"].string
        divideName = json["F_DIVIDE_NAME"].string
        envirmentType2Code = json["F_ENVIRMENT_TYPE2_CODE"].string
        envirmentType2Name = json["F_ENVIRMENT_TYPE2_NAME"].string
        envirmentType3Code = json["F_ENVIRMENT_TYPE3_CODE"].string
        envirmentType3Name = json["F_ENVIRMENT_TYPE3_NAME"].string
        evaluation = json["F_EVALUATION"].string
        executorName = json["F_EXECUTOR_NAME"].string
        extStatus = json["F_EXT_STATUS"].int
        hangStatus = json["F_HANG_STATUS"].int
        location = json["F_LOCATION"].string
        orderNo = json["F_ORDER_NO"].string
        originalCode = json["F_ORIGINAL_CODE"].string
        originalID = json["F_ORIGINAL_ID"].string
        originalType = json["F_ORIGINAL_TYPE"].string
        otLevel = json["F_OT_LEVEL"].stringValue
        otStatus = json["F_OT_STATUS"].int
        procContent = json["F_PROC_CONTENT"].string
        procDate = json["F_PROC_DATE"].string
        procID = json["F_PROC_ID"].string
        procName = json["F_PROC_NAME"].string
        handleName = json["F_HANDLE_NAME"].string
        projectID = json["F_PROJECT_ID"].string
        originalProInsID = json["F_ORIGINAL_PROLNSTLD"].string
        projectName = json["F_PROJECT_NAME"].string
        resID = json["F_RES_ID"].string
        resName = json["F_RES_NAME"].string
        returnReason = json["F_RETURN_REASON"].string
        score = json["F_SCORE"].int
        status = json["F_STATUS"].string
        state = ResourceOrderState.init(rawValue: json["F_STATUS"].stringValue) ?? .new
        titID = json["F_TIT_ID"].string
        titName = json["F_TIT_NAME"].string
        txCode = json["F_TX_CODE"].string
        txID = json["F_TX_ID"].string
        txName = json["F_TX_NAME"].string
        type = json["F_TYPE"].string
        typeName = json["F_TYPE_NAME"].string
        ID = json["id_"].string
        jointHandle = json["joint_processor"].string
        
        let initDataJson = json["initData"]
        if !initDataJson.isEmpty {
            initData = DistributeInitDataModel(fromJson: initDataJson)
        }

        pgdAttachment = json["pgd_attachment"].string
        pgdAttachmentArray = [PictureModel]() //图片集合 model
        let tempAttachment = json["pgd_attachment"].stringValue
        if let jsonData = tempAttachment.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    pgdAttachmentArray.append(model)
                }
            }
        }

        procInstID = json["proc_inst_id_"].string
        refID = json["ref_id_"].string
        tenantID = json["tenant_id"].string
    }

    ///派工单 工单列表详情 数据
    init(fromListJson json: JSON!) {
        if json.isEmpty {
            return
        }
        actFinishTime = json["fActFinishTime"].string
        actFinishTime2 = json["factFinishTime"].double
        if actFinishTime == nil {
            actFinishTime = actFinishTime2?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }
        checkDate = json["fCheckDate"].string
        checkDate2 = json["fcheckDate"].double
        if checkDate == nil {
            checkDate = checkDate2?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }
        createTime = json["fCreateTime"].string
        createTime2 = json["fcreateTime"].double
        if createTime == nil {
            createTime = createTime2?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }
        deadLineTime = json["fDeadlineTime"].string
        deadLineTime2 = json["fdeadlineTime"].double
        if deadLineTime == nil {
            deadLineTime = deadLineTime2?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }
        procDate = json["fProcDate"].string
        procDate2 = json["fprocDate"].double
        if procDate == nil {
            procDate = procDate2?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        envirmentType2Code = json["fEnvirmentType2Code"].string
        envirmentType2Name = json["fEnvirmentType2Name"].string
        envirmentType3Code = json["fEnvirmentType3Code"].string
        envirmentType3Name = json["fEnvirmentType3Name"].string
        executorName = json["fExecutorName"].string
        originalCode = json["fOriginalCode"].string
        originalID = json["fOriginalId"].string
        originalType = json["fOriginalType"].string
        score = json["fScore"].int
        aftPic = json["faftPic"].string
        aftPicModelArr = [PictureModel]() //图片集合 model
        let aftPicString = json["faftPic"].stringValue
        if let jsonData = aftPicString.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    aftPicModelArr.append(model)
                }
            }
        }

        befPic = json["fbefPic"].string
        checkContent = json["fcheckContent"].string
        checkID = json["fcheckId"].string
        checkName = json["fcheckName"].string
        checkResult = json["fcheckResult"].string
        close = json["fclose"].string
        desc = json["fdesc"].string
        divideID = json["fdivideId"].string
        divideName = json["fdivideName"].string
        evaluation = json["fevaluation"].string
        extStatus = json["fextStatus"].int
        hangStatus = json["fhangStatus"].int
        location = json["flocation"].string
        orderNo = json["forderNo"].string
        otLevel = json["fotLevel"].string
        otStatus = json["fotStatus"].int
        procContent = json["fprocContent"].string
        procID = json["fprocId"].string
        procName = json["fprocName"].string
        handleName = json["F_HANDLE_NAME"].string
        projectID = json["fprojectId"].string
        originalProInsID = json["F_ORIGINAL_PROLNSTLD"].string
        projectName = json["fprojectName"].string
        resID = json["fresId"].string
        resName = json["fresName"].string
        returnReason = json["freturnReason"].string
        status = json["fstatus"].string
        titID = json["ftitId"].string
        titName = json["ftitName"].string
        txCode = json["ftxCode"].string
        txID = json["ftxId"].string
        txName = json["ftxName"].string
        type = json["ftype"].string
        typeName = json["ftypeName"].string
        ID = json["id"].string
        jointHandle = json["joint_processor"].string
        pgdAttachment = json["pgdAttachment"].string
        pgdAttachmentArray = [PictureModel]() //图片集合 model
        let tempAttachment = json["pgdAttachment"].stringValue
        if let jsonData = tempAttachment.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    pgdAttachmentArray.append(model)
                }
            }
        }
        refID = json["refId"].string
    }

    public override init() {
        super.init()
    }
  
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if actFinishTime != nil {
            dictionary["F_ACT_FINISH_TIME"] = actFinishTime
        }
        if aftPic != nil {
            dictionary["F_AFT_PIC"] = aftPic
        }
        if befPic != nil {
            dictionary["F_BEF_PIC"] = befPic
        }
        if checkContent != nil {
            dictionary["F_CHECK_CONTENT"] = checkContent
        }
        if checkDate != nil {
            dictionary["F_CHECK_DATE"] = checkDate
        }
        if checkID != nil {
            dictionary["F_CHECK_ID"] = checkID
        }
        if checkName != nil {
            dictionary["F_CHECK_NAME"] = checkName
        }
        if checkResult != nil {
            dictionary["F_CHECK_RESULT"] = checkResult
        }
        if createTime != nil {
            dictionary["F_CREATE_TIME"] = createTime
        }
        if deadLineTime != nil {
            dictionary["F_DEADLINE_TIME"] = deadLineTime
        }
        if desc != nil {
            dictionary["F_DESC"] = desc
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
        if evaluation != nil {
            dictionary["F_EVALUATION"] = evaluation
        }
        if executorName != nil {
            dictionary["F_EXECUTOR_NAME"] = executorName
        }
        if extStatus != nil {
            dictionary["F_EXT_STATUS"] = extStatus
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
        if originalID != nil {
            dictionary["F_ORIGINAL_ID"] = originalID
        }
        if originalType != nil {
            dictionary["F_ORIGINAL_TYPE"] = originalType
        }
        if otLevel != nil {
            dictionary["F_OT_LEVEL"] = otLevel
        }
        if otStatus != nil {
            dictionary["F_OT_STATUS"] = otStatus
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
        if originalProInsID != nil {
            dictionary["F_ORIGINAL_PROLNSTLD"] = originalProInsID
        }
        if procName != nil {
            dictionary["F_PROC_NAME"] = procName
        }
        if handleName != nil {
            dictionary["F_HANDLE_NAME"] = handleName
        }
        if projectID != nil {
            dictionary["F_PROJECT_ID"] = projectID
        }
        if projectName != nil {
            dictionary["F_PROJECT_NAME"] = projectName
        }
        if resID != nil {
            dictionary["F_RES_ID"] = resID
        }
        if resName != nil {
            dictionary["F_RES_NAME"] = resName
        }
        if returnReason != nil {
            dictionary["F_RETURN_REASON"] = returnReason
        }
        if score != nil {
            dictionary["F_SCORE"] = score
        }
        if status != nil {
            dictionary["F_STATUS"] = status
        }
        if titID != nil {
            dictionary["F_TIT_ID"] = titID
        }
        if titName != nil {
            dictionary["F_TIT_NAME"] = titName
        }
        if txCode != nil {
            dictionary["F_TX_CODE"] = txCode
        }
        if txID != nil {
            dictionary["F_TX_ID"] = txID
        }
        if txName != nil {
            dictionary["F_TX_NAME"] = txName
        }
        if type != nil {
            dictionary["F_TYPE"] = type
        }
        if typeName != nil {
            dictionary["F_TYPE_NAME"] = typeName
        }
        if ID != nil {
            dictionary["id_"] = ID
        }
        if initData != nil {
            dictionary["initData"] = initData?.toDictionary()
        }
        if pgdAttachment != nil {
            dictionary["pgd_attachment"] = pgdAttachment
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }
        if refID != nil {
            dictionary["ref_id_"] = refID
        }
        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if jointHandle != nil {
            dictionary["joint_processor"] = jointHandle
        }
        return dictionary
    }
}

public class DistributeOpinionModel: NSObject {

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

    }
    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        let dictionary = [String: Any]()
        return dictionary
    }
}

public class DistributeExtensionModel: NSObject {

    public var auditDate: String?                              //审批时间
    public var applicationDescription: String?                 //申请说明
    public var applicationState: Int?                          //审批状态，1:审批中，2:通过，3:驳回
    public var applyFiles: String?                             //延期图片 申请附件
    public var applyFilesArray: [PictureModel] = []            //延期图片 Model 集合
    public var applyType: Int?                                 //审批类型，1:工单延期，2:工单闭单，3:计划审批
    public var approveID: String?                              //审批人id
    public var approveName: String?                            //审批人姓名
    public var createdBy: String?                              //创建人id
    public var createdName: String?                            //创建人姓名
    public var creationDate: String?                           //创建时间
    public var extensionDays: Int?                             //延期天数
    public var ID: String?                                     //主键id
    public var poID: String?                                   //业务表id
    public var type: Int?                                      //申请分类，1计划工单 ２派工单 3巡查工单 4定期计划 5巡查计划
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        auditDate = json["auditDate"].string
        applicationDescription = json["applicationDescription"].string
        applicationState = json["applicationState"].int
        applyFiles = json["applyFiles"].string
        applyFilesArray = [PictureModel]() //图片集合
        let tempAttachment = json["applyFiles"].stringValue
        if let jsonData = tempAttachment.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    applyFilesArray.append(model)
                }
            }
        }

        applyType = json["applyType"].int
        approveID = json["approveId"].string
        approveName = json["approveName"].string
        createdBy = json["createdBy"].string
        createdName = json["createdName"].string
        creationDate = json["creationDate"].string
        extensionDays = json["extensionDays"].int
        ID = json["id"].string
        poID = json["poId"].string
        type = json["type"].int
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if applicationDescription != nil {
            dictionary["applicationDescription"] = applicationDescription
        }
        if applicationState != nil {
            dictionary["applicationState"] = applicationState
        }
        if applyFiles != nil {
            dictionary["applyFiles"] = applyFiles
        }
        if applyType != nil {
            dictionary["applyType"] = applyType
        }
        if approveID != nil {
            dictionary["approveId"] = approveID
        }
        if approveName != nil {
            dictionary["approveName"] = approveName
        }
        if createdBy != nil {
            dictionary["createdBy"] = createdBy
        }
        if createdName != nil {
            dictionary["createdName"] = createdName
        }
        if creationDate != nil {
            dictionary["creationDate"] = creationDate
        }
        if extensionDays != nil {
            dictionary["extensionDays"] = extensionDays
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if poID != nil {
            dictionary["poId"] = poID
        }
        if type != nil {
            dictionary["type"] = type
        }
        return dictionary
    }

}

public class DistributeDetailModel: NSObject {
    public var buttons: [DistributeButtonModel] = []
    public var couldScore: Bool?
    public var data: DistributeDataModel?
    public var isReply: Int?
    public var extensionApplication: DistributeExtensionModel? //所有延期数据 集合
    public var extensionArray: [DistributeExtensionModel] = [] //所有延期数据 集合
    public var orderDelayArray: [DistributeExtensionModel] = []    //工单延期 集合
    public var orderCloseArray: [DistributeExtensionModel] = []    //工单闭单 集合
    public var planApprovalArray: [DistributeExtensionModel] = []  //计划审批 集合
    public var totalDelayDays: Int?                         //总的延期 天数
    public var totalDelayAmount: Int?                       //总的延期 次数
    public var opinionList: [DistributeOpinionModel] = []
    public var form: String?
    public var formResult: String?
    public var permission: String?

    override public init() {
        super.init()
    }

    init(fromJson json: JSON!, byID: Bool) {
        if json.isEmpty {
            return
        }
        isReply = json["isReply"].int
        buttons = [DistributeButtonModel]()
        let buttonsArray = json["buttons"].arrayValue
        for buttonsJson in buttonsArray {
            let value = DistributeButtonModel(fromJson: buttonsJson)
            buttons.append(value)
        }
        couldScore = json["couldScore"].bool

        if byID {
            let dataJson = json["data"]
            if !dataJson.isEmpty {
                data = DistributeDataModel(fromListJson: dataJson)
            }
        } else {
            let dataJson = json["data"]["cshjpgdjm"]
            if !dataJson.isEmpty {
                data = DistributeDataModel(fromJson: dataJson)
            }
        }

        //所有延期数据 集合
        extensionArray = [DistributeExtensionModel]()
        let extensionJsonArray = json["extensionApplication"].arrayValue
        for extensionJson in extensionJsonArray {
            let value = DistributeExtensionModel(fromJson: extensionJson)
            extensionArray.append(value)
        }

        //工单延期 集合
        orderDelayArray = [DistributeExtensionModel]()
        //工单闭单 集合
        orderCloseArray = [DistributeExtensionModel]()
        //计划审批 集合
        planApprovalArray = [DistributeExtensionModel]()
        //累加延期 天数
        totalDelayDays = 0
        //累计延期 次数
        totalDelayAmount = 0

        for tempItem in extensionArray {
            //applyType 审批类型，1:工单延期，2:工单闭单，3:计划审批
            if tempItem.applyType == 1 {
                //审批状态，1:审批中，2:通过，3:驳回
                if tempItem.applicationState == 2 {
                    //累加延期 天数
                    totalDelayDays = (totalDelayDays ?? 0) + (tempItem.extensionDays ?? 0)
                    //累计延期 次数
                    totalDelayAmount = (totalDelayAmount ?? 0) + 1
                }
                orderDelayArray.append(tempItem)
            } else if tempItem.applyType == 2 {
                orderCloseArray.append(tempItem)
            } else if tempItem.applyType == 3 {
                planApprovalArray.append(tempItem)
            }
        }

        //工单延期 集合 降序排列
        orderDelayArray = orderDelayArray.sorted(by: { (model1, model2) -> Bool in

            if let date1 = model1.creationDate, let date2 = model2.creationDate {
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let time1 = dateFormatter.date(from: date1)
                let time2 = dateFormatter.date(from: date2)
                return time1?.compare(time2!) == .orderedDescending
            }
            return false
        })

        //工单闭单 集合 降序排列
        orderCloseArray = orderCloseArray.sorted(by: { (model1, model2) -> Bool in

            if let date1 = model1.creationDate, let date2 = model2.creationDate {
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let time1 = dateFormatter.date(from: date1)
                let time2 = dateFormatter.date(from: date2)
                return time1?.compare(time2!) == .orderedDescending
            }
            return false
        })

        //计划审批 集合 降序排列
        planApprovalArray = planApprovalArray.sorted(by: { (model1, model2) -> Bool in

            if let date1 = model1.creationDate, let date2 = model2.creationDate {
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let time1 = dateFormatter.date(from: date1)
                let time2 = dateFormatter.date(from: date2)
                return time1?.compare(time2!) == .orderedDescending
            }
            return false
        })

        opinionList = [DistributeOpinionModel]()
        let opinionArray = json["opinionList"].arrayValue
        for opinionJson in opinionArray {
            let value = DistributeOpinionModel(fromJson: opinionJson)
            opinionList.append(value)
        }

        form = json["form"].string
        formResult = json["formResult"].string
        permission = json["permission"].string

    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if buttons.count > 0 {
            var dictionaryElements = [[String: Any]]()
            for buttonsElement in buttons {
                dictionaryElements.append(buttonsElement.toDictionary())
            }
            dictionary["buttons"] = dictionaryElements
        }
        if couldScore != nil {
            dictionary["couldScore"] = couldScore
        }
        if data != nil {
            var tempDictionary = [String: Any]()
            tempDictionary["cshjpgdjm"] = data?.toDictionary()
            dictionary["data"] = tempDictionary
        }
        if extensionArray.count > 0 {
            var dictionaryElements = [[String: Any]]()
            for contentListElement in extensionArray {
                dictionaryElements.append(contentListElement.toDictionary())
            }
            dictionary["extensionApplication"] = dictionaryElements
        }
        return dictionary
    }
}
