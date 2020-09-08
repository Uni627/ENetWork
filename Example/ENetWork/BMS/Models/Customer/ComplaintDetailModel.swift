//
//  ComplaintDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/19.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

//追加投诉信息
public class ComplainAppendModel: NSObject {

    public var content: String?
    public var time: String?
    public var user: String?
    public var userID: String?
    public var isLast = false

    public override init() {
        super.init()
    }
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        content = json["F_ac_content"].string
        time = json["F_ac_time"].string
        user = json["F_ac_user"].string
        userID = json["F_ac_user_id"].string
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if content != nil {
            dictionary["F_ac_content"] = content
        }
        if time != nil {
            dictionary["F_ac_time"] = time
        }
        if user != nil {
            dictionary["F_ac_user"] = user
        }
        if userID != nil {
            dictionary["F_ac_user_id"] = userID
        }
        return dictionary
    }

}

public class ComplaintHandleRecordModel: NSObject {

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
    public var isLast = false

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

public class ComplaintDelayModel: NSObject {

    public var applyDate: String?
    public var applyReason: String?
    public var applyUser: String?
    public var applyUserID: String?
    public var attachment: String?                     //延期图片
    public var attachmentArray: [PictureModel] = []    //延期图片model集合
    public var auditDate: String?
    public var delayTime: String?                      //延期天数
    public var status: ApprovalState?                  //延期审批状态
    public var statusStr: String?                      //审批结果

    public override init() {
        super.init()
    }

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

}

public class ComplaintCloseModel: NSObject {

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

    public override init() {
        super.init()
    }

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

}

public class ComplaintDetailModel: NSObject {

    public var loadInstructions: Bool?
    public var form: String?
    public var formResult: String?
    public var opinionList: String?
    public var permission: String?

    public var delayInfo: ComplaintDelayModel?                 //延期数据
    public var forceCloseInfo: ComplaintCloseModel?            //闭单信息
    public var handleList: [ComplaintHandleRecordModel] = []   //处理历史记录

    public var appState: String?                       //业主app展示的状态
    public var closeTime: String?                      //结束时间（闭单时间）
    public var closeApplyAttach: String?               //强制闭单申请附件
    public var closeApplyInvalid: String?              //强制闭单是否申请无效投诉
    public var closeApplyReason: String?               //强制闭单申请原因
    public var closeApplyTime: String?                 //强制闭单申请时间
    public var closeApplyer: String?                   //强制闭单申请人
    public var closeApplyerID: String?                 //强制闭单申请人 id
    public var closeApproveID: String?                 //强制闭单审批流id
    public var closeApproveResult: String?             //强制闭单审批结果
    public var closeApproveTime: String?               //强制闭单审批时间
    public var handleResult: String?                   //处理结果
    public var handleTime: String?                     //处理时间
    public var handleUser: String?                     //处理人
    public var handleUserID: String?                   //处理人id
    public var invalidAttachment: String?              //无效原因附件
    public var invalidReason: String?                  //无效原因
    public var invalidReasonCate: String?              //无效原因分类
    public var invalidReasonCateID: String?            //无效原因分类id
    public var isValid: String?                        //是否有效
    public var lineKey: String?                        //条线key
    public var lineName: String?                       //条线名称
    public var receiveTime: String?                    //接单时间
    public var receiveUser: String?                    //接单人
    public var receiveUserID: String?                  //接单人id
    public var recorderSeatNumber: String?             //坐席单号
    public var responseResult: String?                 //响应沟通结果
    public var responseTime: String?                   //响应时间
    public var responseUser: String?                   //响应人
    public var responseUserID: String?                 //响应人id
    public var returnResult: String?                   //评价说明（未解决）
    public var returnScore: String?                    //服务态度满意度
    public var returnThreshold: String?                //回访满意度阀值
    public var returnTime: String?                     //回访时间
    public var returnUser: String?                     //回访人
    public var returnUserID: String?                   //回访人id
    public var returnWay: String?                      //回访方式
    public var returnWayID: String?                    //回访方式id
    public var state: CustomerOrderState?               //工单状态
    public var attachment: String?                                 //图片集合字符串
    public var attachmentArray: [PictureModel] = []                //图片Model 集合
    public var buildID: String?                        //楼栋id
    public var cate: String?                           //投诉类别
    public var cateID: String?                         //投诉类别id
    public var code: String?                           //工单编号
    public var content: String?                        //投诉内容
    public var divide: String?                         //分期
    public var divideID: String?                       //分期id
    public var house: String?                          //房产信息
    public var houseID: String?                        //房产信息id
    public var mobile: String?                         //联系电话
    public var property: String?                       //投诉性质
    public var propertyID: String?                     //投诉人id
    public var recorder: String?                       //记录人
    public var recorderID: String?                     //记录人id
    public var time: String?                           //投诉时间
    public var unitID: String?                         //单元id
    public var user: String?                           //投诉人
    public var userID: String?                         //投诉人id
    public var way: String?                            //投诉方式
    public var wayID: String?                          //投诉方式id
    public var buildingName: String?                   //楼栋名称
    public var deadLineTime: String?                   //完成截止时间
    public var isSolve: Int?                           //是否解决
    public var returnVisitStatus: String?              //回访状态
    public var closeRemark: String?                    //闭单原因
    public var dispatchClose: String?                  //闭单或派单到项目0：派单到项目；1：闭单
    public var closeIsApplying: Int?                   //是否正在申请强制闭单
    public var gridCode: String?                       //网格code
    public var gridID: String?                         //网格id
    public var gridName: String?                       //网格名称
    public var handleTimeout: String?                  //处理超时(1：超时)
    public var houseCode: String?                      //房产code
    public var housekeeperAccount: String?             //管家账号
    public var housekeeperName: String?                //管家名称
    public var id: String?
    public var initData: ComplainAppendModel?
    public var procInstID: String?                     //流程实例id
    public var refID: String?                          //外键
    public var responseTimeOut: Int?                   //响应超时(1：超时)
    public var returnVisitNum: String?                 //回访次数
    public var returnVisitResult: Int?              //回访结果
    public var returnVisitUser: String?                 //回访人
    public var returnVisitTime: String?                 //回访时间
    public var returnVisitTimeout: String?             //回访超时(1：超时)
    public var serviceAttitudeContent: String?         //服务态度不满意原因
    public var serviceQualityContent: String?          //回访质量不满意原因
    public var serviceQualityScore: String?            //服务质量满意度
    public var complainAppendArray: [ComplainAppendModel] = []    //追加投诉信息
    public var tenantID: String?                       //租户id
    public var cityArea: String?                       //城区
    public var cityAreaID: String?                     //城区id
    public var project: String?                        //项目
    public var projectID: String?                      //项目id
    public var region: String?                         //区域
    public var regionID: String?                       //区域id
    public var unitName: String?                       //单元名称
    public var workOrderTimeOut: Int?                  //工单超时(1：超时)
    public var sendPersonID: String?                    //指派人ID
    public var sendPersonName: String?                  //指派人
    public var sendRemark: String?                      //派单备注
    public var sendTime: String?                      //派单时间
    public var pdUser: String?                          //派单人


    public override init() {
        super.init()
    }
    
    public init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        form = json["form"].string
        formResult = json["formResult"].string
        opinionList = json["opinionList"].string
        permission = json["permission"].string

        handleList = [ComplaintHandleRecordModel]()
        let handleArray = json["handleList"].arrayValue
        for handleJson in handleArray {
            let value = ComplaintHandleRecordModel(fromJson: handleJson)
            handleList.append(value)
        }
        //延期数据
        let delayInfoJson = json["delayInfo"]
        if !delayInfoJson.isEmpty {
            delayInfo = ComplaintDelayModel(fromJson: delayInfoJson)
        }
        //闭单信息
        let forceCloseInfoJson = json["forceCloseInfo"]
        if !forceCloseInfoJson.isEmpty {
            forceCloseInfo = ComplaintCloseModel(fromJson: forceCloseInfoJson)
        }

        let dataJson = json["data"]["customer_complain_model"]

        if !dataJson.isEmpty {

            appState = dataJson["F_app_state"].string
            closeTime = dataJson["F_close_time"].string
            closeApplyAttach = dataJson["F_fclose_apply_attach"].string
            closeApplyInvalid = dataJson["F_fclose_apply_invalid"].string
            closeApplyReason = dataJson["F_fclose_apply_reason"].string
            closeApplyTime = dataJson["F_fclose_apply_time"].string
            closeApplyer = dataJson["F_fclose_applyer"].string
            closeApplyerID = dataJson["F_fclose_applyer_id"].string
            closeApproveID = dataJson["F_fclose_approve_id"].string
            closeApproveResult = dataJson["F_fclose_approve_result"].string
            closeApproveTime = dataJson["F_fclose_approve_time"].string
            handleResult = dataJson["F_handle_result"].string
            handleTime = dataJson["F_handle_time"].string
            handleUser = dataJson["F_handle_user"].string
            handleUserID = dataJson["F_handle_user_id"].string
            invalidAttachment = dataJson["F_invalid_attachment"].string
            invalidReason = dataJson["F_invalid_reason"].string
            invalidReasonCate = dataJson["F_invalid_reason_cate"].string
            invalidReasonCateID = dataJson["F_invalid_reason_cate_id"].string
            isValid = dataJson["F_is_valid"].string
            lineKey = dataJson["F_line_key"].string
            lineName = dataJson["F_line_name"].string
            receiveTime = dataJson["F_receive_time"].string
            receiveUser = dataJson["F_receive_user"].string
            receiveUserID = dataJson["F_receive_user_id"].string
            recorderSeatNumber = dataJson["F_recorder_seat_number"].string
            responseResult = dataJson["F_response_result"].string
            responseTime = dataJson["F_response_time"].string
            responseUser = dataJson["F_response_user"].string
            responseUserID = dataJson["F_response_user_id"].string
            returnResult = dataJson["F_return_result"].string
            returnScore = dataJson["F_return_score"].string
            returnThreshold = dataJson["F_return_threshold"].string
            returnTime = dataJson["F_return_time"].string
            returnUser = dataJson["F_return_user"].string
            returnUserID = dataJson["F_return_user_id"].string
            returnWay = dataJson["F_return_way"].string
            returnWayID = dataJson["F_return_way_id"].string

            if let type = dataJson["F_state"].string {
                state = CustomerOrderState(rawValue: type)
            }

            attachment = dataJson["F_ts_attachment"].string
            attachmentArray = [PictureModel]() //图片集合
            let tempFiles = dataJson["F_ts_attachment"].stringValue
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

            buildID = dataJson["F_ts_build_id"].string
            cate = dataJson["F_ts_cate"].string
            cateID = dataJson["F_ts_cate_id"].string
            code = dataJson["F_ts_code"].string
            content = dataJson["F_ts_content"].string
            divide = dataJson["F_ts_dk"].string
            divideID = dataJson["F_ts_dk_id"].string
            house = dataJson["F_ts_house"].string
            houseID = dataJson["F_ts_house_id"].string
            mobile = dataJson["F_ts_mobile"].string
            property = dataJson["F_ts_property"].string
            propertyID = dataJson["F_ts_property_id"].string
            recorder = dataJson["F_ts_recorder"].string
            recorderID = dataJson["F_ts_recorder_id"].string
            time = dataJson["F_ts_time"].string
            unitID = dataJson["F_ts_unit_id"].string
            user = dataJson["F_ts_user"].string
            userID = dataJson["F_ts_user_id"].string
            way = dataJson["F_ts_way"].string
            wayID = dataJson["F_ts_way_id"].string
            buildingName = dataJson["building_name"].string
            deadLineTime = dataJson["c_deadline_time"].string
            isSolve = dataJson["c_is_solve"].int
            returnVisitStatus = dataJson["c_return_visit_status"].string
            closeRemark = dataJson["close_remark"].string
            dispatchClose = dataJson["dispatch_close"].string
            closeIsApplying = dataJson["fclose_is_applying"].int
            gridCode = dataJson["grid_code"].string
            gridID = dataJson["grid_id"].string
            gridName = dataJson["grid_name"].string
            handleTimeout = dataJson["handle_timeout"].string
            houseCode = dataJson["house_code"].string
            housekeeperAccount = dataJson["housekeeper_account"].string
            housekeeperName = dataJson["housekeeper_name"].string
            id = dataJson["id_"].string

            let initDataJson = dataJson["initData"]["complain_append"]
            if !initDataJson.isEmpty {
                initData = ComplainAppendModel(fromJson: dataJson)
            }

            procInstID = dataJson["proc_inst_id_"].string
            refID = dataJson["ref_id_"].string
            responseTimeOut = dataJson["response_timeout"].int
            returnVisitNum = dataJson["return_visit_num"].string
            returnVisitResult = dataJson["return_visit_result"].int
            returnVisitUser = dataJson["return_visit_user"].string
            returnVisitTime = dataJson["return_visit_time"].string

            returnVisitTimeout = dataJson["return_visit_timeout"].string
            serviceAttitudeContent = dataJson["service_attitude_content"].string
            serviceQualityContent = dataJson["service_quality_content"].string
            serviceQualityScore = dataJson["service_quality_score"].string

            complainAppendArray = [ComplainAppendModel]()
            let subArray = dataJson["sub_complain_append"].arrayValue
            for subJson in subArray {
                let value = ComplainAppendModel(fromJson: subJson)
                complainAppendArray.append(value)
            }
            
            tenantID = dataJson["tenant_id"].string
            cityArea = dataJson["u_city_area"].string
            cityAreaID = dataJson["u_city_area_id"].string
            project = dataJson["u_project"].string
            projectID = dataJson["u_project_id"].string
            region = dataJson["u_region"].string
            regionID = dataJson["u_region_id"].string
            unitName = dataJson["unit_name"].string
            workOrderTimeOut = dataJson["work_order_timeout"].int
            sendPersonID = dataJson["F_pd_assignor_id"].string
            sendPersonName = dataJson["F_pd_assignor"].string
            sendRemark = dataJson["F_pd_remark"].string
            sendTime = dataJson["F_pd_time"].string
            pdUser = dataJson["F_pd_user"].string
        }

    }

    func toDictionary() -> [String: Any] {
        var sureDictionary = [String: Any]()

        if form != nil {
            sureDictionary["form"] = form
        }
        if formResult != nil {
            sureDictionary["formResult"] = formResult
        }
        if opinionList != nil {
            sureDictionary["opinionList"] = opinionList
        }
        if permission != nil {
            sureDictionary["permission"] = permission
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
            dictionary["F_app_state"] = appState
        }
        if closeTime != nil {
            dictionary["F_close_time"] = closeTime
        }
        if closeApplyAttach != nil {
            dictionary["F_fclose_apply_attach"] = closeApplyAttach
        }
        if closeApplyInvalid != nil {
            dictionary["F_fclose_apply_invalid"] = closeApplyInvalid
        }
        if closeApplyReason != nil {
            dictionary["F_fclose_apply_reason"] = closeApplyReason
        }
        if closeApplyTime != nil {
            dictionary["F_fclose_apply_time"] = closeApplyTime
        }
        if closeApplyer != nil {
            dictionary["F_fclose_applyer"] = closeApplyer
        }
        if closeApplyerID != nil {
            dictionary["F_fclose_applyer_id"] = closeApplyerID
        }
        if closeApproveID != nil {
            dictionary["F_fclose_approve_id"] = closeApproveID
        }
        if closeApproveResult != nil {
            dictionary["F_fclose_approve_result"] = closeApproveResult
        }
        if closeApproveTime != nil {
            dictionary["F_fclose_approve_time"] = closeApproveTime
        }
        if handleResult != nil {
            dictionary["F_handle_result"] = handleResult
        }
        if handleTime != nil {
            dictionary["F_handle_time"] = handleTime
        }
        if handleUser != nil {
            dictionary["F_handle_user"] = handleUser
        }
        if handleUserID != nil {
            dictionary["F_handle_user_id"] = handleUserID
        }
        if invalidAttachment != nil {
            dictionary["F_invalid_attachment"] = invalidAttachment
        }
        if invalidReason != nil {
            dictionary["F_invalid_reason"] = invalidReason
        }
        if invalidReasonCate != nil {
            dictionary["F_invalid_reason_cate"] = invalidReasonCate
        }
        if invalidReasonCateID != nil {
            dictionary["F_invalid_reason_cate_id"] = invalidReasonCateID
        }
        if isValid != nil {
            dictionary["F_is_valid"] = isValid
        }
        if lineKey != nil {
            dictionary["F_line_key"] = lineKey
        }
        if lineName != nil {
            dictionary["F_line_name"] = lineName
        }
        if receiveTime != nil {
            dictionary["F_receive_time"] = receiveTime
        }
        if receiveUser != nil {
            dictionary["F_receive_user"] = receiveUser
        }
        if receiveUserID != nil {
            dictionary["F_receive_user_id"] = receiveUserID
        }
        if recorderSeatNumber != nil {
            dictionary["F_recorder_seat_number"] = recorderSeatNumber
        }
        if responseResult != nil {
            dictionary["F_response_result"] = responseResult
        }
        if responseTime != nil {
            dictionary["F_response_time"] = responseTime
        }
        if responseUser != nil {
            dictionary["F_response_user"] = responseUser
        }
        if responseUserID != nil {
            dictionary["F_response_user_id"] = responseUserID
        }
        if returnResult != nil {
            dictionary["F_return_result"] = returnResult
        }
        if returnScore != nil {
            dictionary["F_return_score"] = returnScore
        }
        if returnThreshold != nil {
            dictionary["F_return_threshold"] = returnThreshold
        }
        if returnTime != nil {
            dictionary["F_return_time"] = returnTime
        }
        if returnUser != nil {
            dictionary["F_return_user"] = returnUser
        }
        if returnUserID != nil {
            dictionary["F_return_user_id"] = returnUserID
        }
        if returnWay != nil {
            dictionary["F_return_way"] = returnWay
        }
        if returnWayID != nil {
            dictionary["F_return_way_id"] = returnWayID
        }
        if state != nil {
            dictionary["F_state"] = state?.rawValue
        }
        if attachment != nil {
            dictionary["F_ts_attachment"] = attachment
        }
        if buildID != nil {
            dictionary["F_ts_build_id"] = buildID
        }
        if cate != nil {
            dictionary["F_ts_cate"] = cate
        }
        if cateID != nil {
            dictionary["F_ts_cate_id"] = cateID
        }
        if code != nil {
            dictionary["F_ts_code"] = code
        }
        if content != nil {
            dictionary["F_ts_content"] = content
        }
        if divide != nil {
            dictionary["F_ts_dk"] = divide
        }
        if divideID != nil {
            dictionary["F_ts_dk_id"] = divideID
        }
        if house != nil {
            dictionary["F_ts_house"] = house
        }
        if houseID != nil {
            dictionary["F_ts_house_id"] = houseID
        }
        if mobile != nil {
            dictionary["F_ts_mobile"] = mobile
        }
        if property != nil {
            dictionary["F_ts_property"] = property
        }
        if propertyID != nil {
            dictionary["F_ts_property_id"] = propertyID
        }
        if recorder != nil {
            dictionary["F_ts_recorder"] = recorder
        }
        if recorderID != nil {
            dictionary["F_ts_recorder_id"] = recorderID
        }
        if time != nil {
            dictionary["F_ts_time"] = time
        }
        if unitID != nil {
            dictionary["F_ts_unit_id"] = unitID
        }
        if user != nil {
            dictionary["F_ts_user"] = user
        }
        if userID != nil {
            dictionary["F_ts_user_id"] = userID
        }
        if way != nil {
            dictionary["F_ts_way"] = way
        }
        if wayID != nil {
            dictionary["F_ts_way_id"] = wayID
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
        if dispatchClose != nil {
            dictionary["dispatch_close"] = dispatchClose
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
        if handleTimeout != nil {
            dictionary["handle_timeout"] = handleTimeout
        }
        if houseCode != nil {
            dictionary["house_code"] = houseCode
        }
        if housekeeperAccount != nil {
            dictionary["housekeeper_account"] = housekeeperAccount
        }
        if housekeeperName != nil {
            dictionary["housekeeper_name"] = housekeeperName
        }
        if id != nil {
            dictionary["id_"] = id
        }
        if initData != nil {
            var tempDictionary = [String: Any]()
            tempDictionary["complain_append"] = initData?.toDictionary()
            dictionary["initData"] = tempDictionary
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
        if returnVisitTimeout != nil {
            dictionary["return_visit_timeout"] = returnVisitTimeout
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
        var dictionaryElements = [[String: Any]]()
        for contentListElement in complainAppendArray {
            dictionaryElements.append(contentListElement.toDictionary())
        }
        dictionary["sub_complain_append"] = dictionaryElements

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
        if sendPersonID != nil {
            dictionary["F_pd_assignor_id"] = sendPersonID
        }
        if sendPersonName != nil {
            dictionary["F_pd_assignor"] = sendPersonName
        }
        if sendRemark != nil {
            dictionary["F_pd_remark"] = sendRemark
        }
        if sendTime != nil {
            dictionary["F_pd_time"] = sendTime
        }
        if pdUser != nil {
            dictionary["F_pd_user"] = pdUser
        }

        var tempDictionary = [String: Any]()
        tempDictionary["customer_complain_model"] = dictionary
        sureDictionary["data"] = tempDictionary

        return sureDictionary
    }

}
