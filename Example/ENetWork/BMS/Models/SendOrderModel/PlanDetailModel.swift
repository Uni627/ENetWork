//
//  PlanDetailModel.swift
//  Alamofire
//
//  Created by pxy on 2019/11/5.
//

import Foundation
import SwiftyJSON

public enum PlanOrderStatus: String { //工单状态 1:待响应，2:处理中，3:验收中，4:已完成
    case none           = "0"
    case new            = "1"
    case handle         = "2"
    case acceptance     = "3"
    case done           = "4"
    case receive        = "5"
    case designate      = "6"

    public var description: String {
        switch self {
        case .new:
            return "新生成"
        case .handle:
            return "处理中"
        case .acceptance:
            return "待验收"
        case .done:
            return "已完成"
        case .receive:
            return "待接单"
        case .designate:
            return "待派单"
        case .none:
            return ""
        }
    }

    public var image: String {
        switch self {
        case .new:
            return "repair_status_grab"
        case .handle:
            return "repair_status_process"
        case .acceptance:
            return "repair_status_respond"
        case .done:
            return "repair_status_close"
        case .receive:
            return "send_order_new_button"
        case .designate:
            return "send_order_new_button"
        case .none:
            return ""
        }
    }
}

public class PlanWorkNodeModel: NSObject {

    public var wkID: String? //序号
    public var wkContent: String? //内容
    public var wkNode: String? //节点名称
    public var wkResult: String? //结果 1通过 0不通过
    public var ID: String?
    public var refID: String?
    public var procInstID: String?
    public var tenantID: String?
    public var last = false

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        wkContent = json["F_WK_CONTENT"].string
        wkID = json["F_WK_ID"].string
        wkNode = json["F_WK_NODE"].string
        wkResult = json["F_WK_RESULT"].string
        ID = json["id_"].string
        refID = json["ref_id_"].string
        procInstID = json["proc_inst_id_"].string
        tenantID = json["tenant_id"].string
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if wkContent != nil {
            dictionary["F_WK_CONTENT"] = wkContent
        }
        if wkID != nil {
            dictionary["F_WK_ID"] = wkID
        }
        if wkNode != nil {
            dictionary["F_WK_NODE"] = wkNode
        }
        if wkResult != nil {
            dictionary["F_WK_RESULT"] = wkResult
        }
        if ID != nil {
            dictionary["id_"] = ID
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
        return dictionary
    }

}

public class PlanMatterModel: NSObject {

    public var matName: String? //物料名称
    public var matCount: Int? //数量
    public var matUnit: String? //单位
    public var matUnitPrice: String? //单位 价格
    public var matRemark: String? //备注

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        matName = json["F_MAT_NAME"].string
        matCount = json["F_MAT_COUNT"].int
        matUnit = json["F_MAT_UNIT"].string
        matUnitPrice = json["F_MAT_UNIT_PRICE"].string
        matRemark = json["F_MAT_REMARK"].string
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if matName != nil {
            dictionary["F_MAT_NAME"] = matName
        }
        if matCount != nil {
            dictionary["F_MAT_COUNT"] = matCount
        }
        if matUnit != nil {
            dictionary["F_MAT_UNIT"] = matUnit
        }
        if matUnitPrice != nil {
            dictionary["F_MAT_UNIT_PRICE"] = matUnitPrice
        }
        if matRemark != nil {
            dictionary["F_MAT_REMARK"] = matRemark
        }
        return dictionary
    }
}

public class  PlanResourceModel: NSObject {

    public var pgID: String? //工作指导Id
    public var wgName: String? //工作指导名称
    public var resCode: String? //资源编码
    public var resourceQRCode: String? //资源ID
    public var resName: String? //资源名称
    public var resType: String?
    public var resTypeName: String? //资源分类
    public var resCount: String? //资源数量
    public var spType: String? //空间类型
    public var resLocation: String? //资源位置
    public var remark: String? //备注
    public var isForced: Bool = false
    public var ID: String?
    public var procInstID: String?
    public var refID: String?
    public var tenantID: String?
    public var scanResult: Int?
    public var haveScaned: Bool = false
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        pgID = json["F_PG_ID"].string     //工作指导Id
        wgName = json["F_WG_NAME"].string    //工作指导名称
        resCode = json["F_RES_CODE"].string   //资源编码
        resName = json["F_RES_NAME"].string   //资源名称
        resType = json["F_RES_TYPE"].string
        resTypeName = json["F_RES_TYPENAME"].string //资源分类
        resCount = json["F_RES_COUNT"].string    //资源数量
        spType = json["F_SP_TYPE"].string    //空间类型
        resLocation = json["F_RES_LOCATION"].string    //资源位置
        remark = json["F_REMARK"].string    //备注
        resourceQRCode = json["F_RES_QRCODE"].string
        ID = json["id_"].string
        procInstID = json["proc_inst_id_"].string
        refID = json["ref_id_"].string
        tenantID = json["tenant_id"].string
        scanResult = json["scan_result"].int
        if (json["is_forced"].int ?? 0) > 0 {
            isForced = true
        }
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if pgID != nil {
            dictionary["F_PG_ID"] = pgID
        }
        if wgName != nil {
            dictionary["F_WG_NAME"] = wgName
        }
        if resCode != nil {
            dictionary["F_RES_CODE"] = resCode
        }
        if resName != nil {
            dictionary["F_RES_NAME"] = resName
        }
        if resType != nil {
            dictionary["F_RES_TYPE"] = resType
        }
        if resTypeName != nil {
            dictionary["F_RES_TYPENAME"] = resTypeName
        }
        if resCount != nil {
            dictionary["F_RES_COUNT"] = resCount
        }
        if spType != nil {
            dictionary["F_SP_TYPE"] = spType
        }
        if resLocation != nil {
            dictionary["F_RES_LOCATION"] = resLocation
        }
        if remark != nil {
            dictionary["F_REMARK"] = remark
        }
        if ID != nil {
            dictionary["id_"] = ID
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }
        if refID != nil {
            dictionary["ref_id_"] = refID
        }
        if resourceQRCode != nil {
            dictionary["F_RES_QRCODE"] = resourceQRCode
        }
        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if scanResult != nil && scanResult != 2 {
            dictionary["scan_result"] = scanResult
        }
        return dictionary
    }

}

public class PlanInitDataModel: NSObject {

    public var workNodeModel: PlanWorkNodeModel? //工作节点
    public var resourceModel: PlanResourceModel? //资源
    public var matterModel: PlanMatterModel? //物料
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        workNodeModel = PlanWorkNodeModel(fromJson: json["jhgdgzjdb"])
        resourceModel = PlanResourceModel(fromJson: json["jhgdzyb"])
        matterModel = PlanMatterModel(fromJson: json["jhgdwlb"])
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if workNodeModel != nil {
            dictionary["jhgdgzjdb"] = workNodeModel?.toDictionary()
        }
        if resourceModel != nil {
            dictionary["jhgdzyb"] = resourceModel?.toDictionary()
        }
        if matterModel != nil {
            dictionary["jhgdwlb"] = matterModel?.toDictionary()
        }
        return dictionary
    }
}

public class PlanDataModel: NSObject {
    
    public var actFinishTime: String? //实际完成时间
    public var content: String? //处理内容
    public var createTime: String? //工单创建时间
    public var deadLineTime: String? //完成截止时间
    public var divideID: String? //分期ID
    public var divideName: String? //分期名称
    public var extStatus: Int? //是否延期 1 已延期 0 未延期
    public var files: String? //附件图片
    public var filesArray: [PictureModel] = [] //附件图片 model 集合
    public var hangStatus: String?
    public var location: String? //位置
    public var operContent: String? //操作要领
    public var orderNo: String? //工单编号
    public var otHours: Int?
    public var otStatus: Int? //是否超时 1超时 0未超时
    public var ownerID: String? //工单负责人ID
    public var ownerName: String? //工单负责人名称
    public var processID: String?
    public var processName: String?
    public var projectID: String?
    public var projectName: String?
    public var resID: String? //资源分类ID
    public var resName: String? //资源分类名称
    public var status: String? //工单状态 2-处理中，4-已完成
    public var orderStatus: PlanOrderStatus = .none
    public var titID: String? //岗位ID
    public var titName: String? //岗位名称
    public var txCode: String?
    public var txID: String? //条线ID
    public var txName: String? //条线名称
    public var wgID: String? //工作指导ID
    public var wgName: String? //工作指导名称
    public var wpID: String? //工作计划ID
    public var wpName: String? //工作计划名称
    public var refID: String?
    public var ID: String?
    public var procinstID: String?
    public var tenantID: String?
    public var initData: PlanInitDataModel?
    public var workNodeArray: [PlanWorkNodeModel] = [] //工作节点 集合
    public var matterArray: [PlanMatterModel] = [] //物料 集合
    public var resourceArray: [PlanResourceModel] = [] //资源 集合
    public var orderDelayArray: [PlanExtensionModel] = []    //工单延期 集合
    public var orderCloseArray: [PlanExtensionModel] = []    //工单闭单 集合
    public var planApprovalArray: [PlanExtensionModel] = []  //计划审批 集合
    public var close: String?
    public var sendRemark: String?
    public var forceScan = false
    public var scanResult: String?
    
    
    //计划工单 待跟进列表 已跟进列表--详情 数据
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        actFinishTime = json["F_ACT_FINISH_TIME"].string
        content = json["F_CONTENT"].string
        createTime = json["F_CREATE_TIME"].string
        deadLineTime = json["F_DEADLINE_TIME"].string
        divideID = json["F_DIVIDE_ID"].string
        divideName = json["F_DIVIDE_NAME"].string
        extStatus = json["F_EXT_STATUS"].int
        files = json["F_FILES"].string
        filesArray = [PictureModel]() //图片集合
        let tempFiles = json["F_FILES"].stringValue
        if let jsonData = tempFiles.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    filesArray.append(model)
                }
            }
        }

        hangStatus = json["F_HANG_STATUS"].string
        location = json["F_LOCATION"].string
        operContent = json["F_OPER_CONTENT"].string
        orderNo = json["F_ORDER_NO"].string
        otHours = json["F_OT_HOURS"].int
        otStatus = json["F_OT_STATUS"].int
        ownerID = json["F_OWNER_ID"].string
        ownerName = json["F_OWNER_NAME"].string
        processID = json["F_PROCESS_ID"].string
        processName = json["F_PROCESS_NAME"].string
        projectID = json["F_PROJECT_ID"].string
        projectName = json["F_PROJECT_NAME"].string
        resID = json["F_RES_ID"].string
        resName = json["F_RES_NAME"].string
        status = json["F_STATUS"].string
        if let statusString = json["F_STATUS"].string {
            orderStatus = PlanOrderStatus.init(rawValue: statusString) ?? .none
        }
        titID = json["F_TIT_ID"].string
        titName = json["F_TIT_NAME"].string
        txCode = json["F_TX_CODE"].string
        txID = json["F_TX_ID"].string
        txName = json["F_TX_NAME"].string
        wgID = json["F_WG_ID"].string
        wgName = json["F_WG_NAME"].string
        wpID = json["F_WP_ID"].string
        wpName = json["F_WP_NAME"].string
        refID = json["REF_ID_"].string
        ID = json["id_"].string
        procinstID = json["proc_inst_id_"].string
        tenantID = json["tenant_id"].string
        sendRemark = json["F_SEND_REMARK"].string
        forceScan = json["is_forced"].intValue == 1
        scanResult = json["scan_result"].string
        initData = PlanInitDataModel(fromJson: json["initData"])

        workNodeArray = [PlanWorkNodeModel]()
        let subjhgdgzjdbArray = json["sub_jhgdgzjdb"].arrayValue
        for subjhgdgzjdbJson in subjhgdgzjdbArray {
            let value = PlanWorkNodeModel(fromJson: subjhgdgzjdbJson)
            workNodeArray.append(value)
        }

        matterArray = [PlanMatterModel]()
        let subjhgdwlbArray = json["sub_jhgdwlb"].arrayValue
        for subjhgdwlbJson in subjhgdwlbArray {
            let value = PlanMatterModel(fromJson: subjhgdwlbJson)
            matterArray.append(value)
        }

        resourceArray = [PlanResourceModel]()
        let subjhgdzybArray = json["sub_jhgdzyb"].arrayValue
        for subjhgdzybJson in subjhgdzybArray {
            let value = PlanResourceModel(fromJson: subjhgdzybJson)
            resourceArray.append(value)
        }

    }

    //计划工单 工单列表详情 数据
    init(fromListJson json: JSON!) {
        if json.isEmpty {
            return
        }

        actFinishTime = json["F_ACT_FINISH_TIME"].string
        createTime = json["F_CREATE_TIME"].string
        deadLineTime = json["F_DEADLINE_TIME"].string
        close = json["f_CLOSE"].string
        content = json["f_CONTENT"].string
        divideID = json["f_DIVIDE_ID"].string
        divideName = json["f_DIVIDE_NAME"].string
        //字符串转整形
        let extStatusStr: String = json["f_EXT_STATUS"].stringValue
        extStatus = (extStatusStr as NSString).integerValue

        files = json["f_FILES"].string
        filesArray = [PictureModel]() //图片集合
        let tempFiles = json["f_FILES"].stringValue
        if let jsonData = tempFiles.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    filesArray.append(model)
                }
            }
        }

        hangStatus = json["f_HANG_STATUS"].string
        location = json["f_LOCATION"].string
        operContent = json["f_OPER_CONTENT"].string
        orderNo = json["f_ORDER_NO"].string

        //字符串转整形
        let otStatusStr: String = json["f_OT_STATUS"].stringValue
        otStatus = (otStatusStr as NSString).integerValue

        ownerID = json["f_OWNER_ID"].string
        ownerName = json["f_OWNER_NAME"].string
        processID = json["f_PROCESS_ID"].string
        processName = json["f_PROCESS_NAME"].string
        projectID = json["f_PROJECT_ID"].string
        projectName = json["f_PROJECT_NAME"].string
        resID = json["f_RES_ID"].string
        resName = json["f_RES_NAME"].string
        status = json["f_STATUS"].string
        titID = json["f_TIT_ID"].string
        titName = json["f_TIT_NAME"].string
        txCode = json["f_TX_CODE"].string
        txID = json["f_TX_ID"].string
        txName = json["f_TX_NAME"].string
        wgID = json["f_WG_ID"].string
        wgName = json["f_WG_NAME"].string
        wpID = json["f_WP_ID"].string
        wpName = json["f_WP_NAME"].string
        ID = json["id_"].string
        refID = json["ref_ID_"].string
        forceScan = json["is_forced"].intValue == 1
        scanResult = json["scan_result"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if actFinishTime != nil {
            dictionary["F_ACT_FINISH_TIME"] = actFinishTime
        }
        if content != nil {
            dictionary["F_CONTENT"] = content
        }
        if createTime != nil {
            dictionary["F_CREATE_TIME"] = createTime
        }
        if deadLineTime != nil {
            dictionary["F_DEADLINE_TIME"] = deadLineTime
        }
        if divideID != nil {
            dictionary["F_DIVIDE_ID"] = divideID
        }
        if divideName != nil {
            dictionary["F_DIVIDE_NAME"] = divideName
        }
        if extStatus != nil {
            dictionary["F_EXT_STATUS"] = extStatus
        }
        if files != nil {
            dictionary["F_FILES"] = files
        }
        if hangStatus != nil {
            dictionary["F_HANG_STATUS"] = hangStatus
        }
        if location != nil {
            dictionary["F_LOCATION"] = location
        }
        if operContent != nil {
            dictionary["F_OPER_CONTENT"] = operContent
        }
        if orderNo != nil {
            dictionary["F_ORDER_NO"] = orderNo
        }
        if otHours != nil {
            dictionary["F_OT_HOURS"] = otHours
        }
        if otStatus != nil {
            dictionary["F_OT_STATUS"] = otStatus
        }
        if ownerID != nil {
            dictionary["F_OWNER_ID"] = ownerID
        }
        if ownerName != nil {
            dictionary["F_OWNER_NAME"] = ownerName
        }
        if processID != nil {
            dictionary["F_PROCESS_ID"] = processID
        }
        if processName != nil {
            dictionary["F_PROCESS_NAME"] = processName
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
        if wgID != nil {
            dictionary["F_WG_ID"] = wgID
        }
        if wgName != nil {
            dictionary["F_WG_NAME"] = wgName
        }
        if wpID != nil {
            dictionary["F_WP_ID"] = wpID
        }
        if wpName != nil {
            dictionary["F_WP_NAME"] = wpName
        }
        if refID != nil {
            dictionary["REF_ID_"] = refID
        }
        if ID != nil {
            dictionary["id_"] = ID
        }
        if procinstID != nil {
            dictionary["proc_inst_id_"] = procinstID
        }
        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if sendRemark != nil {
            dictionary["F_SEND_REMARK"] = sendRemark
        }
        dictionary["is_forced"] = forceScan ? 1 : 0
        if scanResult != nil {
            dictionary["scan_result"] = scanResult
        }
        if initData != nil {
            dictionary["initData"] = initData?.toDictionary()
        }
        var subjhgdgzjdbArray = [[String: Any]]()
        for subjhgdgzjdbElement in workNodeArray {
            subjhgdgzjdbArray.append(subjhgdgzjdbElement.toDictionary())
        }
        dictionary["sub_jhgdgzjdb"] = subjhgdgzjdbArray

        var subjhgdwlbArray = [[String: Any]]()
        for subjhgdwlbElement in matterArray {
            subjhgdwlbArray.append(subjhgdwlbElement.toDictionary())
        }
        dictionary["sub_jhgdwlb"] = subjhgdwlbArray

        var subjhgdzybArray = [[String: Any]]()
        for subjhgdzybElement in resourceArray {
            subjhgdzybArray.append(subjhgdzybElement.toDictionary())
        }
        dictionary["sub_jhgdzyb"] = subjhgdzybArray
        return dictionary
    }

    public override init() {
        super.init()
    }
}

public class PlanButtonModel: NSObject {

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
        let dictionary = [String: Any]()
        return dictionary
    }
}

public class PlanOpinionModel: NSObject {

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

public class PlanExtensionModel: NSObject {

    public var auditDate: String?                              //审批时间
    public var applicationDescription: String?                 //申请说明
    public var applicationState: Int?                          //审批状态，1:审批中，2:通过，3:驳回
    public var applyFiles: String?                             //延期图片 申请附件
    public var applyFilesArray: [PictureModel] = []            //延期图片集合
    public var applyType: Int?                                 //审批类型，1:工单延期，2:工单闭单，3:计划审批
    public var approveID: String?                              //审批人id
    public var approveName: String?                            //审批人姓名
    public var createdBy: String?                              //创建人id
    public var createdName: String?                            //创建人姓名
    public var creationDate: String?                           //创建时间
    public var extensionDays: Int?                             //延期天数
    public var id: String?                                     //主键id
    public var poID: String?                                   //业务表id
    public var type: Int?                                      //申请分类，1计划工单 ２派工单 3巡查工单 4定期计划 5巡查计划

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        applicationDescription = json["applicationDescription"].string
        applicationState = json["applicationState"].int
        applyFiles = json["applyFiles"].string
        applyFilesArray = [PictureModel]() //图片集合
        let tempAttachment = json[["applyFiles"]].stringValue
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
        auditDate = json["auditDate"].string
        createdBy = json["createdBy"].string
        createdName = json["createdName"].string
        creationDate = json["creationDate"].string
        extensionDays = json["extensionDays"].int
        id = json["id"].string
        poID = json["poId"].string
        type = json["type"].int
    }
    
    public override init() {
        super.init()
    }
}

public class PlanDetailMaterielModel: NSObject {

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
    }
}

public class PlanDetailNodeModel: NSObject {

    public var wkContent: String?
    public var wkID: String?
    public var wkNode: String?
    public var wkResult: String?
    public var id: String?
    public var refID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        wkContent = json["fwkContent"].string
        wkID = json["fwkId"].string
        wkNode = json["fwkNode"].string
        wkResult = json["fwkResult"].string
        id = json["id"].string
        refID = json["refId"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if wkContent != nil {
            dictionary["fwkContent"] = wkContent
        }
        if wkID != nil {
            dictionary["fwkId"] = wkID
        }
        if wkNode != nil {
            dictionary["fwkNode"] = wkNode
        }
        if wkResult != nil {
            dictionary["fwkResult"] = wkResult
        }
        if id != nil {
            dictionary["id"] = id
        }
        if refID != nil {
            dictionary["refId"] = refID
        }
        return dictionary
    }
}

public class PlanDetailResourceModel: NSObject {

    public var pgID: String?
    public var remark: String?
    public var resCode: String?
    public var resCount: String?
    public var resLocation: String?
    public var resName: String?
    public var resType: String?
    public var spType: String?
    public var wgName: String?
    public var id: String?
    public var isForced: Int?
    public var refID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        pgID = json["fPgId"].string
        remark = json["fRemark"].string
        resCode = json["fResCode"].string
        resCount = json["fResCount"].string
        resLocation = json["fResLocation"].string
        resName = json["fResName"].string
        resType = json["fResType"].string
        spType = json["fSpType"].string
        wgName = json["fWgName"].string
        id = json["id"].string
        isForced = json["isForced"].int
        refID = json["refId"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if pgID != nil {
            dictionary["fPgId"] = pgID
        }
        if remark != nil {
            dictionary["fRemark"] = remark
        }
        if resCode != nil {
            dictionary["fResCode"] = resCode
        }
        if resCount != nil {
            dictionary["fResCount"] = resCount
        }
        if resLocation != nil {
            dictionary["fResLocation"] = resLocation
        }
        if resName != nil {
            dictionary["fResName"] = resName
        }
        if resType != nil {
            dictionary["fResType"] = resType
        }
        if spType != nil {
            dictionary["fSpType"] = spType
        }
        if wgName != nil {
            dictionary["fWgName"] = wgName
        }
        if id != nil {
            dictionary["id"] = id
        }
        if isForced != nil {
            dictionary["isForced"] = isForced
        }
        if refID != nil {
            dictionary["refId"] = refID
        }
        return dictionary
    }

}

public class PlanDetailModel: NSObject {

    public var buttons: [PlanButtonModel] = []
    public var data: PlanDataModel?
    public var extensionApplication: PlanExtensionModel?       //所有延期数据 集合
    public var extensionArray: [PlanExtensionModel] = []       //所有延期数据 集合
    public var orderDelayArray: [PlanExtensionModel] = []      //工单延期 集合
    public var orderCloseArray: [PlanExtensionModel] = []      //工单闭单 集合
    public var planApprovalArray: [PlanExtensionModel] = []    //计划审批 集合
    public var totalDelayDays: Int?                            //总的延期 天数
    public var totalDelayAmount: Int?                          //总的延期 次数
    public var opinionList: [PlanOpinionModel] = []
    public var form: String?
    public var formResult: String?
    public var permission: String?
    public var materielArray: [PlanDetailMaterielModel] = []
    public var nodeArray: [PlanDetailNodeModel] = []
    public var resourceArray: [PlanDetailResourceModel] = []

    init(fromListJson json: JSON!) {
        if json.isEmpty {
            return
        }
        //所有延期数据 集合
        extensionArray = [PlanExtensionModel]()
        let extensionJsonArray = json["extensionApplication"].arrayValue
        for extensionJson in extensionJsonArray {
            let value = PlanExtensionModel(fromJson: extensionJson)
            extensionArray.append(value)
        }
        
        //工单延期 集合
        orderDelayArray = [PlanExtensionModel]()
        //工单闭单 集合
        orderCloseArray = [PlanExtensionModel]()
        //计划审批 集合
        planApprovalArray = [PlanExtensionModel]()

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

        let masterJson = json["master"]
        if !masterJson.isEmpty {
            data = PlanDataModel(fromListJson: masterJson)
        }
        materielArray = [PlanDetailMaterielModel]()
        let tempMaterielArray = json["materiel"].arrayValue
        for materielJson in tempMaterielArray {
            let value = PlanDetailMaterielModel(fromJson: materielJson)
            materielArray.append(value)
        }
        nodeArray = [PlanDetailNodeModel]()
        let tempNodeArray = json["node"].arrayValue
        for nodeJson in tempNodeArray {
            let value = PlanDetailNodeModel(fromJson: nodeJson)
            nodeArray.append(value)
        }
        resourceArray = [PlanDetailResourceModel]()
        let tempResourceArray = json["resource"].arrayValue
        for resourceJson in tempResourceArray {
            let value = PlanDetailResourceModel(fromJson: resourceJson)
            resourceArray.append(value)
        }
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        buttons = [PlanButtonModel]()
        let buttonsArray = json["buttons"].arrayValue
        for buttonsJson in buttonsArray {
            let value = PlanButtonModel(fromJson: buttonsJson)
            buttons.append(value)
        }
        let dataJson = json["data"]["zyjhgd"]
        if !dataJson.isEmpty {
            data = PlanDataModel(fromJson: dataJson)
        }

        //所有延期数据 集合
        extensionArray = [PlanExtensionModel]()
        let extensionJsonArray = json["extensionApplication"].arrayValue
        for extensionJson in extensionJsonArray {
            let value = PlanExtensionModel(fromJson: extensionJson)
            extensionArray.append(value)
        }

        //工单延期 集合
        orderDelayArray = [PlanExtensionModel]()
        //工单闭单 集合
        orderCloseArray = [PlanExtensionModel]()
        //计划审批 集合
        planApprovalArray = [PlanExtensionModel]()

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

        opinionList = [PlanOpinionModel]()
        let opinionArray = json["opinionList"].arrayValue
        for opinionJson in opinionArray {
            let value = PlanOpinionModel(fromJson: opinionJson)
            opinionList.append(value)
        }

        form = json["form"].string
        formResult = json["formResult"].string
        permission = json["permission"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if data != nil {
            var tempDictionary = [String: Any]()
            tempDictionary["zyjhgd"] = data?.toDictionary()
            dictionary["data"] = tempDictionary
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}
