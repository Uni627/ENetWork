//
//  RepairDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/20.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation

public class RepairInfoModel: EBaseModel {

    public var flowKey: String?
    public var formkey: String?
    public var nodeID: String?
    public var parentFlowKey: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        flowKey = json["flowKey"].string
        formkey = json["formkey"].string
        nodeID = json["nodeId"].string
        parentFlowKey = json["parentFlowKey"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if flowKey != nil {
            dictionary["flowKey"] = flowKey
        }
        if formkey != nil {
            dictionary["formkey"] = formkey
        }
        if nodeID != nil {
            dictionary["nodeId"] = nodeID
        }
        if parentFlowKey != nil {
            dictionary["parentFlowKey"] = parentFlowKey
        }
        return dictionary
    }

}

public class RepairMaterialModel: NSObject {

    public var labst: String?
    public var lgobe: String?
    public var lgort: String?
    public var maktx: String?
    public var matkl: String?
    public var matnr: String?
    public var meins: String?
    public var name1: String?
    public var netpr: String?
    public var werks: String?
    public var name: String?
    public var price: Double?
    public var quantity: Int?
    public var totalPrice: Double?
    public var procInstID: String?
    public var measurement: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        labst = json["LABST"].string
        lgobe = json["LGOBE"].string
        lgort = json["LGORT"].string
        maktx = json["MAKTX"].string
        matkl = json["MATKL"].string
        matnr = json["MATNR"].string
        meins = json["MEINS"].string
        name1 = json["NAME1"].string
        netpr = json["NETPR"].string
        werks = json["WERKS"].string
        name = json["name"].string
        price = json["price"].double
        quantity = json["quantity"].int
        totalPrice = json["total_price"].double
        procInstID = json["proc_inst_id_"].string
        measurement = json["MEINS"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if labst != nil {
            dictionary["LABST"] = labst
        }
        if lgobe != nil {
            dictionary["LGOBE"] = lgobe
        }
        if lgort != nil {
            dictionary["LGORT"] = lgort
        }
        if maktx != nil {
            dictionary["MAKTX"] = maktx
        }
        if matkl != nil {
            dictionary["MATKL"] = matkl
        }
        if matnr != nil {
            dictionary["MATNR"] = matnr
        }
        if meins != nil {
            dictionary["MEINS"] = meins
        }
        if name1 != nil {
            dictionary["NAME1"] = name1
        }
        if netpr != nil {
            dictionary["NETPR"] = netpr
        }
        if werks != nil {
            dictionary["WERKS"] = werks
        }
        if name != nil {
            dictionary["name"] = name
        }
        if price != nil {
            dictionary["price"] = price
        }
        if quantity != nil {
            dictionary["quantity"] = quantity
        }
        if totalPrice != nil {
            dictionary["total_price"] = totalPrice
        }
        if measurement != nil {
            dictionary["MEINS"] = measurement
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}

public class RepairHandleRecordModel: NSObject {

    public var procinstID: String?
    public var tenantID: String?
    public var bizID: String?
    public var enableFlag: String?
    public var handleResult: String?
    public var handleTime: Int?
    public var handleUser: String?
    public var handleUserID: String?
    public var id: String?
    public var orderFlowKey: String?
    public var orderType: Int?
    public var rowTime: Int?
    public var rowVersion: Int?

    public override init() {
        super.init()
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        procinstID = json["PROC_INST_ID_"].string
        tenantID = json["TENANT_ID"].string
        bizID = json["biz_id"].string
        enableFlag = json["enable_flag"].string
        handleResult = json["handle_result"].string
        handleTime = json["handle_time"].int
        handleUser = json["handle_user"].string
        handleUserID = json["handle_user_id"].string
        id = json["id_"].string
        orderFlowKey = json["order_flow_key"].string
        orderType = json["order_type"].int
        rowTime = json["row_time"].int
        rowVersion = json["row_version"].int
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if procinstID != nil {
            dictionary["PROC_INST_ID_"] = procinstID
        }
        if tenantID != nil {
            dictionary["TENANT_ID"] = tenantID
        }
        if bizID != nil {
            dictionary["biz_id"] = bizID
        }
        if enableFlag != nil {
            dictionary["enable_flag"] = enableFlag
        }
        if handleResult != nil {
            dictionary["handle_result"] = handleResult
        }
        if handleTime != nil {
            dictionary["handle_time"] = handleTime
        }
        if handleUser != nil {
            dictionary["handle_user"] = handleUser
        }
        if handleUserID != nil {
            dictionary["handle_user_id"] = handleUserID
        }
        if id != nil {
            dictionary["id_"] = id
        }
        if orderFlowKey != nil {
            dictionary["order_flow_key"] = orderFlowKey
        }
        if orderType != nil {
            dictionary["order_type"] = orderType
        }
        if rowTime != nil {
            dictionary["row_time"] = rowTime
        }
        if rowVersion != nil {
            dictionary["row_version"] = rowVersion
        }
        return dictionary
    }

}

public class RepairDelayModel: NSObject {

    public var applyDate: String?
    public var applyReason: String?
    public var applyUser: String?
    public var applyUserID: String?
    public var attachment: String?                     //延期图片
    public var attachmentArray: [PictureModel] = []    //延期图片model集合
    public var auditDate: String?
    public var delayTime: String?
    public var status: ApprovalState?                  //延期审批状态
    public var statusStr: String?                      //审批结果

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        applyDate = json["applyDate"].string
        applyReason = json["applyReason"].string
        applyUser = json["applyUser"].string
        applyUserID = json["applyUserId"].string

        attachment = json["attachment"].string
        attachmentArray = [PictureModel]() //图片集合
        let tempFiles = json["attachment"].stringValue
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
                    attachmentArray.append(model)
                }
            }
        }

        auditDate = json["auditDate"].string
        delayTime = json["delayTime"].string
        if let type = json["status"].string {
            status = ApprovalState(rawValue: type)
        }
        statusStr = json["statusStr"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if applyDate != nil {
            dictionary["applyDate"] = applyDate
        }
        if applyReason != nil {
            dictionary["applyReason"] = applyReason
        }
        if applyUser != nil {
            dictionary["applyUser"] = applyUser
        }
        if applyUserID != nil {
            dictionary["applyUserId"] = applyUserID
        }
        if attachment != nil {
            dictionary["attachment"] = attachment
        }
        if auditDate != nil {
            dictionary["auditDate"] = auditDate
        }
        if delayTime != nil {
            dictionary["delayTime"] = delayTime
        }
        if status != nil {
            dictionary["status"] = status
        }
        if statusStr != nil {
            dictionary["statusStr"] = statusStr
        }
        return dictionary
    }

    public override init() {
        super.init()
    }

}

public class RepairCloseModel: NSObject {

    public var applyDate: String?
    public var applyReason: String?
    public var applyUser: String?
    public var applyUserID: String?
    public var attachment: String?                     //闭单图片
    public var attachmentArray: [PictureModel] = []    //闭单图片model集合
    public var auditDate: String?
    public var delayTime: String?
    public var invalidReasonCategory: String?
    public var setToInvalid: String?
    public var status: ApprovalState?                  //闭单审批状态
    public var statusStr: String?                      //审批结果

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        applyDate = json["applyDate"].string
        applyReason = json["applyReason"].string
        applyUser = json["applyUser"].string
        applyUserID = json["applyUserId"].string

        attachment = json["attachment"].string
        attachmentArray = [PictureModel]() //图片集合
        let tempFiles = json["attachment"].stringValue
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
                    attachmentArray.append(model)
                }
            }
        }

        auditDate = json["auditDate"].string
        delayTime = json["delayTime"].string
        invalidReasonCategory = json["invalidReasonCategory"].string
        setToInvalid = json["setToInvalid"].string

//        status = json["status"].string
        if let type = json["status"].string {
            status = ApprovalState(rawValue: type)
        }

        statusStr = json["statusStr"].string
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if applyDate != nil {
            dictionary["applyDate"] = applyDate
        }
        if applyReason != nil {
            dictionary["applyReason"] = applyReason
        }
        if applyUser != nil {
            dictionary["applyUser"] = applyUser
        }
        if applyUserID != nil {
            dictionary["applyUserId"] = applyUserID
        }
        if attachment != nil {
            dictionary["attachment"] = attachment
        }
        if auditDate != nil {
            dictionary["auditDate"] = auditDate
        }
        if delayTime != nil {
            dictionary["delayTime"] = delayTime
        }
        if invalidReasonCategory != nil {
            dictionary["invalidReasonCategory"] = invalidReasonCategory
        }
        if setToInvalid != nil {
            dictionary["setToInvalid"] = setToInvalid
        }
        if status != nil {
            dictionary["status"] = status
        }
        if statusStr != nil {
            dictionary["statusStr"] = statusStr
        }
        return dictionary
    }

    public override init() {
        super.init()
    }
}

public class RepairDetailModel: NSObject {

    public var loadInstructions: Bool = false
    public var buttons: String?
    public var form: String?
    public var info: RepairInfoModel?
    public var opinionList: String?
    public var permission: String?
    public var result: Bool?
    public var delayInfo: RepairDelayModel?                 //延期数据
    public var forceCloseInfo: RepairCloseModel?            //闭单信息
    public var handleList: [RepairHandleRecordModel] = []   //处理历史记录
    public var repairType: String?                 //报修类别
    public var appState: String?                   //业主app展示的状态
    public var artificialCost: Double?             //人工费
    public var assignGrabState: String?            //派单抢单状态(1.客服直接派单2.抢单超时3.抢单未超时4.直接响应)
    public var assignGrabUser: String?             //指派或抢单人（客服指派人，未超时抢单人，超时指派人）
    public var assignGrabUserID: String?           //指派或抢单人id（客服指派人，未超时抢单人，超时指派人）
    public var buildingName: String?               //楼栋名称
    public var appointTime: String?                //预约上门时间
    public var appointTimePeriod: String?          //报修预约上门时间段
    public var appointTimePeriodID: String?        //报修预约上门时间段id
    public var area: String?                       //报修区域
    public var areaID: String?                     //报修区域id
    public var attachment: String?                 //报修内容附件 图片集合 字符串
    public var attachmentArray: [PictureModel] = [] //图片Model 集合
    public var buildID: String?                    //楼栋id
    public var firstCateLevel: String?             //报修类别（一级）
    public var firstCateLevelID: String?           //报修类别（一级）id
    public var secondCateLevel: String?            //报修类别（二级）
    public var secondCateLevelID: String?          //报修类别（二级）id
    public var thirdCateLevel: String?             //报修类别（三级）
    public var thirdCateLevelID: String?           //报修类别（三级）id
    public var code: String?                       //工单编号
    public var content: String?                    //报修内容
    public var divide: String?                     //分期
    public var divideID: String?                   //分期id
    public var house: String?                      //房产
    public var houseID: String?                    //房产id
    public var mobile: String?                     //联系电话
    public var propertyAss: String = "一般"           //性质评估
    public var propertyAssID: String?              //性质评估id
    public var recorder: String?                   //记录人
    public var recorderID: String?                 //记录人id
    public var recorderSeatNumber: String?         //坐席工号
    public var time: String?                       //报修时间
    public var unitID: String?                     //单元id
    public var user: String?                       //报修人
    public var userID: String?                     //报修人id
    public var way: String?                        //报修方式
    public var wayID: String?                      //报修方式id
    public var deadLineTime: String?               //完成截止时间
    public var isSolve: Int?                       //是否解决   1已解决  0未解决
    public var returnVisitStatus: String?          //回访状态
    public var closeRemark: String?                //闭单原因
    public var closeTime: String?                  //结束时间（闭单时间）
    public var dispatchClose: String?              //闭单或派单到项目0：派单到项目；1：闭单
    public var faultArea: String?                  //故障区域
    public var faultDesc: String?                  //故障简述
    public var closeApplyAttach: String?           //强制闭单申请附件
    public var closeApplyReason: String?           //强制闭单申请原因
    public var closeApplyTime: String?             //强制闭单申请时间
    public var closeApplyer: String?               //强制闭单申请人
    public var closeApplyerID: String?             //强制闭单申请人id
    public var closeApproveID: String?             //强制闭单审批流id【k2系统的id】
    public var closeApproveResult: String?         //强制闭单审批结果
    public var closeApproveTime: String?           //强制闭单审批时间
    public var closeIsApplying: Int?               //是否正在申请强制闭单
    public var grabTime: String?                   //工单池抢单时间
    public var gridCode: String?                   //网格code
    public var gridID: String?                     //网格id
    public var gridName: String?                   //网格名称
    public var handleAttach: String?               //报修处理附件 图片集合 字符串  处理上传图片用的
    public var handleAttachArray: [PictureModel] = []  //报修处理附件 model 集合
    public var handleFee: Double?                  //实收费用
    public var handleIsPaid: String?               //是否有偿
    public var handleManHour: Double?              //维修工时(单位小时)
    public var handlePayTime: String?              //付费时间
    public var handlePayType: String?              //付费方式
    public var handlePayTypeID: String?            //付费方式id
    public var handleReceiptNo: String?            //收据单号
    public var handleResult: String?               //处理结果
    public var handleTime: String?                 //回复处理时间
    public var handleTimeOut: String?              //处理超时(1：超时)
    public var handleUser: String?                 //处理人
    public var handleUserID: String?               //处理人id
    public var houseCode: String?                  //房产code
    public var houseKeeperAccount: String?         //管家账号
    public var houseKeeperName: String?            //管家名称
    public var id: String?
    public var initData: RepairMaterialModel?
    public var isGrabOvertime: String?             //是否抢单超时
    public var jointProcessor: String?             //联合处理人
    public var lineKey: String?                    //条线key
    public var lineName: String?                   //条线名称
    public var materialCost: Double?               //材料费
    public var otPdTime: String?                   //超时强制派单时间
    public var otPdUser: String?                   //超时强制派单人
    public var otPdUserID: String?                 //超时强制派单人id
    public var pdRemark: String?                   //派单备注
    public var pdTime: String?                     //客服派单时间
    public var pdUser: String?                     //派单人
    public var pdUserID: String?                   //派单人id
    public var procInstID: String?                 //流程实例id
    public var projectFee: String?                 //项目分成金额
    public var projectRate: String?                //项目分成比例
    public var receiveTime: String?                //接单时间
    public var receiveUser: String?                //接单人
    public var receiveUserID: String?              //接单人id
    public var refID: String?                      //外键
    public var responseResult: String?             //响应沟通结果
    public var responseTime: String?               //响应时间
    public var responseTimeOut: String?            //响应超时(1：超时)
    public var responseUser: String?               //响应人
    public var responseUserID: String?             //响应人id
    public var returnResult: String?               //回访结果
    public var returnScore: String?                //服务态度满意度
    public var returnThreshold: String?            //回访满意度阀值
    public var returnTime: String?                 //回访时间
    public var returnUnsatisfyDo: String?          //回访不满意后处理方式
    public var returnUser: String?                 //回访人
    public var returnUserID: String?               //回访人id
    public var returnVisitNum: String?             //回访次数
    public var returnVisitResult: Int?          //回访结果
    public var returnVisitUser: String?             //回访人
    public var returnVisitTime: String?             //回访时间
    public var returnVisitTimeOut: String?         //回访超时(1：超时)
    public var returnWay: String?                  //回访方式
    public var returnWayID: String?                //回访方式id
    public var serviceAttitudeContent: String?     //服务态度不满意原因
    public var serviceQualityContent: String?      //回访质量不满意原因
    public var serviceQualityScore: String?        //服务质量满意度
    public var serviceUnitFee: String?             //服务单元分成金额
    public var serviceUnitRate: String?            //服务单元分成比例
    public var staffFee: String?                   //员工分成金额
    public var staffRate: String?                  //员工分成比例
    public var state: CustomerOrderState?          //工单状态
    public var subRepairMaterials: [RepairMaterialModel] = []
    public var tenantID: String?                   //租户id
    public var cityArea: String?                   //城区
    public var cityAreaID: String?                 //城区id
    public var project: String?                    //项目
    public var projectID: String?                  //项目id
    public var region: String?                     //区域
    public var regionID: String?                   //区域id
    public var unitName: String?                   //单元名称
    public var workAscription: String?             //工单归属（工程维修、地产维保）
    public var workAscriptionCode: String?         //工单归属Code
    public var workOrderTimeout: String?           //工单超时(1：超时)
    public var sendPersonID: String?                //派单人ID
    public var sendPersonName: String?              //派单人
    public var sendRemark: String?                  //派单备注
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        buttons = json["buttons"].string
        form = json["form"].string
        let initDataJson = json["info"]
        if !initDataJson.isEmpty {
            info = RepairInfoModel(fromJson: initDataJson)
        }
        opinionList = json["opinionList"].string
        permission = json["permission"].string
        result = json["result"].bool

        handleList = [RepairHandleRecordModel]()
        let handleArray = json["handleList"].arrayValue
        for handleJson in handleArray {
            let value = RepairHandleRecordModel(fromJson: handleJson)
            handleList.append(value)
        }
        //延期数据
        let delayInfoJson = json["delayInfo"]
        if !delayInfoJson.isEmpty {
            delayInfo = RepairDelayModel(fromJson: delayInfoJson)
        }
        //闭单信息
        let forceCloseInfoJson = json["forceCloseInfo"]
        if !forceCloseInfoJson.isEmpty {
            forceCloseInfo = RepairCloseModel(fromJson: forceCloseInfoJson)
        }

        let dataJson = json["data"]["customer_repair_model"]

        if !dataJson.isEmpty {

            appState = dataJson["app_state"].string
            artificialCost = dataJson["artificial_cost"].double
            assignGrabState = dataJson["assign_grab_state"].string
            assignGrabUser = dataJson["assign_grab_user"].string
            assignGrabUserID = dataJson["assign_grab_user_id"].string
            buildingName = dataJson["building_name"].string
            appointTime = dataJson["bx_appoint_time"].string
            appointTimePeriod = dataJson["bx_appoint_time_period"].string
            appointTimePeriodID = dataJson["bx_appoint_time_period_id"].string
            area = dataJson["bx_area"].string
            areaID = dataJson["bx_area_id"].string

            attachment = dataJson["bx_attachment"].string
            attachmentArray = [PictureModel]() //图片集合
            let tempFiles = dataJson["bx_attachment"].stringValue
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
                        attachmentArray.append(model)
                    }
                }
            }

            buildID = dataJson["bx_build_id"].string
            firstCateLevel = dataJson["bx_cate_lv1"].string
            firstCateLevelID = dataJson["bx_cate_lv1_id"].string
            secondCateLevel = dataJson["bx_cate_lv2"].string
            secondCateLevelID = dataJson["bx_cate_lv2_id"].string
            thirdCateLevel = dataJson["bx_cate_lv3"].string
            thirdCateLevelID = dataJson["bx_cate_lv3_id"].string
            code = dataJson["bx_code"].string
            content = dataJson["bx_content"].string
            divide = dataJson["bx_dk"].string
            divideID = dataJson["bx_dk_id"].string
            house = dataJson["bx_house"].string
            houseID = dataJson["bx_house_id"].string
            mobile = dataJson["bx_mobile"].string
            propertyAss = dataJson["bx_property_ass"].string ?? "一般"
            propertyAssID = dataJson["bx_property_ass_id"].string

            recorder = dataJson["bx_recorder"].string
            recorderID = dataJson["bx_recorder_id"].string
            recorderSeatNumber = dataJson["bx_recorder_seat_number"].string
            time = dataJson["bx_time"].string
            unitID = dataJson["bx_unit_id"].string
            user = dataJson["bx_user"].string
            userID = dataJson["bx_user_id"].string
            way = dataJson["bx_way"].string
            wayID = dataJson["bx_way_id"].string
            deadLineTime = dataJson["c_deadline_time"].string
            isSolve = dataJson["c_is_solve"].int
            returnVisitStatus = dataJson["c_return_visit_status"].string
            closeRemark = dataJson["close_remark"].string
            closeTime = dataJson["close_time"].string
            dispatchClose = dataJson["dispatch_close"].string
            faultArea = dataJson["fault_area"].string
            faultDesc = dataJson["fault_desc"].string
            closeApplyAttach = dataJson["fclose_apply_attach"].string
            closeApplyReason = dataJson["fclose_apply_reason"].string
            closeApplyTime = dataJson["fclose_apply_time"].string
            closeApplyer = dataJson["fclose_applyer"].string
            closeApplyerID = dataJson["fclose_applyer_id"].string
            closeApproveID = dataJson["fclose_approve_id"].string
            closeApproveResult = dataJson["fclose_approve_result"].string
            closeApproveTime = dataJson["fclose_approve_time"].string
            closeIsApplying = dataJson["fclose_is_applying"].int
            grabTime = dataJson["grab_time"].string
            gridCode = dataJson["grid_code"].string
            gridID = dataJson["grid_id"].string
            gridName = dataJson["grid_name"].string

            handleAttach = dataJson["handle_attach"].string
            handleAttachArray = [PictureModel]() //图片集合
            let handleFiles = dataJson["handle_attach"].stringValue
            if let handleData = handleFiles.data(using: .utf8) {
                let handle = JSON(handleData)
                if handle.arrayValue.count > 0 {
                    for handleJson in handle.arrayValue {
                        let model = PictureModel(fromJson: handleJson)
                        if let path = model.filePath {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + path
                        } else {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                        }
                        handleAttachArray.append(model)
                    }
                }
            }

            handleFee = dataJson["handle_fee"].double
            handleIsPaid = dataJson["handle_is_paid"].string
            handleManHour = dataJson["handle_man_hour"].double
            handlePayTime = dataJson["handle_pay_time"].string
            handlePayType = dataJson["handle_pay_type"].string
            handlePayTypeID = dataJson["handle_pay_type_id"].string
            handleReceiptNo = dataJson["handle_receipt_no"].string
            handleResult = dataJson["handle_result"].string
            handleTime = dataJson["handle_time"].string
            handleTimeOut = dataJson["handle_timeout"].string
            handleUser = dataJson["handle_user"].string
            handleUserID = dataJson["handle_user_id"].string
            houseCode = dataJson["house_code"].string
            houseKeeperAccount = dataJson["housekeeper_account"].string
            houseKeeperName = dataJson["housekeeper_name"].string
            id = dataJson["id_"].string

            let initDataJson = dataJson["initData"]["repair_materials"]
            if !initDataJson.isEmpty {
                initData = RepairMaterialModel(fromJson: dataJson)
            }

            isGrabOvertime = dataJson["is_grab_overtime"].string
            jointProcessor = dataJson["joint_processor"].string
            lineKey = dataJson["line_key"].string
            lineName = dataJson["line_name"].string
            materialCost = dataJson["material_cost"].double
            otPdTime = dataJson["ot_pd_time"].string
            otPdUser = dataJson["ot_pd_user"].string
            otPdUserID = dataJson["ot_pd_user_id"].string
            pdRemark = dataJson["pd_remark"].string
            pdTime = dataJson["pd_time"].string
            pdUser = dataJson["pd_user"].string
            pdUserID = dataJson["pd_user_id"].string
            procInstID = dataJson["proc_inst_id_"].string
            projectFee = dataJson["project_fee"].string
            projectRate = dataJson["project_rate"].string
            receiveTime = dataJson["receive_time"].string
            receiveUser = dataJson["receive_user"].string
            receiveUserID = dataJson["receive_user_id"].string
            refID = dataJson["ref_id_"].string
            responseResult = dataJson["response_result"].string
            responseTime = dataJson["response_time"].string
            responseTimeOut = dataJson["response_timeout"].string
            responseUser = dataJson["response_user"].string
            responseUserID = dataJson["response_user_id"].string
            returnResult = dataJson["return_result"].string
            returnThreshold = dataJson["return_threshold"].string
            returnTime = dataJson["return_time"].string
            returnUnsatisfyDo = dataJson["return_unsatisfy_do"].string
            returnUser = dataJson["return_user"].string
            returnUserID = dataJson["return_user_id"].string
            returnVisitNum = dataJson["return_visit_num"].string
            returnVisitResult = dataJson["return_visit_result"].int
            returnVisitUser = dataJson["return_visit_user"].string
            returnVisitTime = dataJson["return_visit_time"].string
            returnVisitTimeOut = dataJson["return_visit_timeout"].string
            returnWay = dataJson["return_way"].string
            returnWayID = dataJson["return_way_id"].string
            serviceAttitudeContent = dataJson["service_attitude_content"].string
            serviceQualityContent = dataJson["service_quality_content"].string
            serviceQualityScore = dataJson["service_quality_score"].string
            serviceUnitFee = dataJson["service_unit_fee"].string
            serviceUnitRate = dataJson["service_unit_rate"].string
            staffFee = dataJson["staff_fee"].string
            staffRate = dataJson["staff_rate"].string
            returnScore = dataJson["return_score"].string
            if let type = dataJson["state"].string {
                state = CustomerOrderState(rawValue: type)
            }
            subRepairMaterials = [RepairMaterialModel]()
            let contentListArray = dataJson["sub_repair_materials"].arrayValue
            for contentListJson in contentListArray {
                let value = RepairMaterialModel(fromJson: contentListJson)
                subRepairMaterials.append(value)
            }

            tenantID = dataJson["tenant_id"].string
            cityArea = dataJson["u_city_area"].string
            cityAreaID = dataJson["u_city_area_id"].string
            project = dataJson["u_project"].string
            projectID = dataJson["u_project_id"].string
            region = dataJson["u_region"].string
            regionID = dataJson["u_region_id"].string
            unitName = dataJson["unit_name"].string
            workAscription = dataJson["work_ascription"].string
            workAscriptionCode = dataJson["work_ascription_code"].string
            workOrderTimeout = dataJson["work_order_timeout"].string
            sendPersonID = dataJson["F_pd_assignor_id"].string
            sendPersonName = dataJson["F_pd_assignor"].string
            sendRemark = dataJson["F_pd_remark"].string
        }

    }
    
    func toDictionary() -> [String: Any] {
        var sureDictionary = [String: Any]()

        if buttons != nil {
            sureDictionary["buttons"] = buttons
        }
        if form != nil {
            sureDictionary["form"] = form
        }
        if info != nil {
            sureDictionary["info"] = info?.toDictionary()
        }
        if opinionList != nil {
            sureDictionary["opinionList"] = opinionList
        }
        if permission != nil {
            sureDictionary["permission"] = permission
        }
        if result != nil {
            sureDictionary["result"] = result
        }

        var handleListElements = [[String: Any]]()
        for handleListElement in handleList {
            handleListElements.append(handleListElement.toDictionary())
        }
        sureDictionary["handleList"] = handleListElements
        //延期数据
        if delayInfo != nil {
            sureDictionary["delayInfo"] = delayInfo?.toDictionary()
        }
        //闭单信息
        if forceCloseInfo != nil {
            sureDictionary["forceCloseInfo"] = forceCloseInfo?.toDictionary()
        }

        var dictionary = [String: Any]()

        if appState != nil {
            dictionary["app_state"] = appState
        }
        if artificialCost != nil {
            dictionary["artificial_cost"] = artificialCost
        }
        if assignGrabState != nil {
            dictionary["assign_grab_state"] = assignGrabState
        }
        if assignGrabUser != nil {
            dictionary["assign_grab_user"] = assignGrabUser
        }
        if assignGrabUserID != nil {
            dictionary["assign_grab_user_id"] = assignGrabUserID
        }
        if buildingName != nil {
            dictionary["building_name"] = buildingName
        }
        if appointTime != nil {
            dictionary["bx_appoint_time"] = appointTime
        }
        if appointTimePeriod != nil {
            dictionary["bx_appoint_time_period"] = appointTimePeriod
        }
        if appointTimePeriodID != nil {
            dictionary["bx_appoint_time_period_id"] = appointTimePeriodID
        }
        if area != nil {
            dictionary["bx_area"] = area
        }
        if areaID != nil {
            dictionary["bx_area_id"] = areaID
        }
        if attachment != nil {
            dictionary["bx_attachment"] = attachment
        }
        if buildID != nil {
            dictionary["bx_build_id"] = buildID
        }
        if firstCateLevel != nil {
            dictionary["bx_cate_lv1"] = firstCateLevel
        }
        if firstCateLevelID != nil {
            dictionary["bx_cate_lv1_id"] = firstCateLevelID
        }
        if secondCateLevel != nil {
            dictionary["bx_cate_lv2"] = secondCateLevel
        }
        if secondCateLevelID != nil {
            dictionary["bx_cate_lv2_id"] = secondCateLevelID
        }
        if thirdCateLevel != nil {
            dictionary["bx_cate_lv3"] = thirdCateLevel
        }
        if thirdCateLevelID != nil {
            dictionary["bx_cate_lv3_id"] = thirdCateLevelID
        }
        if code != nil {
            dictionary["bx_code"] = code
        }
        if content != nil {
            dictionary["bx_content"] = content
        }
        if divide != nil {
            dictionary["bx_dk"] = divide
        }
        if divideID != nil {
            dictionary["bx_dk_id"] = divideID
        }
        if house != nil {
            dictionary["bx_house"] = house
        }
        if houseID != nil {
            dictionary["bx_house_id"] = houseID
        }
        if mobile != nil {
            dictionary["bx_mobile"] = mobile
        }
        if propertyAssID != nil {
            dictionary["bx_property_ass_id"] = propertyAssID
        }
        dictionary["bx_property_ass"] = propertyAss
        if recorder != nil {
            dictionary["bx_recorder"] = recorder
        }
        if recorderID != nil {
            dictionary["bx_recorder_id"] = recorderID
        }
        if recorderSeatNumber != nil {
            dictionary["bx_recorder_seat_number"] = recorderSeatNumber
        }
        if time != nil {
            dictionary["bx_time"] = time
        }
        if unitID != nil {
            dictionary["bx_unit_id"] = unitID
        }
        if user != nil {
            dictionary["bx_user"] = user
        }
        if userID != nil {
            dictionary["bx_user_id"] = userID
        }
        if way != nil {
            dictionary["bx_way"] = way
        }
        if wayID != nil {
            dictionary["bx_way_id"] = wayID
        }
        if deadLineTime != nil {
            dictionary["c_deadline_time"] = deadLineTime
        }
        if isSolve != nil {
            dictionary["c_is_solve"] = isSolve
        }
        if returnVisitStatus != nil {
            dictionary["c_return_visit_status"] = returnVisitStatus
        }
        if closeRemark != nil {
            dictionary["close_remark"] = closeRemark
        }
        if closeTime != nil {
            dictionary["close_time"] = closeTime
        }
        if dispatchClose != nil {
            dictionary["dispatch_close"] = dispatchClose
        }
        if faultArea != nil {
            dictionary["fault_area"] = faultArea
        }
        if faultDesc != nil {
            dictionary["fault_desc"] = faultDesc
        }
        if closeApplyAttach != nil {
            dictionary["fclose_apply_attach"] = closeApplyAttach
        }
        if closeApplyReason != nil {
            dictionary["fclose_apply_reason"] = closeApplyReason
        }
        if closeApplyTime != nil {
            dictionary["fclose_apply_time"] = closeApplyTime
        }
        if closeApplyer != nil {
            dictionary["fclose_applyer"] = closeApplyer
        }
        if closeApplyerID != nil {
            dictionary["fclose_applyer_id"] = closeApplyerID
        }
        if closeApproveID != nil {
            dictionary["fclose_approve_id"] = closeApproveID
        }
        if closeApproveResult != nil {
            dictionary["fclose_approve_result"] = closeApproveResult
        }
        if closeApproveTime != nil {
            dictionary["fclose_approve_time"] = closeApproveTime
        }
        if closeIsApplying != nil {
            dictionary["fclose_is_applying"] = closeIsApplying
        }
        if grabTime != nil {
            dictionary["grab_time"] = grabTime
        }
        if gridCode != nil {
            dictionary["grid_code"] = gridCode
        }
        if gridID != nil {
            dictionary["grid_id"] = gridID
        }
        if gridName != nil {
            dictionary["grid_name"] = gridName
        }
        if handleAttach != nil {
            dictionary["handle_attach"] = handleAttach
        }
        if handleFee != nil {
            dictionary["handle_fee"] = handleFee
        }
        if handleIsPaid != nil {
            dictionary["handle_is_paid"] = handleIsPaid
        }
        if handleManHour != nil {
            dictionary["handle_man_hour"] = handleManHour
        }
        if handlePayTime != nil {
            dictionary["handle_pay_time"] = handlePayTime
        }
        if handlePayType != nil {
            dictionary["handle_pay_type"] = handlePayType
        }
        if handlePayTypeID != nil {
            dictionary["handle_pay_type_id"] = handlePayTypeID
        }
        if handleReceiptNo != nil {
            dictionary["handle_receipt_no"] = handleReceiptNo
        }
        if handleResult != nil {
            dictionary["handle_result"] = handleResult
        }
        if handleTime != nil {
            dictionary["handle_time"] = handleTime
        }
        if handleTimeOut != nil {
            dictionary["handle_timeout"] = handleTimeOut
        }
        if handleUser != nil {
            dictionary["handle_user"] = handleUser
        }
        if handleUserID != nil {
            dictionary["handle_user_id"] = handleUserID
        }
        if houseCode != nil {
            dictionary["house_code"] = houseCode
        }
        if houseKeeperAccount != nil {
            dictionary["housekeeper_account"] = houseKeeperAccount
        }
        if houseKeeperName != nil {
            dictionary["housekeeper_name"] = houseKeeperName
        }
        if id != nil {
            dictionary["id_"] = id
        }
        if initData != nil {
            var tempDictionary = [String: Any]()
            tempDictionary["repair_materials"] = initData?.toDictionary()
            dictionary["initData"] = tempDictionary
        }
        if isGrabOvertime != nil {
            dictionary["is_grab_overtime"] = isGrabOvertime
        }
        if jointProcessor != nil {
            dictionary["joint_processor"] = jointProcessor
        }
        if lineKey != nil {
            dictionary["line_key"] = lineKey
        }
        if lineName != nil {
            dictionary["line_name"] = lineName
        }
        if materialCost != nil {
            dictionary["material_cost"] = materialCost
        }
        if otPdTime != nil {
            dictionary["ot_pd_time"] = otPdTime
        }
        if otPdUser != nil {
            dictionary["ot_pd_user"] = otPdUser
        }
        if otPdUserID != nil {
            dictionary["ot_pd_user_id"] = otPdUserID
        }
        if pdRemark != nil {
            dictionary["pd_remark"] = pdRemark
        }
        if pdTime != nil {
            dictionary["pd_time"] = pdTime
        }
        if pdUser != nil {
            dictionary["pd_user"] = pdUser
        }
        if pdUserID != nil {
            dictionary["pd_user_id"] = pdUserID
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }
        if projectFee != nil {
            dictionary["project_fee"] = projectFee
        }
        if projectRate != nil {
            dictionary["project_rate"] = projectRate
        }
        if receiveTime != nil {
            dictionary["receive_time"] = receiveTime
        }
        if receiveUser != nil {
            dictionary["receive_user"] = receiveUser
        }
        if receiveUserID != nil {
            dictionary["receive_user_id"] = receiveUserID
        }
        if refID != nil {
            dictionary["ref_id_"] = refID
        }
        if responseResult != nil {
            dictionary["response_result"] = responseResult
        }
        if responseTime != nil {
            dictionary["response_time"] = responseTime
        }
        if responseTimeOut != nil {
            dictionary["response_timeout"] = responseTimeOut
        }
        if responseUser != nil {
            dictionary["response_user"] = responseUser
        }
        if responseUserID != nil {
            dictionary["response_user_id"] = responseUserID
        }
        if returnResult != nil {
            dictionary["return_result"] = returnResult
        }
        if returnScore != nil {
            dictionary["return_score"] = returnScore
        }
        if returnThreshold != nil {
            dictionary["return_threshold"] = returnThreshold
        }
        if returnTime != nil {
            dictionary["return_time"] = returnTime
        }
        if returnUnsatisfyDo != nil {
            dictionary["return_unsatisfy_do"] = returnUnsatisfyDo
        }
        if returnUser != nil {
            dictionary["return_user"] = returnUser
        }
        if returnUserID != nil {
            dictionary["return_user_id"] = returnUserID
        }
        if returnVisitNum != nil {
            dictionary["return_visit_num"] = returnVisitNum
        }
        if returnVisitResult != nil {
            dictionary["return_visit_result"] = returnVisitResult
        }
        if returnVisitUser != nil {
            dictionary["return_visit_user"] = returnVisitUser
        }
        if returnVisitTime != nil {
            dictionary["return_visit_time"] = returnVisitTime
        }
        if returnVisitTimeOut != nil {
            dictionary["return_visit_timeout"] = returnVisitTimeOut
        }
        if returnWay != nil {
            dictionary["return_way"] = returnWay
        }
        if returnWayID != nil {
            dictionary["return_way_id"] = returnWayID
        }
        if serviceAttitudeContent != nil {
            dictionary["service_attitude_content"] = serviceAttitudeContent
        }
        if serviceQualityContent != nil {
            dictionary["service_quality_content"] = serviceQualityContent
        }
        if serviceQualityScore != nil {
            dictionary["service_quality_score"] = serviceQualityScore
        }
        if serviceUnitFee != nil {
            dictionary["service_unit_fee"] = serviceUnitFee
        }
        if serviceUnitRate != nil {
            dictionary["service_unit_rate"] = serviceUnitRate
        }
        if staffFee != nil {
            dictionary["staff_fee"] = staffFee
        }
        if staffRate != nil {
            dictionary["staff_rate"] = staffRate
        }
        if state != nil {
            dictionary["state"] = state?.rawValue
        }

        var dictionaryElements = [[String: Any]]()
        for contentListElement in subRepairMaterials {
            dictionaryElements.append(contentListElement.toDictionary())
        }
        dictionary["sub_repair_materials"] = dictionaryElements

        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if cityArea != nil {
            dictionary["u_city_area"] = cityArea
        }
        if cityAreaID != nil {
            dictionary["u_city_area_id"] = cityAreaID
        }
        if project != nil {
            dictionary["u_project"] = project
        }
        if projectID != nil {
            dictionary["u_project_id"] = projectID
        }
        if region != nil {
            dictionary["u_region"] = region
        }
        if regionID != nil {
            dictionary["u_region_id"] = regionID
        }
        if unitName != nil {
            dictionary["unit_name"] = unitName
        }
        if workAscription != nil {
            dictionary["work_ascription"] = workAscription
        }
        if workAscriptionCode != nil {
            dictionary["work_ascription_code"] = workAscriptionCode
        }
        if workOrderTimeout != nil {
            dictionary["work_order_timeout"] = workOrderTimeout
        }
        if sendPersonID != nil {
            dictionary["F_pd_assignor_id"] = sendPersonID
        }
        if sendPersonName != nil {
            dictionary["F_pd_assignor"] = sendPersonName
        }
        if sendRemark != nil {
            dictionary["F_pd_remark"] = sendRemark
        }
        
        var tempDictionary = [String: Any]()
        tempDictionary["customer_repair_model"] = dictionary
        sureDictionary["data"] = tempDictionary

        return sureDictionary
    }

    public override init() {
        super.init()
    }

}
