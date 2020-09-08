//
//  EnquiryDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/21.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class EnquiryInfoModel: NSObject {

    public var flowKey: String?
    public var formkey: String?
    ///节点ID
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

public class EnquiryHandleRecordModel: NSObject {

    ///实例ID
    public var procinstID: String?
    ///租户ID
    public var tenantID: String?
    ///主键ID
    public var bizID: String?
    public var enableFlag: String?
    ///处理结果
    public var handleResult: String?
    ///处理时间
    public var handleTime: Int?
    ///处理人
    public var handleUser: String?
    ///处理人ID
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

public class EnquiryCloseModel: NSObject {
    ///申请时间
    public var applyDate: String?
    ///申请原因
    public var applyReason: String?
    ///申请人
    public var applyUser: String?
    ///申请人id
    public var applyUserID: String?
    ///闭单图片
    public var attachment: String?
    ///闭单图片model集合
    public var attachmentArray: [PictureModel] = []
    ///审批时间
    public var auditDate: String?
    ///延期时间
    public var delayTime: String?
    ///无效原因分类
    public var invalidReasonCategory: String?
    ///是否设置为无效
    public var setToInvalid: String?
    ///闭单审批状态
    public var status: ApprovalState?
    ///审批结果
    public var statusStr: String?

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

public class EnquiryDetailModel: NSObject {

    public var buttons: String?
    public var form: String?
    public var info: EnquiryInfoModel?
    public var opinionList: String?
    public var permission: String?
    public var result: Bool?
    ///闭单信息
    public var forceCloseInfo: EnquiryCloseModel?
    ///回复历史记录
    public var handleList: [EnquiryHandleRecordModel] = []
    ///业主app展示的状态
    public var appState: String?
    ///楼栋名称
    public var buildingName: String?
    ///完成截止时间
    public var deadLineTime: String?
    ///是否解决
    public var isSolve: Int?
    ///回访状态
    public var returnVisitStatus: String?
    ///闭单原因
    public var closeRemark: String?
    ///结束时间（闭单时间）
    public var closeTime: String?
    ///闭单或派单到项目0：派单到项目；1：闭单
    public var dispatchClose: String?
    ///强制闭单申请附件
    public var closeApplyAttach: String?
    ///强制闭单申请原因
    public var closeApplyReason: String?
    ///强制闭单申请时间
    public var closeApplyTime: String?
    ///强制闭单申请人
    public var closeApplyer: String?
    ///强制闭单申请人id
    public var closeApplyerID: String?
    ///强制闭单审批流id【k2系统的id】
    public var closeApproveID: String?
    ///强制闭单审批结果
    public var closeApproveResult: String?
    ///强制闭单审批时间
    public var closeApproveTime: String?
    ///是否正在申请强制闭单
    public var closeIsApplying: Int?
    ///网格code
    public var gridCode: String?
    ///网格id
    public var gridID: String?
    ///网格名称
    public var gridName: String?
    ///回复内容
    public var handleCont: String?
    ///回复处理时间
    public var handleTime: String?
    ///处理超时(1：超时)
    public var handleTimeout: String?
    ///回复处理人
    public var handleUser: String?
    ///回复处理人id
    public var handleUserID: String?
    ///房产code
    public var houseCode: String?
    ///管家账号
    public var houseKeeperAccount: String?
    ///管家名称
    public var houseKeeperName: String?
    public var id: String?
    public var initData: String?
    ///条线key
    public var lineKey: String?
    ///条线名称
    public var lineName: String?
    ///实例id
    public var procInstID: String?
    ///外键
    public var refID: String?
    ///响应超时(1：超时)
    public var responseTimeOut: String?
    ///响应沟通结果
    public var responseResult: String?
    ///响应时间
    public var responseTime: String?
    ///响应人
    public var responseUser: String?
    ///响应人id
    public var responseUserID: String?
    ///回访结果
    public var returnResult: String?
    ///服务态度满意度
    public var returnScore: String?
    ///回访满意度阀值
    public var returnThreshold: String?
    ///回访时间
    public var returnTime: String?
    ///回访不满意后处理方式
    public var returnUnsatisfyDo: String?
    ///回访人
    public var returnUser: String?
    ///回访人id
    public var returnUserID: String?
    ///回访次数
    public var returnVisitNum: String?
    ///回访结果
    public var returnVisitResult: Int?
    ///回访人
    public var returnVisitUser: String?
    ///回访时间
    public var returnVisitTime: String?
    ///回访超时(1：超时)
    public var returnVisitTimeOut: String?
    ///回访方式
    public var returnWay: String?
    ///回访方式id
    public var returnWayID: String?
    ///服务态度不满意原因
    public var serviceAttitudeContent: String?
    ///回访质量不满意原因
    public var serviceQualityContent: String?
    ///服务质量满意度
    public var serviceQualityScore: String?
    ///工单状态
    public var state: CustomerOrderState?
    ///租户id
    public var tenantID: String?
    ///城区
    public var cityArea: String?
    ///城区id
    public var cityAreaID: String?
    ///项目
    public var project: String?
    ///项目id
    public var projectID: String?
    ///区域
    public var region: String?
    ///区域id
    public var regionID: String?
    ///单元名称
    public var unitName: String?
    ///工单超时(1：超时)
    public var workOrderTimeOut: String?
    ///图片集合字符串
    public var attachment: String?
    ///图片Model 集合
    public var attachmentArray: [PictureModel] = []
    ///楼栋id
    public var buildID: String?
    ///问询类别
    public var cate: String?
    ///问询类别id
    public var cateID: String?
    ///问询类别
    public var subCate: String?
    ///问询类别id
    public var subCateID: String?
    ///工单编号
    public var code: String?
    ///问询内容
    public var content: String?
    ///直接答复内容
    public var directReply: String?
     ///分期
    public var divide: String?
    ///分期id
    public var divideID: String?
    ///房产
    public var house: String?
    ///房产id
    public var houseID: String?
    ///联系电话
    public var mobile: String?
    ///问询处理方式(直接处理，指定人员)
    public var processMode: String?
    ///记录人
    public var recorder: String?
    ///记录人id
    public var recorderID: String?
    ///坐席单号
    public var recorderSeatNumber: String?
    ///问询时间
    public var time: String?
    ///单元id
    public var unitID: String?
    ///问询人
    public var user: String?
    ///问询人id
    public var userID: String?
    ///问询方式
    public var way: String?
    ///问询方式id
    public var wayID: String?
    ///指派人ID
    public var sendPersonID: String?
    ///指派人
    public var sendPersonName: String?
    ///派单备注
    public var sendRemark: String?
    ///派单时间
    public var sendTime: String?
    ///派单人
    public var pdUser: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        buttons = json["buttons"].string
        form = json["form"].string

        let initDataJson = json["info"]
        if !initDataJson.isEmpty {
            info = EnquiryInfoModel(fromJson: initDataJson)
        }
        opinionList = json["opinionList"].string
        permission = json["permission"].string
        result = json["result"].bool

        //回复历史
        handleList = [EnquiryHandleRecordModel]()
        let handleArray = json["handleList"].arrayValue
        for handleJson in handleArray {
            let value = EnquiryHandleRecordModel(fromJson: handleJson)
            handleList.append(value)
        }
        //闭单信息
        let forceCloseInfoJson = json["forceCloseInfo"]
        if !forceCloseInfoJson.isEmpty {
            forceCloseInfo = EnquiryCloseModel(fromJson: forceCloseInfoJson)
        }

        let dataJson = json["data"]["customer_enquiry_model"]

        if !dataJson.isEmpty {

            appState = dataJson["app_state"].string
            buildingName = dataJson["building_name"].string
            deadLineTime = dataJson["c_deadline_time"].string
            isSolve = dataJson["c_is_solve"].int
            returnVisitStatus = dataJson["c_return_visit_status"].string
            closeRemark = dataJson["close_remark"].string
            closeTime = dataJson["close_time"].string
            dispatchClose = dataJson["dispatch_close"].string
            closeApplyAttach = dataJson["fclose_apply_attach"].string
            closeApplyReason = dataJson["fclose_apply_reason"].string
            closeApplyTime = dataJson["fclose_apply_time"].string
            closeApplyer = dataJson["fclose_applyer"].string
            closeApplyerID = dataJson["fclose_applyer_id"].string
            closeApproveID = dataJson["fclose_approve_id"].string
            closeApproveResult = dataJson["fclose_approve_result"].string
            closeApproveTime = dataJson["fclose_approve_time"].string
            closeIsApplying = dataJson["fclose_is_applying"].int
            gridCode = dataJson["grid_code"].string
            gridID = dataJson["grid_id"].string
            gridName = dataJson["grid_name"].string
            handleCont = dataJson["handle_cont"].string
            handleTime = dataJson["handle_time"].string
            handleTimeout = dataJson["handle_timeout"].string
            handleUser = dataJson["handle_user"].string
            handleUserID = dataJson["handle_user_id"].string
            responseResult = dataJson["response_result"].string
            responseTime = dataJson["response_time"].string
            responseUser = dataJson["response_user"].string
            responseUserID = dataJson["response_user_id"].string
            houseCode = dataJson["house_code"].string
            houseKeeperAccount = dataJson["housekeeper_account"].string
            houseKeeperName = dataJson["housekeeper_name"].string
            id = dataJson["id_"].string
            initData = dataJson["initData"].string
            lineKey = dataJson["line_key"].string
            lineName = dataJson["line_name"].string
            procInstID = dataJson["proc_inst_id_"].string
            refID = dataJson["ref_id_"].string
            responseTimeOut = dataJson["response_timeout"].string
            returnResult = dataJson["return_result"].string
            returnScore = dataJson["return_score"].string
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

            if let type = dataJson["state"].string {
                state = CustomerOrderState(rawValue: type)
            }

            tenantID = dataJson["tenant_id"].string
            cityArea = dataJson["u_city_area"].string
            cityAreaID = dataJson["u_city_area_id"].string
            project = dataJson["u_project"].string
            projectID = dataJson["u_project_id"].string
            region = dataJson["u_region"].string
            regionID = dataJson["u_region_id"].string
            unitName = dataJson["unit_name"].string
            workOrderTimeOut = dataJson["work_order_timeout"].string

            attachment = dataJson["wx_attachment"].string
            attachmentArray = [PictureModel]() //图片集合
            let tempFiles = dataJson["wx_attachment"].stringValue
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

            buildID = dataJson["wx_build_id"].string
            cate = dataJson["wx_cate"].string
            cateID = dataJson["wx_cate_id"].string
            subCate = dataJson["wx_sub_cate"].string
            subCateID = dataJson["wx_sub_cate_id"].string
            code = dataJson["wx_code"].string
            content = dataJson["wx_content"].string
            directReply = dataJson["wx_direct_reply"].string
            divide = dataJson["wx_dk"].string
            divideID = dataJson["wx_dk_id"].string
            house = dataJson["wx_house"].string
            houseID = dataJson["wx_house_id"].string
            mobile = dataJson["wx_mobile"].string
            processMode = dataJson["wx_process_mode"].string
            recorder = dataJson["wx_recorder"].string
            recorderID = dataJson["wx_recorder_id"].string
            recorderSeatNumber = dataJson["wx_recorder_seat_number"].string
            time = dataJson["wx_time"].string
            unitID = dataJson["wx_unit_id"].string
            user = dataJson["wx_user"].string
            userID = dataJson["wx_user_id"].string
            way = dataJson["wx_way"].string
            wayID = dataJson["wx_way_id"].string
            sendPersonID = dataJson["pd_assignor_id"].string
            sendPersonName = dataJson["pd_assignor"].string
            sendRemark = dataJson["pd_remark"].string
            sendTime = dataJson["pd_time"].string
            pdUser = dataJson["pd_user"].string
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
        //闭单信息
        if forceCloseInfo != nil {
            sureDictionary["forceCloseInfo"] = forceCloseInfo?.toDictionary()
        }

        var dictionary = [String: Any]()

        if appState != nil {
            dictionary["app_state"] = appState
        }
        if buildingName != nil {
            dictionary["building_name"] = buildingName
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
        if gridCode != nil {
            dictionary["grid_code"] = gridCode
        }
        if gridID != nil {
            dictionary["grid_id"] = gridID
        }
        if gridName != nil {
            dictionary["grid_name"] = gridName
        }
        if handleCont != nil {
            dictionary["handle_cont"] = handleCont
        }
        if handleTime != nil {
            dictionary["handle_time"] = handleTime
        }
        if handleTimeout != nil {
            dictionary["handle_timeout"] = handleTimeout
        }
        if handleUser != nil {
            dictionary["handle_user"] = handleUser
        }
        if handleUserID != nil {
            dictionary["handle_user_id"] = handleUserID
        }
        if responseResult != nil {
            dictionary["response_result"] = responseResult
        }
        if responseTime != nil {
            dictionary["response_time"] = responseTime
        }
        if responseUser != nil {
            dictionary["response_user"] = responseUser
        }
        if responseUserID != nil {
            dictionary["response_user_id"] = responseUserID
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
            dictionary["initData"] = initData
        }
        if lineKey != nil {
            dictionary["line_key"] = lineKey
        }
        if lineName != nil {
            dictionary["line_name"] = lineName
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }
        if refID != nil {
            dictionary["ref_id_"] = refID
        }
        if responseTimeOut != nil {
            dictionary["response_timeout"] = responseTimeOut
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
        if state != nil {
            dictionary["state"] = state?.rawValue
        }
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
        if workOrderTimeOut != nil {
            dictionary["work_order_timeout"] = workOrderTimeOut
        }
        if attachment != nil {
            dictionary["wx_attachment"] = attachment
        }
        if buildID != nil {
            dictionary["wx_build_id"] = buildID
        }
        if cate != nil {
            dictionary["wx_cate"] = cate
        }
        if cateID != nil {
            dictionary["wx_cate_id"] = cateID
        }
        if subCate != nil {
            dictionary["wx_sub_cate"] = subCate
        }
        if subCateID != nil {
            dictionary["wx_sub_cate_id"] = subCateID
        }
        if code != nil {
            dictionary["wx_code"] = code
        }
        if content != nil {
            dictionary["wx_content"] = content
        }
        if directReply != nil {
            dictionary["wx_direct_reply"] = directReply
        }
        if divide != nil {
            dictionary["wx_dk"] = divide
        }
        if divideID != nil {
            dictionary["wx_dk_id"] = divideID
        }
        if house != nil {
            dictionary["wx_house"] = house
        }
        if houseID != nil {
            dictionary["wx_house_id"] = houseID
        }
        if mobile != nil {
            dictionary["wx_mobile"] = mobile
        }
        if processMode != nil {
            dictionary["wx_process_mode"] = processMode
        }
        if recorder != nil {
            dictionary["wx_recorder"] = recorder
        }
        if recorderID != nil {
            dictionary["wx_recorder_id"] = recorderID
        }
        if recorderSeatNumber != nil {
            dictionary["wx_recorder_seat_number"] = recorderSeatNumber
        }
        if time != nil {
            dictionary["wx_time"] = time
        }
        if unitID != nil {
            dictionary["wx_unit_id"] = unitID
        }
        if user != nil {
            dictionary["wx_user"] = user
        }
        if userID != nil {
            dictionary["wx_user_id"] = userID
        }
        if way != nil {
            dictionary["wx_way"] = way
        }
        if wayID != nil {
            dictionary["wx_way_id"] = wayID
        }
        if sendPersonID != nil {
            dictionary["pd_assignor_id"] = sendPersonID
        }
        if sendPersonName != nil {
            dictionary["pd_assignor"] = sendPersonName
        }
        if sendRemark != nil {
            dictionary["pd_remark"] = sendRemark
        }
        if sendTime != nil {
            dictionary["pd_time"] = sendTime
        }
        if pdUser != nil {
            dictionary["pd_user"] = pdUser
        }
        
        var tempDictionary = [String: Any]()
        tempDictionary["customer_enquiry_model"] = dictionary
        sureDictionary["data"] = tempDictionary

        return sureDictionary
    }

    public override init() {
        super.init()
    }
}
