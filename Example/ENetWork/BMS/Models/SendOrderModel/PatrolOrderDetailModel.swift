//  待处理巡查工单--待跟进详情
//	SendOrderPatrollingWaitDetailModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

public class PatrolOrderDelayModel: NSObject {

    public var auditDate: String?                              //审批时间

    public var applicationDescription: String?                 //申请说明
    public var applicationState: Int?                          //审批状态，1:审批中，2:通过，3:驳回
    public var applyFiles: String?                             //闭单图片 申请附件
    public var applyFilesArray: [PictureModel] = []            //闭单图片 Model 集合
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
        auditDate = json["auditDate"].string
        createdBy = json["createdBy"].string
        createdName = json["createdName"].string
        creationDate = json["creationDate"].string
        extensionDays = json["extensionDays"].int
        id = json["id"].string
        poID = json["poId"].string
        type = json["type"].int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
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
        if auditDate != nil {
            dictionary["auditDate"] = auditDate
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
        if id != nil {
            dictionary["id"] = id
        }
        if poID != nil {
            dictionary["poId"] = poID
        }
        if type != nil {
            dictionary["type"] = type
        }
        if extensionDays != nil {
            dictionary["extensionDays"] = extensionDays
        }

        return dictionary
    }

}

public class PatrolOrderCloseModel: NSObject {

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
        auditDate = json["auditDate"].string
        createdBy = json["createdBy"].string
        createdName = json["createdName"].string
        creationDate = json["creationDate"].string
        extensionDays = json["extensionDays"].int
        id = json["id"].string
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
        if auditDate != nil {
            dictionary["auditDate"] = auditDate
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
        if id != nil {
            dictionary["id"] = id
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

public class PatrolOrderDetailModel: NSObject {

    public var buttons: [PatrolOrderDetailButtonModel]?
    public var data: PatrolOrderDetailDataModel?

    public var extensionApplication: PatrolOrderCloseModel?      //闭单
    public var delayExtensionApplication: PatrolOrderDelayModel? //延期

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        let extensionApplicationJson = json["extensionApplication"]
        if !extensionApplicationJson.isEmpty {
            extensionApplication = PatrolOrderCloseModel(fromJson: extensionApplicationJson)
        }

        let delayExtensionApplicationJson = json["delayExtensionApplication"]
        if !delayExtensionApplicationJson.isEmpty {
            delayExtensionApplication = PatrolOrderDelayModel(fromJson: delayExtensionApplicationJson)
        }

        buttons = [PatrolOrderDetailButtonModel]()
        let buttonsArray = json["buttons"].arrayValue
        for buttonsJson in buttonsArray {
            let value = PatrolOrderDetailButtonModel(fromJson: buttonsJson)
            buttons?.append(value)
        }
        let dataJson = json["data"]
        if !dataJson.isEmpty {
            data = PatrolOrderDetailDataModel(fromJson: dataJson)
        }
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if data != nil {
            dictionary["data"] = data?.toDictionary()
        }
        return dictionary
    }
}

public class PatrolOrderDetailButtonModel: NSObject {

    public var afterScript: String?
    public var alias: String? //英文名
    public var beforeScript: String?
    public var groovyScript: String?
    public var name: String? //名字
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

public class PatrolOrderDetailDataModel: NSObject {

    public var zyxcgd: PatrolOrderDetailZyxcgdModel?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        let zyxcgdJson = json["zyxcgd"]
        if !zyxcgdJson.isEmpty {
            zyxcgd = PatrolOrderDetailZyxcgdModel(fromJson: zyxcgdJson)
        }
    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if zyxcgd != nil {
            dictionary["zyxcgd"] = zyxcgd?.toDictionary()
        }
        return dictionary
    }
}

public class PatrolOrderDetailZyxcgdModel: NSObject {

    public var actualCompletionTime: String? //实际完成时间
    public var buildingID: String? //楼栋ID
    public var buildingName: String? //楼栋名称
    public var close: String?
    public var completionDeadLine: String? //完成截止时间
    public var creationDate: String? //创建时间
    public var buildDescription: String? //说明
    public var duration: Int? //巡更路线时限
    public var extStatus: String?
    public var files: String? //附件 图片
    public var filesArray: [PictureModel] = [] //附件 图片转model
    public var floor: String? //楼层
    public var gridID: String? //网格ID
    public var gridName: String? //网格名称
    public var hangStatus: String? //是否挂起
    public var inspectionWorkGuidanceID: String? //工作指导ID
    public var inspectionWorkGuidanceName: String? //工作指导名称
    public var inspectionWorkPlanID: String? //巡查工作计划ID
    public var inspectionWorkPlanName: String? //巡查工作计划名称
    public var isTimeOut: Int? //是否超时
    public var lineCode: String?
    public var lineID: String? //条线ID
    public var lineName: String? //条线名称
    public var massifID: String? //分期ID
    public var massifName: String? //项目名称
    public var otHours: Int?
    public var patrolLineID: String?
    public var patrolLineName: String?//巡更路线名称
    public var planWorkOrderCode: String? //工单编号
    public var planWorkOrderState: Int? //计划工单状态
    public var principalID: String? //工单负责人ID
    public var principalName: String? //工单负责人名称
    public var handleName: String? //工单处理人名称
    public var processingDate: String? //处理时间
    public var processingInstructions: String? //处理
    public var processingPersonID: String?  //处理人ID
    public var processingPersonName: String? //处理人名称
    public var processingTime: String? //处理时间
    public var projectID: String? //项目ID
    public var projectName: String? //项目名称
    public var realDuration: String?
    public var titID: String? //岗位id
    public var titName: String? //岗位名称
    public var typeID: String? //分类ID
    public var typeName: String? //分类名称
    public var unitID: String? //单元ID
    public var unitName: String? //单元名称
    public var houseName: String? //房号
    public var refID: String?
    public var ID: String?
    public var initData: SubInspectionWorkOrderFlowNode?
    public var isSort: Int?
    public var procInstID: String?
    public var subInspectionWorkOrderFlowNode: [SubInspectionWorkOrderFlowNode]?
    public var tenantID: String?
    public var ownerID: String?
    public var ownerName: String?
    public var sendRemark: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        actualCompletionTime = json["F_actual_completion_time"].string
        buildingID = json["F_building_id"].string
        buildingName = json["F_building_name"].string
        close = json["F_close"].string
        completionDeadLine = json["F_completion_deadline"].string
        creationDate = json["F_creation_date"].string
        buildDescription = json["F_description"].string
        duration = json["F_duration"].int
        extStatus = json["F_ext_status"].string

        files = json["F_files"].string
        filesArray = [PictureModel]() //图片集合
        let tempFiles = json["F_files"].stringValue
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

        floor = json["F_floor"].stringValue
        houseName = json["F_house_code"].string
        gridID = json["F_grid_id"].string
        gridName = json["F_grid_name"].string
        hangStatus = json["F_hang_status"].string
        inspectionWorkGuidanceID = json["F_inspection_work_guidance_id"].string
        inspectionWorkGuidanceName = json["F_inspection_work_guidance_name"].string
        inspectionWorkPlanID = json["F_inspection_work_plan_id"].string
        inspectionWorkPlanName = json["F_inspection_work_plan_name"].string
        isTimeOut = json["F_is_time_out"].int
        lineCode = json["F_line_code"].string
        lineID = json["F_line_id"].string
        lineName = json["F_line_name"].string
        massifID = json["F_massif_id"].string
        massifName = json["F_massif_name"].string
        otHours = json["F_ot_hours"].int
        patrolLineID = json["F_patrol_line_id"].string
        patrolLineName = json["F_patrol_line_name"].string
        planWorkOrderCode = json["F_plan_work_order_code"].string
        planWorkOrderState = json["F_plan_work_order_state"].int
        principalID = json["F_principal_id"].string
        principalName = json["F_principal_name"].string
        handleName = json["F_processing_person_name"].string
        processingDate = json["F_processing_date"].string
        processingInstructions = json["F_processing_instructions"].string
        processingPersonID = json["F_processing_person_id"].string
        processingPersonName = json["F_processing_person_name"].string
        processingTime = json["F_processing_time"].string
        projectID = json["F_project_id"].string
        projectName = json["F_project_name"].string
        realDuration = json["F_real_duration"].string
        titID = json["F_tit_id"].string
        titName = json["F_tit_name"].string
        typeID = json["F_type_id"].string
        typeName = json["F_type_name"].string
        unitID = json["F_unit_id"].string
        unitName = json["F_unit_name"].string
        refID = json["REF_ID_"].string
        ID = json["id_"].string
        let initDataJson = json["initData"]
        if !initDataJson.isEmpty {
            initData = SubInspectionWorkOrderFlowNode(fromJson: initDataJson)
        }
        isSort = json["is_sort"].int
        procInstID = json["proc_inst_id_"].string
        subInspectionWorkOrderFlowNode = [SubInspectionWorkOrderFlowNode]()
        let subInspectionWorkOrderFlowNodeArray = json["sub_inspection_work_order_flow_node"].arrayValue
        for subInspectionWorkOrderFlowNodeJson in subInspectionWorkOrderFlowNodeArray {
            let value = SubInspectionWorkOrderFlowNode(fromJson: subInspectionWorkOrderFlowNodeJson)
            subInspectionWorkOrderFlowNode?.append(value)
        }
        tenantID = json["tenant_id"].string
        ownerID = json["F_OWNER_ID"].string
        ownerName = json["F_OWNER_NAME"].string
        sendRemark = json["F_SEND_REMARK"].string

    }

    public override init() {
        super.init()
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if actualCompletionTime != nil {
            dictionary["F_actual_completion_time"] = actualCompletionTime
        }
        if buildingID != nil {
            dictionary["F_building_id"] = buildingID
        }
        if buildingName != nil {
            dictionary["F_building_name"] = buildingName
        }
        if close != nil {
            dictionary["F_close"] = close
        }
        if completionDeadLine != nil {
            dictionary["F_completion_deadline"] = completionDeadLine
        }
        if creationDate != nil {
            dictionary["F_creation_date"] = creationDate
        }
        if buildDescription != nil {
            dictionary["F_description"] = buildDescription
        }
        if duration != nil {
            dictionary["F_duration"] = duration
        }
        if extStatus != nil {
            dictionary["F_ext_status"] = extStatus
        }
        if files != nil {
            dictionary["F_files"] = files
        }
        if floor != nil {
            dictionary["F_floor"] = floor
        }
        if gridID != nil {
            dictionary["F_grid_id"] = gridID
        }
        if gridName != nil {
            dictionary["F_grid_name"] = gridName
        }
        if hangStatus != nil {
            dictionary["F_hang_status"] = hangStatus
        }
        if inspectionWorkGuidanceID != nil {
            dictionary["F_inspection_work_guidance_id"] = inspectionWorkGuidanceID
        }
        if inspectionWorkGuidanceName != nil {
            dictionary["F_inspection_work_guidance_name"] = inspectionWorkGuidanceName
        }
        if inspectionWorkPlanID != nil {
            dictionary["F_inspection_work_plan_id"] = inspectionWorkPlanID
        }
        if inspectionWorkPlanName != nil {
            dictionary["F_inspection_work_plan_name"] = inspectionWorkPlanName
        }
        if isTimeOut != nil {
            dictionary["F_is_time_out"] = isTimeOut
        }
        if lineCode != nil {
            dictionary["F_line_code"] = lineCode
        }
        if lineID != nil {
            dictionary["F_line_id"] = lineID
        }
        if lineName != nil {
            dictionary["F_line_name"] = lineName
        }
        if massifID != nil {
            dictionary["F_massif_id"] = massifID
        }
        if massifName != nil {
            dictionary["F_massif_name"] = massifName
        }
        if otHours != nil {
            dictionary["F_ot_hours"] = otHours
        }
        if patrolLineID != nil {
            dictionary["F_patrol_line_id"] = patrolLineID
        }
        if patrolLineName != nil {
            dictionary["F_patrol_line_name"] = patrolLineName
        }
        if planWorkOrderCode != nil {
            dictionary["F_plan_work_order_code"] = planWorkOrderCode
        }
        if planWorkOrderState != nil {
            dictionary["F_plan_work_order_state"] = planWorkOrderState
        }
        if principalID != nil {
            dictionary["F_principal_id"] = principalID
        }
        if principalName != nil {
            dictionary["F_principal_name"] = principalName
        }
        if handleName != nil {
            dictionary["F_processing_person_name"] = handleName
        }
        if processingDate != nil {
            dictionary["F_processing_date"] = processingDate
        }
        if processingInstructions != nil {
            dictionary["F_processing_instructions"] = processingInstructions
        }
        if processingPersonID != nil {
            dictionary["F_processing_person_id"] = processingPersonID
        }
        if processingPersonName != nil {
            dictionary["F_processing_person_name"] = processingPersonName
        }
        if processingTime != nil {
            dictionary["F_processing_time"] = processingTime
        }
        if projectID != nil {
            dictionary["F_project_id"] = projectID
        }
        if projectName != nil {
            dictionary["F_project_name"] = projectName
        }
        if realDuration != nil {
            dictionary["F_real_duration"] = realDuration
        }
        if titID != nil {
            dictionary["F_tit_id"] = titID
        }
        if titName != nil {
            dictionary["F_tit_name"] = titName
        }
        if typeID != nil {
            dictionary["F_type_id"] = typeID
        }
        if typeName != nil {
            dictionary["F_type_name"] = typeName
        }
        if unitID != nil {
            dictionary["F_unit_id"] = unitID
        }
        if unitName != nil {
            dictionary["F_unit_name"] = unitName
        }
        if refID != nil {
            dictionary["REF_ID_"] = refID
        }
        if ID != nil {
            dictionary["id"] = ID
        }
        if initData != nil {
            dictionary["initData"] = initData?.toDictionary()
        }
        if isSort != nil {
            dictionary["is_sort"] = isSort
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }
        if subInspectionWorkOrderFlowNode != nil {
            var dictionaryElements = [[String: Any]]()
            for subInspectionWorkOrderFlowNodeElement in subInspectionWorkOrderFlowNode! {
                dictionaryElements.append(subInspectionWorkOrderFlowNodeElement.toDictionary())
            }
            dictionary["sub_inspection_work_order_flow_node"] = dictionaryElements
        }
        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if ownerID != nil {
            dictionary["F_OWNER_ID"] = ownerID
        }
        if ownerName != nil {
            dictionary["F_OWNER_NAME"] = ownerName
        }
        if sendRemark != nil {
            dictionary["F_SEND_REMARK"] = sendRemark
        }
        return dictionary
    }
}

public class PatrolItemModel: NSObject {

    public var ID: String?
    public var patrolItemContent: String?
    public var patrolItemName: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        ID = json["id"].string
        patrolItemContent = json["patrolItemContent"].string
        patrolItemName = json["patrolItemName"].string
    }
}

public class SubInspectionWorkOrderFlowNode: NSObject {

    public var wkContent: String? //位置
    public var wkID: String? //序号
    public var wkNode: String? //名称
    public var wkResult: String? //结果
    public var isPhoto: Int?     //  1: 需要  0  不需要
    public var patrolItems: String?
    public var patrolItemArray: [PatrolItemModel] = [] //巡更节点 数据

    public var patrolPointID: String?                  //巡更点id

    public var picExampleUrl: String?                   //示例图片
    public var picExampleUrlArray: [PictureModel] = []  //示例图片 model 集合
    public var picUrl: String?                          //上传图片
    public var picUrlArray: [PictureModel] = []         //上传图片 model 集合

    public var signResult: Int?                         //签到结果  2为通过 1为不通过 0为默认
    public var signTime: String?                        //签到时间
    public var signType: Int?
    public var sort: Int?

    public var ID: String?
    public var refID: String?
    public var tenantID: String?
    public var procInstID: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        wkContent = json["F_WK_CONTENT"].string
        wkID = json["F_WK_ID"].string
        wkNode = json["F_WK_NODE"].string
        wkResult = json["F_WK_RESULT"].string
        isPhoto = json["is_photo"].int

        patrolItems = json["patrol_items"].string
        patrolItemArray = [PatrolItemModel]() //示例图片 集合
        let tempPatrolItems = json["patrol_items"].stringValue
        if let jsonData = tempPatrolItems.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PatrolItemModel(fromJson: tempJson)
                    patrolItemArray.append(model)
                }
            }
        }

        patrolPointID = json["patrol_point_id"].string

        picExampleUrl = json["pic_example_url"].string
        picExampleUrlArray = [PictureModel]() //示例图片 集合
        let tempPicExampleUrl = json["pic_example_url"].stringValue
        if let jsonData = tempPicExampleUrl.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    picExampleUrlArray.append(model)
                }
            }
        }

        picUrl = json["pic_url"].string
        picUrlArray = [PictureModel]() //上传图片 集合
        let tempPicUrl = json["pic_url"].stringValue
        if let jsonData = tempPicUrl.data(using: .utf8) {
            let json = JSON(jsonData)
            if json.arrayValue.count > 0 {
                for tempJson in json.arrayValue {
                    let model = PictureModel(fromJson: tempJson)
                    if let path = model.filePath {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + path
                    } else {
                        model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                    }
                    picUrlArray.append(model)
                }
            }
        }

        signResult = json["sign_result"].int
        signTime = json["sign_time"].string
        signType = json["sign_type"].int
        sort = json["sort"].int

        ID = json["id"].string
        refID = json["ref_id_"].string
        tenantID = json["tenant_id"].string
        procInstID = json["proc_inst_id_"].string
    }

    public override init() {
        super.init()
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
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
        if isPhoto != nil {
            dictionary["is_photo"] = isPhoto
        }
        if patrolItems != nil {
            dictionary["patrol_items"] = patrolItems
        }
        if patrolPointID != nil {
            dictionary["patrol_point_id"] = patrolPointID
        }
        if picExampleUrl != nil {
            dictionary["pic_example_url"] = picExampleUrl
        }
        if picUrl != nil {
            dictionary["pic_url"] = picUrl
        }
        if signResult != nil {
            dictionary["sign_result"] = signResult
        }
        if signTime != nil {
            dictionary["sign_time"] = signTime
        }
        if signType != nil {
            dictionary["sign_type"] = signType
        }
        if sort != nil {
            dictionary["sort"] = sort
        }

        if ID != nil {
            dictionary["id"] = ID
        }
        if refID != nil {
            dictionary["ref_id_"] = refID
        }
        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }

        return dictionary
    }
}
