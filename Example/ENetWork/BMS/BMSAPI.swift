//
//  BMSAPI.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/11.
//  Copyright © 2019 LynnCheng. All rights reserved.
//


public class BMSAPI: EBaseAPI {

    public static let shared = BMSAPI()
    
    // MARK: - - 首页
    ///首页权限菜单
    public func getCurrentUserMenu(success:@escaping (([DropScopeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/sysMenu/v1/getCurrentUserMenu?menuType=2", success: { (json) in
            
            var menuArray: [DropScopeModel] = []
            if let subJson = json["data"].array {
                for menuJson in subJson {
                    let model = DropScopeModel(fromJson: menuJson)
                    menuArray.append(model)
                }
                success(menuArray)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待处理工单（客户投诉、客户报修、客户问询）消息数
    public func getMapByUcDivKeys(success:@escaping (([HomeOrderNewNumberModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getMapByUcDivKeys?defKeys=customer_complain_flow,customer_repair_flow,customer_enquiry_flow,unqualified_key", parameters: Dictionary(), success: { (json) in
            // customer_complain_flow: 客户投诉待办数量   customer_repair_flow: 客户报修待办数量   customer_enquiry_flow: 客户问询待办数量
            let complainFlow = json["data"]["customer_complain_flow"].intValue
            let repairFlow = json["data"]["customer_repair_flow"].intValue
            let enquiryFlow = json["data"]["customer_enquiry_flow"].intValue
            
            let complainFlowTimeOut = json["data"]["customer_complain_flowis_coming_timeout"].intValue
            let repairFlowTimeOut = json["data"]["customer_repair_flowis_coming_timeout"].intValue
            let enquiryFlowTimeOut = json["data"]["customer_enquiry_flowis_coming_timeout"].intValue
            let unqualified = json["data"]["unqualified_key"].intValue
            let unqualifiedTimeOut = json["data"]["unqualified_keyis_coming_timeout"].intValue
            
            let bhgd = HomeOrderNewNumberModel(alias: "unqualified", number: unqualified, warnNumber: unqualifiedTimeOut)
            
            let complain = HomeOrderNewNumberModel(alias: "complain", number: complainFlow, warnNumber: complainFlowTimeOut)
            
            let repair = HomeOrderNewNumberModel(alias: "repair", number: repairFlow, warnNumber: repairFlowTimeOut)
            
            let enquiry = HomeOrderNewNumberModel(alias: "enquiry", number: enquiryFlow, warnNumber: enquiryFlowTimeOut)
            
            var dataArray: [HomeOrderNewNumberModel] = []
            dataArray.append(bhgd)
            dataArray.append(complain)
            dataArray.append(repair)
            dataArray.append(enquiry)
            
            success(dataArray)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待处理工单（派工单、计划工单、巡查工单）消息数量
    public func getPlanWaitCount(success:@escaping (([HomeOrderNewNumberModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/plan/waitCount", success: { (json) in
            // planOrderCount: 计划工单待办数量   dispatchOrderCount: 派工单待办数量   inspectionOrderCount: 巡查工单待办数量
            
            let planCount = json["data"]["planOrderCount"].intValue
            let dispatchCount = json["data"]["dispatchOrderCount"].intValue
            let inspectionCount = json["data"]["inspectionOrderCount"].intValue
            
            let planCount1 = json["data"]["planOrderFlowListIsComing"].intValue
            let dispatchCount1 = json["data"]["dispatchOrderFlowListIsComing"].intValue
            let inspectionCount1 = json["data"]["inspectionOrderFlowListIsComing"].intValue
            
            let dispatch = HomeOrderNewNumberModel(alias: "dispatch", number: dispatchCount, warnNumber: dispatchCount1)
            let plan = HomeOrderNewNumberModel(alias: "plan", number: planCount, warnNumber: planCount1)
            let inspection = HomeOrderNewNumberModel(alias: "inspection", number: inspectionCount, warnNumber: inspectionCount1)
            
            var dataArray: [HomeOrderNewNumberModel] = []
            dataArray.append(dispatch)
            dataArray.append(plan)
            dataArray.append(inspection)
            success(dataArray)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///抢单数量
    public func getGrabCount(success:@escaping ((Int) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/task/v1/getGrabCount", success: { (json) in
            
            if let count = json["data"].int {
                success(count)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待审批数量
    public func getUserAuditCount(success:@escaping ((Int) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/task/v1/getUserAuditCount", success: { (json) in
            
            if let count = json["data"].int {
                success(count)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //获取组织架构列表
    ///公司总部 organization_type_company
    ///区域 organization_type_area
    ///项目 organization_type_project
    ///分期 organization_type_divide
    
    public func getOrganizeChartList(success: @escaping (([OrganizeChartModel]) -> Void), fail: @escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/user-center/api/usercenter/v1/ucOrg/userList/\(CurrentUser.userID!)", success: { (json) in
            
            var resumes: [OrganizeChartModel] = []
            if let jsonArray = json["data"].array {
                for chartJson in jsonArray {
                    let info = OrganizeChartModel(fromJson: chartJson)
                    resumes.append(info)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }) { (error) in
            fail(error)
        }
    }
    
    ///获取工单处理情况总览
    public func getWorkOrderData(orgId: String, year: String, month: String, success:@escaping ((HomeDealWorkModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/dashboard/dashboard/api/workOrderData", parameters: ["userId": CurrentUser.userID!, "orgId": orgId, "year": year, "month": month], success: { (json) in
            
            let model = HomeDealWorkModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///运营收缴率
    public func getTotalRate(orgCodes: [String], success:@escaping ((TotalRateModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/fee-center/fee-center/api/getTotalRate", parameters: ["orgCodes": orgCodes], success: { (json) in
            
            let model = TotalRateModel(fromJson: json["data"]["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///运营收缴率详情
    public func getTotalRateDetail(orgCodes: [String], type: String, getYearOrMonth: String, success:@escaping ((OperationRateModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        let params: [String: Any] = ["orgCodes": orgCodes,
                                     "incomeType": type,
                                     "date": getYearOrMonth,
                                     "yearOrMonth": "year"]
        BMSServices.shared.postRequest(with: "/fee-center/fee-center/api/getTotalDetailRate", parameters: params, success: { (json) in
            let model = OperationRateModel(fromJson: json["data"]["data"])
            success(model)
            
        }, fail: {error in
            fail(error)
        })
    }
    
    //TODO: -- 目前没通 需要关联大数据 后期加
    ///经营详情洞察
    public func getRunDetailsData(type: String, massifIds: [Any], success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/finance-allocate/financeallocate-api/v1/financeDetailDay/app/allocation", parameters: ["type": type, "massifIds": massifIds], success: { (_) in
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //TODO: -- 目前没通 需要关联大数据 后期加
    ///客户满意度
    public func getFullWishData(time: String, success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/user-center/api/Satisfaction/v1/satisfaction/getAllSatisfactionNoAuth?time=\(time)", success: { (_) in
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - -获取分期--分期列表
    public func postQueryChildrenByUserId(parentOrgID: String? = nil, success:@escaping (([SendAddressListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["userId"] = CurrentUser.userID!
        if let parentOrgID = parentOrgID {
            param["parentOrgId"] = parentOrgID
        } else {
            param["parentOrgId"] = ""
        }
        
        BMSServices.shared.postRequest(with: "/user-center/api/usercenter/v1/ucOrg/queryChildrenByUserId", parameters: param, success: { (json) in
            
            var resumes: [SendAddressListModel] = []
            if let values = json["data"].array {
                for row in values {
                    let resume = SendAddressListModel(fromJson: row)
                    resumes.append(resume)
                }
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 审批模块
    /// 审批类别接口
    public func getByTypeKeyForComBo(success:@escaping (([ApproveTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/portal/sys/dataDict/v1/getByTypeKeyForComBo?typeKey=inner_audit_category", parameters: [String: String](), success: { (json) in
            
            var infoArray: [ApproveTypeModel] = []
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = ApproveTypeModel(fromJson: subJson)
                    infoArray.append(info)
                }
                success(infoArray)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///审批状态接口
    public func getByAuditStatus(success:@escaping (([ApproveStateModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=inner_audit_status", success: { (json) in
            
            var infoArray: [ApproveStateModel] = []
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = ApproveStateModel(fromJson: subJson)
                    infoArray.append(info)
                }
                success(infoArray)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 获取延期信息
    /// - Parameters:
    ///   - auditRequestType: 延期信息类型
    ///   - orderId: 工单编号
    ///   - success:
    ///   - fail:
    public func getDelayByCondition(auditRequestType: AuditRequestType, orderId: String, success:@escaping ((Int, Int) -> Void), fail:@escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/patrol/getDelayByCondition/\(auditRequestType.rawValue)/\(orderId)", success: { (json) in
            
            let infoJson = JSON.init(json["data"])
            var delayCount: Int = 0
            var sumCount: Int = 0
            if let count = infoJson["count"].int {
                delayCount = count
            }
            if let sum = infoJson["sum"].int {
                sumCount = sum
            }
            success(delayCount, sumCount)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待审批列表接口
    public func getWaitApproveList(pageBean: PageBean, divideID: String? = nil, divideName: String? = nil, auditType: AuditType? = nil, auditSubType: AuditSubtype? = nil, state: ApprovalState? = nil, success:@escaping (([ApproveWaitModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var querysList: [Any] = []
        if let divideID = divideID, let divideName = divideName {
            let divideIDDict = queryParameters(property: "divide_id", operation: "EQUAL", value: divideID, relation: "AND")
            let divideNameDict = queryParameters(property: "divide_name", operation: "LIKE", value: divideName, relation: "AND")
            querysList.append(divideIDDict)
            querysList.append(divideNameDict)
        }
        if let auditType = auditType {
            let auditTypeDict = queryParameters(property: "audit_type", operation: "EQUAL", value: auditType.rawValue, relation: "AND")
            querysList.append(auditTypeDict)
        }
        if let auditSubType = auditSubType {
            let auditSubTypeDict = queryParameters(property: "audit_sub_type", operation: "EQUAL", value: auditSubType.rawValue, relation: "AND")
            querysList.append(auditSubTypeDict)
        }
        if let state = state {
            let stateTypeDict = queryParameters(property: "vo.status", operation: "EQUAL", value: state.rawValue, relation: "AND")
            querysList.append(stateTypeDict)
        }

        var param = pageBeanParameter(pageBean)
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/getTodoListApprove", parameters: param, success: { (json) in
            
            var resumes: [ApproveWaitModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ApproveWaitModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///已审批列表接口
    public func getDoneApproveList(pageBean: PageBean, divideID: String? = nil, divideName: String? = nil, auditType: AuditType? = nil, auditSubType: AuditSubtype? = nil, state: ApprovalState? = nil, success:@escaping (([ApproveWaitModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var querysList: [Any] = []
        if let divideID = divideID, let divideName = divideName {
            let divideIDDict = queryParameters(property: "divide_id", operation: "EQUAL", value: divideID, relation: "AND")
            let divideNameDict = queryParameters(property: "divide_name", operation: "LIKE", value: divideName, relation: "AND")
            querysList.append(divideIDDict)
            querysList.append(divideNameDict)
        }
        if let auditType = auditType {
            let auditTypeDict = queryParameters(property: "audit_type", operation: "EQUAL", value: auditType.rawValue, relation: "AND")
            querysList.append(auditTypeDict)
        }
        if let auditSubType = auditSubType {
            let auditSubTypeDict = queryParameters(property: "audit_sub_type", operation: "EQUAL", value: auditSubType.rawValue, relation: "AND")
            querysList.append(auditSubTypeDict)
        }
        if let state = state {
            let stateTypeDict = queryParameters(property: "vo.status", operation: "EQUAL", value: state.rawValue, relation: "AND")
            querysList.append(stateTypeDict)
        }
        var param = pageBeanParameter(pageBean)
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/getDoneCompelteApprove", parameters: param, success: { (json) in
            
            var resumes: [ApproveWaitModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ApproveWaitModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///我发起的审批列表接口
    public func getOwnInitiatedList(pageBean: PageBean, divideID: String? = nil, divideName: String? = nil, auditType: AuditType? = nil, auditSubType: AuditSubtype? = nil, state: ApprovalState? = nil, success:@escaping (([ApproveWaitModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var querysList: [Any] = []
        if let divideID = divideID, let divideName = divideName {
            let divideIDDict = queryParameters(property: "divide_id", operation: "EQUAL", value: divideID, relation: "AND")
            let divideNameDict = queryParameters(property: "divide_name", operation: "LIKE", value: divideName, relation: "AND")
            querysList.append(divideIDDict)
            querysList.append(divideNameDict)
        }
        if let auditType = auditType {
            let auditTypeDict = queryParameters(property: "audit_type", operation: "EQUAL", value: auditType.rawValue, relation: "AND")
            querysList.append(auditTypeDict)
        }
        if let auditSubType = auditSubType {
            let auditSubTypeDict = queryParameters(property: "audit_sub_type", operation: "EQUAL", value: auditSubType.rawValue, relation: "AND")
            querysList.append(auditSubTypeDict)
        }
        if let state = state {
            let stateTypeDict = queryParameters(property: "vo.status", operation: "EQUAL", value: state.rawValue, relation: "AND")
            querysList.append(stateTypeDict)
        }
        var param = pageBeanParameter(pageBean)
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/getIInitiated", parameters: param, success: { (json) in
            
            var resumes: [ApproveWaitModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ApproveWaitModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///审批详情 接口
    public func getApproveDetail(proInstID: String, success:@escaping ((AuditDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/bpm-runtime/runtime/instance/v1/getInstBO?proInstId=\(proInstID)", success: { (json) in
            
            let model = AuditDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取审批信息 接口
    public func getApproveHistoryByAuditID(ID: String, success:@escaping (([ApproveMessageModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/getAuditHisByAuditId?id=\(ID)", success: { (json) in
            
            var resumes: [ApproveMessageModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ApproveMessageModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 审批 同意或者拒绝
    ///强制闭单--巡查工单 审批
    public func approveClosePatrolOrder(ID: String, extensionApplicationID: String, applyTaskID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/closeApprove", parameters: ["id": ID, "extensionApplicationId": extensionApplicationID, "applyTaskId": applyTaskID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///强制闭单--计划工单 审批
    public func approveClosePlanOrder(ID: String, extensionApplicationID: String, applyTaskID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/closeApprove", parameters: ["id": ID, "extensionApplicationId": extensionApplicationID, "applyTaskId": applyTaskID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///强制闭单--派工单 审批
    public func approveCloseDistributeOrder(ID: String, extensionApplicationID: String, applyTaskID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/closeApprove", parameters: ["id": ID, "extensionApplicationId": extensionApplicationID, "applyTaskId": applyTaskID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //创建计划 或者 修改计划
    ///创建工作计划 或者 修改工作计划 的审批
    public func approveWorkPlan(ID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource/api/resource/v1/workPlan/approve", parameters: ["id": ID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///创建巡查计划 或者 修改巡查计划
    public func approveInspectionWorkPlan(ID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource/api/resource/v1/inspectionWorkPlan/approval", parameters: ["id": ID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工单延期--巡查工单 审批
    public func approveDelayPatrolOrder(ID: String, extensionDays: String, extensionApplicationID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/extenApprove", parameters: ["id": ID, "extensionDays": extensionDays, "extensionApplicationId": extensionApplicationID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工单延期--计划工单 审批
    public func approveDelayPlanOrder(ID: String, extensionDays: String, extensionApplicationID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/extenApprove", parameters: ["id": ID, "extensionDays": extensionDays, "extensionApplicationId": extensionApplicationID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工单延期--派工单 审批
    public func approveDelayDistributeOrder(ID: String, extensionDays: String, extensionApplicationID: String, auditHandleModel: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/postPoneApprove", parameters: ["id": ID, "extensionDays": extensionDays, "extensionApplicationId": extensionApplicationID, "innerAuditHandleParam": auditHandleModel.toDictionary()], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///审批其他接口
    public func approveOtherOrder(auditHandleParam: AuditPlanModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/complete", parameters: auditHandleParam.toDictionary(), success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: 点检功能
    ///点检记录列表
    public func getListCheckRecord(page: PageBean = PageBean(), success:@escaping (([CheckRecordResumeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource/api/checkcenter/v1/checkRecord/list", parameters: pageBeanParameter(page), success: { (json) in
            
            var resumes: [CheckRecordResumeModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = CheckRecordResumeModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///添加点检记录
    public func addCheckRecord(checkRecordModel: CheckRecordModel, success:@escaping (() -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource/api/checkcenter/v1/checkRecord/add", parameters: checkRecordModel.toDictionary(), success: { (json) in
            
            if let _ = json["state"].bool {
                success()
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///添加点检  获取数据记录
    public func getCheckRecordContent(userID: String, success:@escaping ((CheckRecordModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource/api/checkcenter/v1/checkRecord/getContent/\(userID)", success: { (json) in
            
            let model = CheckRecordModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获得点检配置
    public func getCheckRecordContent(projectID: String, success:@escaping (([CheckRecordModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource/api/checkcenter/v1/checkRecord/getProject?ids=\(projectID)", success: { (json) in
            
            var resumes: [CheckRecordModel] = []
            if let jsonArray = json["data"].array {
                for subJson in jsonArray {
                    let model = CheckRecordModel(fromJson: subJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取点检记录的详细信息
    public func getCheckRecord(ID: String, success:@escaping ((CheckRecordModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource/api/checkcenter/v1/checkRecord/get/\(ID)", success: { (json) in
            
            success(CheckRecordModel(fromJson: json["data"]) )
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///扫码添加点检 根据资源ID获取点检ID
    public func getByResourceID(resouceID: String, success: @escaping ((CheckRecordScanModel) -> Void), fail: @escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/resource/api/checkcenter/v1/checkProject/getByResourceId/\(resouceID)", success: { (json) in
            success(CheckRecordScanModel(fromJson: json["data"]))
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 上传图片
    ///上传图片
    public func uploadUserPic(uploadData: Data, success: @escaping ((String) -> Void), fail: @escaping (ErrorModel) -> Void) {
        
        UserService.shared.upload(with: "/portal/system/file/v1/upload", uploadData: uploadData, success: { (json) in
            
            if let jsonString = json["data"].string {
                var sureString = jsonString
                sureString = sureString.replacingOccurrences(of: "fileId", with: "id")
                sureString = sureString.replacingOccurrences(of: "fileName", with: "name")
                sureString = sureString.replacingOccurrences(of: "filePath", with: "path")
                
                success(sureString)
            } else {
                fail(ErrorModel.custom("系统内部异常"))
            }
            
        }) { (error) in
            fail(error)
        }
    }
    
    // MARK: - - 获取组织 和 组织下的 人，为转单 和 沟通用
    ///根据分期id 获取所有维度 关联的当前组织
    public func getAllRelationOrganizationListByOrgIds(divideID: String, success:@escaping (([SendAddressListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/user-center/api/usercenter/v1/ucOrg/getAllDimOrgListByOrg", parameters: ["orgIdList": [divideID]], success: { (json) in
            
            var resumes: [SendAddressListModel] = []
            if let jsonArray = json["data"].array {
                for subJson in jsonArray {
                    let model = SendAddressListModel(fromJson: subJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取所有角色 列表
    public func getAllDutiesListByOrgIds(divideID: String, success:@escaping (([DutiesModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/uc/api/role/v1/roles/getAll", parameters: [:], success: { (json) in
            var resumes: [DutiesModel] = []
            if let jsonArray = json["data"].array {
                for subJson in jsonArray {
                    let model = DutiesModel(fromJson: subJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //获取--根据组织 查询对应组织中的用户
    public func getAllUserListByOrgIdsAndDuties(divideID: String, projectID: String? = "", dutiesID: String? = "", success:@escaping (([DutiesUserModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        var params: [String: Any] = [:]
        if dutiesID == nil {
            params = ["params": ["orgIdList": [divideID, projectID]]]
        } else {
            params = ["params": ["orgIdList": [divideID], "roleIdList": [dutiesID]]]
        }
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/userWorkorderCtn/v1/getMappingByRole", parameters: params, success: { (json) in
            
            var resumes: [DutiesUserModel] = []
            if let jsonArray = json["data"].array {
                for subJson in jsonArray {
                    let model = DutiesUserModel(fromJson: subJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 获取审批历史流程    所有工单的 审批历史流程 接口
    public func getApprovalHistoryFlow(proInsID: String, success:@escaping (([ApprovalHistoryFlowModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/bpm-runtime/runtime/instance/v1/instanceFlowOpinions?instId=\(proInsID)", success: { (json) in
            
            var resumes: [ApprovalHistoryFlowModel] = []
            if let jsonArray = json["data"].array {
                for subJson in jsonArray {
                    let model = ApprovalHistoryFlowModel(fromJson: subJson)
                    //如果包含起始节点就跳过。UI不需要展示
                    if model.taskKey?.contains("StartEvent") ?? false {
                        continue
                    }
                    if model.taskKey?.contains("Timeout") ?? false {
                        continue
                    }
                    
                    
                    if model.auditorName == "admin" {
                           model.auditorName = "系统"
                     }
                    if model.opinion == "结束流程" {
                        model.opinion = "关闭工单"
                  }
                  
                    if model.opinion == "跳过第一个任务节点" || ((model.statusVal == "同意" && model.opinion == "同意")) {
                      model.opinion = ""
                  }
                    
                    resumes.append(model)
                }
                let firsrModel = resumes.first
                if (firsrModel?.procDefID?.contains("zyxcgd") ?? false) || (firsrModel?.procDefID?.contains("zyjhgd") ?? false) {
                    firsrModel?.opinion = "工单自动生成"
                }
                
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 判断 当前的工单 是否可以申请闭单 或者 是否可以申请延期
    ///返回true可以发起审批，返回false表示当前正在审批，不可再次申请
    public func judgeOrderIsApprovaling(ID: String, type: AuditSubtype, success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/isClosed", parameters: ["id": ID, "type": type.rawValue], success: { (json) in
            
            //返回true可以发起审批，返回false表示当前正在审批，不可再次申请
            success(json["data"].bool ?? false)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 派工单模块
    ///获取工单类型以及条线分类 获取全部条线 数据
    public func getByTypeKey(success:@escaping (([LineTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=pgdlx", success: { (json) in
            
            var mutaLine: [LineTypeModel] = []
            
            if let infoJson = json["data"].array {
                
                var otherArray: [LineTypeModel] = []
                for subJson in infoJson {
                    let info = LineTypeModel(fromJson: subJson)
                    if info.typeID != "" && info.parentID != "" && info.typeID == info.parentID {
                        mutaLine.append(info)
                    } else {
                        otherArray.append(info)
                    }
                }
                
                for lineModel in mutaLine {
                    for oneModel in otherArray {
                        if lineModel.ID == oneModel.parentID {
                            for twoModel in otherArray {
                                if oneModel.ID == twoModel.parentID {
                                    for threeModel in otherArray {
                                        if twoModel.ID == threeModel.parentID {
                                            twoModel.childrenArray.append(threeModel)
                                        }
                                    }
                                    oneModel.childrenArray.append(twoModel)
                                }
                            }
                            lineModel.childrenArray.append(oneModel)
                        }
                    }
                }
            }
            
            success(mutaLine)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取条线分类（数据分类) 获取条线的 key
    public func getTypesListByKey(success:@escaping (([LineDetailTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/sysType/v1/getTypesListByKey?typeKey=RESOURCE_TYPE", success: { (json) in
            
            var infoArray: [LineDetailTypeModel] = []
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = LineDetailTypeModel(fromJson: subJson)
                    infoArray.append(info)
                }
            }
            success(infoArray)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取超时级别
    public func getOverTimeTypes(success:@escaping (([LineTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=pgdcsjb", success: { (json) in
            var arr: [LineTypeModel] = []
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = LineTypeModel(fromJson: subJson)
                    arr.append(info)
                }
            }
            success(arr)
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///创建工单-派工单- 资源分类
    public func getOrderResourcesDispatch(divideID: String, typeKey: String, success:@escaping (([SendOrderResourceClassificationModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource/resource-api/v1/resource-basic-info/dispatch", parameters: ["massifId": divideID, "resourceTypeCode": typeKey], success: { (json) in
            
            var resumes: [SendOrderResourceClassificationModel] = []
            if let values = json["data"].array {
                for row in values {
                    let resume = SendOrderResourceClassificationModel(fromJson: row)
                    resumes.append(resume)
                }
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取处理人 接口
    ///divideID 分期id
    ///typeKey  条线的typeKey
    public func getByJobCodeAndOrgIdAndDimCodeDeeply(divideID: String, typeKey: String, success:@escaping (([DealPeopleModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/user-center/api/usercenter/v1/ucUser/users/getByRolesAndOrgIdAndDimCode?orgId=\(divideID)&dimCode=\(typeKey)", success: { (json) in
            
            var infoArray: [DealPeopleModel] = []
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = DealPeopleModel(fromJson: subJson)
                    infoArray.append(info)
                }
            }
            success(infoArray)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///创建--派工单工单
    ///instID: 派工单ID
    public func addNewDistributeOrder(sendOrderTrackModel: SendOrderTrackModel, success:@escaping ((_ instID: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        let param = sendOrderTrackModel.toDictionary()
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/new", parameters: param, success: { (json) in
            
            if let id = json["data"]["instId"].string {
                success(id)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--派工单--待跟进列表
    public func getWaitDistributeOrderList(pageBean: PageBean, sendOrderTrackModel: SendOrderTrackModel, success:@escaping (([SendOrderTrackModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendOrderTrackModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        if let searchValue = sendOrderTrackModel.searchValue {
            param["searchValue"] = searchValue
        }
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/wait", parameters: param, success: { (json) in
            
            var resumes: [SendOrderTrackModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendOrderTrackModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--派工单--已跟进列表
    public func getDoneDistributeOrderList(pageBean: PageBean, sendOrderTrackModel: SendOrderTrackModel, success:@escaping (([SendOrderTrackModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendOrderTrackModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        if let searchValue = sendOrderTrackModel.searchValue {
            param["searchValue"] = searchValue
        }
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/done", parameters: param, success: { (json) in
            
            var resumes: [SendOrderTrackModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendOrderTrackModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单--待跟进--详情 处理详情
    public func getDistributeDetail(taskID: String, success:@escaping ((DistributeDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/distribute/detail?taskId=\(taskID)", success: { (json) in
            
            let model = DistributeDetailModel(fromJson: json["data"], byID: false)
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-已跟进--详情（根据实例id、任务节点id) 接单后 去处理掉的 详情
    /// - Parameters:
    ///   - proInsID: 实例id
    ///   - taskNodeID: 任务节点id
    public func getDistributeDoneDetail(proInsID: String, taskNodeID: String, success:@escaping ((DistributeDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["proInsId"] = proInsID
        param["taskNodeId"] = taskNodeID
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/doneDetail", parameters: param, success: { (json) in
            
            let model = DistributeDetailModel(fromJson: json["data"], byID: false)
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工单列表--派工单列表--详情
    public func getDistributeDetailByID(ID: String, success:@escaping ((DistributeDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/distribute/detailById/\(ID)", success: { (json) in
            
            let model = DistributeDetailModel(fromJson: json["data"], byID: true)
            success(model)
            
        }) { (error) in
            fail(error)
        }
    }
    
    /// 派工单-接单
    /// - Parameters:
    ///   - taskID: 工单taskID
    public func acceptDistributeOrder(taskID: String, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["taskId"] = taskID
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/response", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单--转单
    /// - Parameters:
    ///   - ID: 工单id
    ///   - taskID: 工单taskID
    ///   - userID: 转派人id
    ///   - userName: 转派人用户名
    ///   - opinion: 转派意见
    public func transferDistributeOrder(ID: String, taskID: String, userID: String, userName: String, opinion: String, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["id"] = ID
        param["taskId"] = taskID
        param["userId"] = userID
        param["userName"] = userName
        param["opinion"] = opinion
        param["messageType"] = "inner,app_push"
        // /resource-workorder/res-order/distribute/direct
        BMSServices.shared.postRequest(with: "/bpm-runtime/runtime/task/v1/delegate", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-挂单
    public func hangDistributeOrder(ID: String, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["id"] = ID
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/hang", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-延期
    /// - Parameters:
    ///   - ID: 工单id
    ///   - proInsID: 实例id
    ///   - extenDays: 延期天数
    ///   - applyFiles: 延期图片
    ///   - desc: 申请延期原因
    public func delayDistributeOrder(ID: String, proInsID: String, extenDays: String, applyFiles: String, desc: String, success:@escaping (String) -> Void, fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["id"] = ID
        param["instId"] = proInsID
        param["extensionDays"] = extenDays
        param["applicationDescription"] = desc
        param["applyFiles"] = applyFiles
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/exten", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-闭单
    /// - Parameters:
    ///   - ID: 工单id
    ///   - taskID: 工单taskID
    ///   - proInsID: 实例id
    ///   - applyFiles: 闭单图片
    ///   - desc: 闭单原因
    public func closeDistributeOrder(ID: String, taskID: String, proInsID: String, applyFiles: String, desc: String, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        
        param["id"] = ID
        param["applyTaskId"] = taskID
        param["instId"] = proInsID
        param["applyFiles"] = applyFiles
        param["applicationDescription"] = desc
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/close", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-处理
    /// - Parameters:
    ///   - taskID: 工单taskID
    ///   - befPic: 处理前照片 目前好像 不要
    ///   - aftPic: 处理后照片
    ///   - procDate: 处理时间
    ///   - procContent: 处理说明
    public func dealDistributeOrder(ID: String, taskID: String, befPic: String? = nil, aftPic: String, procDate: String, procContent: String, jointHandle: String, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["id"] = ID
        param["taskId"] = taskID
        param["F_AFT_PIC"] = aftPic
        param["F_PROC_DATE"] = procDate
        param["F_PROC_CONTENT"] = procContent
        param["joint_processor"] = jointHandle
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/process", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-验收
    /// - Parameters:
    ///   - taskID: 工单taskID
    ///   - checkResult: 验收结果
    ///   - evaluation: 验收评价
    ///   - checkDate: 验收时间
    ///   - checkContent: 验收意见
    ///   - score: 验收评星
    public func checkDistributeOrder(ID: String, taskID: String, checkResult: String, evaluation: String, checkDate: String, checkContent: String, score: String? = nil, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        
        param["id"] = ID
        param["taskId"] = taskID
        param["fCheckResult"] = checkResult
        param["fEvaluation"] = evaluation
        param["fCheckDate"] = checkDate
        param["fCheckContent"] = checkContent
        if let score = score {
            let scoreDouble: Double = Double(score) ?? 0
            let scoreInt = Int(scoreDouble)
            param["fScore"] = scoreInt
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/check", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-工单退回
    /// - Parameters:
    ///   - taskID: 工单taskID
    ///   - returnReason: 退回原因
    public func returnBackDistributeOrder(taskID: String, returnReason: String, success:@escaping ((_ message: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        
        param["taskId"] = taskID
        param["fReturnReason"] = returnReason
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/back", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///派工单-批复
    ///   - taskID: 工单taskID
    public func replyDistributeOrder(taskID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/distribute/reply/\(taskID)", success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 计划工单模块
    ///获取--计划工单--待跟进列表
    public func getWaitPlanOrderList(pageBean: PageBean, sendPlannedWorkOrderListModel: SendPlannedWorkOrderListModel, success:@escaping (([SendPlannedWorkOrderListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendPlannedWorkOrderListModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/wait-process-list", parameters: param, success: { (json) in
            
            var resumes: [SendPlannedWorkOrderListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendPlannedWorkOrderListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--计划工单--已跟进列表
    public func getDonePlanOrderList(pageBean: PageBean, sendPlannedWorkOrderListModel: SendPlannedWorkOrderListModel, success:@escaping (([SendPlannedWorkOrderListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendPlannedWorkOrderListModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/done", parameters: param, success: { (json) in
            
            var resumes: [SendPlannedWorkOrderListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendPlannedWorkOrderListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单--待跟进详情
    public func getOrderPlanWaitDeatail(taskID: String, success:@escaping ((PlanDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/waitDetail", parameters: ["taskId": taskID], success: { (json) in
            
            let model = PlanDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单--已跟进详情
    public func getOrderPlanDoneDetail(proInsID: String, taskNodeID: String, success:@escaping ((PlanDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/doneDetail", parameters: ["proInsId": proInsID, "taskNodeId": taskNodeID], success: { (json) in
            
            let model = PlanDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //工单列表--计划工单--详情 查询关联资源和工作节点
    public func getOrderListPlanOrderDetail(ID: String, success:@escaping ((PlanDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/plan/listDetail/\(ID)", success: { (json) in
            let model = PlanDetailModel(fromListJson: json["data"])
            
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单-处理
    /// - Parameters:
    ///   - taskID: 任务id
    ///   - actionName: 处理结果 agree 或者
    ///   - dataString: 转化为base64之前的数据格式为(详情数据里对应的data属性的数据格式)
    public func dealPlanOrder(ID: String, taskID: String, planDetailModel: PlanDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var strJson = ""
        let param = planDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)
            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
        }
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/process", parameters: ["id": ID, "taskId": taskID, "actionName": "agree", "data": strJson, "remark": planDetailModel.data?.content ?? ""], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单-闭单
    /// - Parameters:
    ///   - ID: 工单id
    ///   - taskID: 工单taskID
    ///   - proInsID: 实例id
    ///   - messageType: 提示类型
    ///   - endReason: 闭单原因
    ///   - applyFiles: 闭单图片
    public func closePlanOrder(ID: String, taskID: String, proInsID: String, messageType: String, endReason: String, applyFiles: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["ID_"] = ID
        param["taskId"] = taskID
        param["instId"] = proInsID
        param["messageType"] = messageType
        param["endReason"] = endReason
        param["applyFiles"] = applyFiles
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/close", parameters: param, success: { (json) in
            
            if let state = json["data"]["state"].bool {
                if state == true {
                    success(json["msg"].string ?? "")
                } else {
                    fail(ErrorModel.custom(json["msg"].string ?? ""))
                }
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单-申请延期
    /// - Parameters:
    ///   - ID: 计划工单主键
    ///   - taskID: 任务id
    ///   - proInsID: 实例id
    ///   - extensionDays: 延期天数
    ///   - desc: 申请说明
    ///   - applyFiles: 延期图片
    public func delayPlanOrder(ID: String, taskID: String, proInsID: String, extensionDays: String, desc: String, applyFiles: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["ID_"] =  ID
        param["taskId"] = taskID
        param["instId"] = proInsID
        param["extension_days"] = extensionDays
        param["application_description"] = desc
        param["applyFiles"] = applyFiles
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/exten", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单-挂单
    /// - Parameters:
    ///   - ID: 计划工单主键 id
    public func hangPlanOrder(ID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/hang", parameters: ["ID_": ID], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///计划工单-转单
    /// - Parameters:
    ///   - ID: 计划工单主键 id
    ///   - taskID: 工单taskID
    ///   - userID: 转派人id
    ///   - userName: 转派人用户名
    ///   - opinion: 转派意见
    public func transferPlanOrder(ID: String, taskID: String, userID: String, userName: String, opinion: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["ID_"] = ID
        param["taskId"] = taskID
        param["F_PROCESS_ID"] = userID
        param["F_PROCESS_NAME"] = userName
        param["opinion"] = opinion
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/direct", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 计划工单-接单
    /// - Parameters:
    ///   - ID: ID
    ///   - taskID: 任务ID
    ///   - planDetailModel: 工单详情
    ///   - success:
    ///   - fail:
    public func receivePlanOrder(ID: String, taskID: String, planDetailModel: PlanDetailModel, success:@escaping ((String)->Void), fail:@escaping (ErrorModel)->Void) {
        
        var strJson = ""
        let param = planDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/receiveOrder", parameters: ["id":ID, "taskId": taskID, "actionName": "agree", "data": strJson], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            }else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 计划工单-指派
    /// - Parameters:
    ///   - ID: ID
    ///   - taskID: 任务ID
    ///   - planDetailModel: 工单详情
    ///   - success:
    ///   - fail:
    public func designatePlanOrder(ID: String, taskID: String, planDetailModel: PlanDetailModel, success:@escaping ((String)->Void), fail:@escaping (ErrorModel)->Void) {
        
        var strJson = ""
        let param = planDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/zhipai", parameters: ["id":ID, "taskId": taskID, "zhipaiRemark": planDetailModel.data?.sendRemark ?? "", "actionName": "agree", "data": strJson], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            }else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///根据扫码的ID查询资源编码
    public func searchResourceIdFromScanID(scanID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        if scanID.count < 2 {
            fail(ErrorModel.custom("获取数据异常"))
            return
        }
        
        BMSServices.shared.getRequest(with: "/resource/resource-api/v1/resource-basic-info/get/\(scanID.subStringFrom(index: 2))", success: { (json) in
            
            if let _ = json["state"].bool {
                let subJson = JSON.init(json["data"])
                success(subJson["resourceCode"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    ///根据扫码的ID查询资源内容
    public func searchResourceIdContentFromScanID(scanID: String, success:@escaping ((ResourceModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        if scanID.count < 2 {
            fail(ErrorModel.custom("获取数据异常"))
            return
        }

        BMSServices.shared.getRequest(with: "/resource/resource-api/v1/resource-basic-info/get/\(scanID.subStringFrom(index: 2))", success: { (json) in

            if let _ = json["state"].bool {
                let model = ResourceModel(fromJson: json["data"])
                success(model)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 巡查工单模块
    ///巡查工单--获取网格-楼栋-单元  根据分期
    public func getGridBuildingUnitList(divideID: String, isGrid: Bool = false, success:@escaping (([GridBuildUnitModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var pageBean = PageBean()
        pageBean.size = 10000
        var param = pageBeanParameter(pageBean)
        
        var querysList: [Any] = []
        var divideIDDict = [String: Any]()
        divideIDDict["property"] = "divideId"
        divideIDDict["value"] = divideID
        divideIDDict["operation"] = "IN"
        divideIDDict["relation"] = "AND"
        divideIDDict["group"] = "one"
        querysList.append(divideIDDict)
        
        var defaultDict = [String: Any]()
        defaultDict["property"] = "isDeleted"
        defaultDict["value"] = 0
        defaultDict["operation"] = "EQUAL"
        defaultDict["relation"] = "AND"
        defaultDict["group"] = "one"
        querysList.append(defaultDict)
        
        if isGrid {
            var gridDict = [String: Any]()
            gridDict["property"] = "gridType"
            gridDict["value"] = "building_grid"
            gridDict["operation"] = "EQUAL"
            gridDict["relation"] = "AND"
            gridDict["group"] = "one"
            querysList.append(gridDict)
        }
        
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/mdm/api/mdm/v1/newGridBasicInfo/list", parameters: param, success: { (json) in
            
            var resumes: [GridBuildUnitModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = GridBuildUnitModel(fromJson: row)
                if resume.gridType != "public_area_grid", resume.gridType != "service_center_grid" {
                    resumes.append(resume)
                }
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///巡查工单--获取条线分类
    public func getLineAndType(success:@escaping (([PatrolClassifyModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource/api/resource/v1/inspectionWorkGuidance/getLineAndType", success: { (json) in
            
            var infoArray: [PatrolClassifyModel] = []
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = PatrolClassifyModel(fromJson: subJson)
                    infoArray.append(info)
                }
                success(infoArray)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--巡查工单--待跟进列表
    public func getWaitPatrolOrderList(pageBean: PageBean, sendOrderPatrolModel: SendOrderPatrolModel, success:@escaping (([SendOrderPatrolModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendOrderPatrolModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/wait", parameters: param, success: { (json) in
            
            var resumes: [SendOrderPatrolModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendOrderPatrolModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--巡查工单--已跟进列表
    public func getDonePatrolOrderList(pageBean: PageBean, sendOrderPatrolModel: SendOrderPatrolModel, success:@escaping (([SendOrderPatrolModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendOrderPatrolModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let userId = CurrentUser.userID {
            param["userId"] = userId
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/done", parameters: param, success: { (json) in
            
            var resumes: [SendOrderPatrolModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendOrderPatrolModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //TODO: -- 巡查、巡更 工单详情，闭单 和 延期数据 还没有展示 还有巡查巡更的 缓存 没有做
    ///待处理巡查工单--待跟进详情
    public func getPatrolOrderWaitDetail(taskID: String, success:@escaping ((PatrolOrderDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/waitDetail", parameters: ["taskId": taskID], success: { (json) in
            
            let resumes = PatrolOrderDetailModel(fromJson: json["data"])
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待处理巡查工单--已跟进详情
    public func getPatrolOrderDoneDetail(proInsID: String, success:@escaping ((PatrolOrderDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/doneDetail", parameters: ["proInsId": proInsID], success: { (json) in
            
            let resumes = PatrolOrderDetailModel(fromJson: json["data"])
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //工单列表--获取巡查工单列表详情
    public func getOrderListPatrolOrderDetail(ID: String, success:@escaping ((PatrolOrderDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource-workorder/res-order/patrol/v2/listDetail/\(ID)", success: { (json) in
            let resumes = OrderListPatrolOrderDetailModel(fromJson: json["data"])
            let xyz = PatrolOrderDetailZyxcgdModel(fromJson: json["data"]["master"])
            let model = PatrolOrderDetailModel()
            model.delayExtensionApplication = resumes.delayExtensionApplication
            model.extensionApplication = resumes.extensionApplication
            for unit in json["data"]["node"].arrayValue {
                let node = SubInspectionWorkOrderFlowNode(fromJson: unit)
                xyz.subInspectionWorkOrderFlowNode?.append(node)
            }
            model.data = PatrolOrderDetailDataModel()
            model.data?.zyxcgd = xyz
            success(model)
            
            print(resumes)
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待处理工单详情显示--处理用时
    public func getOrderDetailServerTime(success:@escaping ((_ dateStr: String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/serverTime", success: { (json) in
            
            if let serverTime = json["value"].double?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss") {
                success(serverTime)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // TODO: 批复 暂不需要
    ///待处理工单处理--批复
    public func postPendingDisposalOrderReply(taskID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "resource-workorder/res-order/patrol/reply/\(taskID)", success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///巡查工单--处理--上传表单
    /// - Parameters:
    ///   - ID: 工单id
    ///   - taskID: 任务id
    ///   - dataString: base64加密数据
    public func dealPatrolOrder(ID: String, taskID: String, patrolOrderDetailModel: PatrolOrderDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var strJson = ""
        let param = patrolOrderDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            #if DEBUG
            print("base64之前的数据格式:\(JSON(data!))")
            #endif
            
            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/process", parameters: ["id": ID, "taskId": taskID, "actionName": "agree", "data": strJson, "remark": patrolOrderDetailModel.data?.zyxcgd?.processingInstructions ?? ""], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 巡查工单--接单
    /// - Parameters:
    ///   - ID: 工单ID
    ///   - taskID: 任务ID
    ///   - patrolOrderDetailModel: 详情
    ///   - success:
    ///   - fail:
    public func receivePatrolOrder(ID: String, taskID: String, patrolOrderDetailModel: PatrolOrderDetailModel, success:@escaping ((String)->Void), fail:@escaping (ErrorModel) -> Void) {
        
        var strJson = ""
        let param = patrolOrderDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)
            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/receiveOrder", parameters: ["id": ID, "taskId": taskID, "data": strJson, "actionName": "agree"], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            }else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        },fail:{ (error) in
            fail(error)
        })
    }
    
    /// 巡查工单--派单
    /// - Parameters:
    ///   - ID: 工单ID
    ///   - taskID: 任务ID
    ///   - patrolOrderDetailModel: 详情
    ///   - success:
    ///   - fail:
    public func designatePatrolOrder(ID: String, taskID: String, patrolOrderDetailModel: PatrolOrderDetailModel, success:@escaping ((String)->Void), fail:@escaping (ErrorModel) -> Void) {
        
        var strJson = ""
        let param = patrolOrderDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)
            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
            print(strJson)
        }
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/zhipai", parameters: ["id": ID, "taskId": taskID, "zhipaiRemark": patrolOrderDetailModel.data?.zyxcgd?.sendRemark ?? "", "data": strJson, "actionName": "agree"], success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            }else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        },fail:{ (error) in
            fail(error)
        })
    }
    
    ///巡查工单-延期
    /// - Parameters:
    ///   - ID: 工单id
    ///   - proInsID: 实例id
    ///   - extenDays: 延期天数
    ///   - applyFiles: 延期图片
    ///   - desc: 申请延期原因
    public func delayPatrolOrder(ID: String, proInsID: String, extenDays: String, applyFiles: String, desc: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["ID_"] = ID
        param["instId"] = proInsID
        param["extension_days"] = extenDays
        param["applyFiles"] = applyFiles
        param["application_description"] = desc
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/exten", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///巡查工单-闭单
    /// - Parameters:
    ///   - ID: 工单id
    ///   - taskID: 工单taskID
    ///   - proInsID: 实例id
    ///   - applyFiles: 闭单图片
    ///   - desc: 闭单原因
    ///   - applyFiles: 闭单图片
    public func closePatrolOrder(ID: String, taskID: String, proInsID: String, messageType: String, endReason: String, applyFiles: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["ID_"] = ID
        param["taskId"] = taskID
        param["instId"] = proInsID
        param["endReason"] = endReason
        param["messageType"] = messageType
        param["applyFiles"] = applyFiles
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/close", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //巡查工单-转单
    /// - Parameters:
    ///   - ID: 工单id
    ///   - taskID: 工单taskID
    ///   - userID: 转派人id
    ///   - userName: 转派人用户名
    ///   - opinion: 转派意见
    public func transferPatrolOrder(ID: String, taskID: String, userID: String, userName: String, opinion: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["id"] = ID
        param["taskId"] = taskID
        param["userId"] = userID
        param["userName"] = userName
        param["opinion"] = opinion
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/direct", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }


    /// 巡更处理转单并保存缓存数据
    /// - Parameters:
    ///   - ID: 巡更工单ID
    ///   - taskID: 巡更任务ID
    ///   - userID: 转单选择人ID
    ///   - userName: 转单选择人名称
    ///   - opinion: 转单说明
    ///   - patrolOrderDetailModel:详情信息
    ///   - success:
    ///   - fail: 
    public func transferPatrolOrderForNode(ID: String, taskID: String, userID: String, userName: String, opinion: String, patrolOrderDetailModel: PatrolOrderDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var strJson = ""
        let param = patrolOrderDetailModel.toDictionary()
        if let paramData = param["data"] {
            let data = try? JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions.prettyPrinted)

            #if DEBUG
            print("base64之前的数据格式:\(JSON(data!))")
            #endif

            strJson = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0))) ?? ""
        }

        var params:[String: Any] = [:]
        params["opinion"] = opinion
        params["userName"] = userName
        params["userId"] = userID
        params["id"] = ID
        params["taskId"] = taskID
        params["data"] = strJson

        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/processTurn", parameters: params, success: { (json) in

            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///保存巡更节点照片 接口
    /// - Parameters:
    ///   - nodeID: 该节点的id
    ///   - picUrl: 节点上传的图片
    public func saveNightPatrolPointPhoto(nodeID: String, picUrl: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["nodeId"] = nodeID
        param["picUrl"] = picUrl
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/savePointPhoto", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //TODO: -- 联调的时候需要注意传参
    ///巡更节点签到
    /// - Parameters:
    ///   - nodeID: 该节点的id
    ///   - patrolPointID: 巡更点id
    ///   - verifyPatrolPoinID: 二维码扫描出来的 巡更点id
    ///   - verifyDateTime: 二维签到的时间 24小时制的
    public func nightPatrolPointSignIn(nodeID: String, patrolPointID: String, verifyPatrolPoinID: String, verifyDateTime: String, success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        param["nodeId"] = nodeID
        param["patrolPointId"] = patrolPointID
        //扫描二维码里面的 id
        param["verifyPatrolPoinId"] = verifyPatrolPoinID
        //时间戳 24小时制的
        param["verifyDateTime"] = verifyDateTime
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/QRCode/verify", parameters: param, success: { (json) in
            
            if let _ = json["data"].bool {
                success(true)
            } else {
                success(false)
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    
    // MARK: - -工作预览
    ///工作预览--条线接口
    public func workPreviewLineList(success:@escaping (([WorkPreviewLineModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        let param = [String: Any]()
        
        BMSServices.shared.postRequest(with: "/portal/sys/sysType/v1/queryLinkByGroupKey?groupKey=RESOURCE_TYPE", parameters: param, success: { (json) in
            
            var resumes: [WorkPreviewLineModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = WorkPreviewLineModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工作预览---巡查工单
    /// - Parameters:
    ///   - pageBean: 页码
    ///   - valueStr: 几个月的 默认是 1 (1个月的)
    ///   - lineID: 条线的id
    public func patrolWorkPreviewList(pageBean: PageBean, valueStr: String? = nil, lineID: String? = nil, success:@escaping (([WorkPreviewModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        
        //        var sorterList: [Any] = []
        //        var sorterDict = [String: Any]()
        //        sorterDict["property"] = "planExecutionDate"
        //        sorterDict["direction"] = "ASC"
        //        sorterList.append(sorterDict)
        //        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let tempValueStr = valueStr {
            var querysMonthDict = [String: Any]()
            querysMonthDict["property"] = "queryRange"
            querysMonthDict["value"] = tempValueStr
            querysMonthDict["operation"] = "EQUAL"
            querysMonthDict["relation"] = "AND"
            querysMonthDict["group"] = ""
            querysList.append(querysMonthDict)
        }
        if let tempLineID = lineID {
            var querysLineDict = [String: Any]()
            querysLineDict["property"] = "line"
            querysLineDict["value"] = tempLineID
            querysLineDict["operation"] = "EQUAL"
            querysLineDict["relation"] = "AND"
            querysLineDict["group"] = ""
            querysList.append(querysLineDict)
        }
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/resource/api/resource/v1/inspectionWorkOrderPreview/list", parameters: param, success: { (json) in
            
            var resumes: [WorkPreviewModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = WorkPreviewModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工作预览---计划工单
    /// - Parameters:
    ///   - pageBean: 页码
    ///   - valueStr: 几个月的 默认是 1 (1个月的)
    ///   - lineID: 条线的id
    public func planWorkPreviewList(pageBean: PageBean, valueStr: String? = nil, lineID: String? = nil, success:@escaping (([WorkPreviewModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        
        //        var sorterList: [Any] = []
        //        var sorterDict = [String: Any]()
        //        sorterDict["property"] = "planExecutionDate"
        //        sorterDict["direction"] = "ASC"
        //        sorterList.append(sorterDict)
        
        var querysList: [Any] = []
        if let tempValueStr = valueStr {
            var querysMonthDict = [String: Any]()
            querysMonthDict["property"] = "queryRange"
            querysMonthDict["value"] = tempValueStr
            querysMonthDict["operation"] = "EQUAL"
            querysMonthDict["relation"] = "AND"
            querysMonthDict["group"] = ""
            querysList.append(querysMonthDict)
        }
        if let tempLineID = lineID {
            var querysLineDict = [String: Any]()
            querysLineDict["property"] = "line"
            querysLineDict["value"] = tempLineID
            querysLineDict["operation"] = "EQUAL"
            querysLineDict["relation"] = "AND"
            querysLineDict["group"] = ""
            querysList.append(querysLineDict)
        }
        
        //        param["sorter"] = sorterList
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/resource/api/resource/v1/workPlanPreview/list", parameters: param, success: { (json) in
            
            var resumes: [WorkPreviewModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = WorkPreviewModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 客户三类 模块
    ///获取楼栋单元房产 接口
    public func getBuildingUnitHouseList(divideID: String, success:@escaping (([BuildUnitHouseModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/mdm/app/division/getBuildingUnitHouseList?divideId=\(divideID)", success: { (json) in
            
            var resumes: [BuildUnitHouseModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = BuildUnitHouseModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    public func getGridTypeByKey(success:@escaping (([LineTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=ldzd", success: { (json) in
            
            var mutaLine: [LineTypeModel] = []
            
            if let infoJson = json["data"].array {
                for subJson in infoJson {
                    let info = LineTypeModel(fromJson: subJson)
                    if info.typeID != "" && info.parentID != "" {
                        mutaLine.append(info)
                    }
                }
            }
            success(mutaLine)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///根据房产获取联系人
    public func getContactPeopleListByHouseID(houseID: String, success:@escaping (([ContactPeopleModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/mdm/api/mdm/v1/houseClientRef/getListByHouseId?houseId=\(houseID)", success: { (json) in
            
            var resumes: [ContactPeopleModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = ContactPeopleModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 获取--报修方式 或者 投诉方式 或者 问询方式
    /// - Parameters:
    ///   - success: TypeContainerModel
    ///   - fail: ErrorModel
    public func getRepairWayList(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=complaint_method", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    if model.key != "400" && model.key != "proprietor_app" && model.key != "owner_app" && model.key != "mobile_association" {
                        resumes.append(model)
                    }
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--投诉性质
    public func getComplaintNature(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=complain_property", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--投诉类别 或者  问询类别
    public func getComplaintAndEnquiryType(success:@escaping (([CustomerTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/bizData/v1/getBaseList?categoryKey=workorder_type_and_line", success: { (json) in
            
            var resumes: [CustomerTypeModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = CustomerTypeModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--投诉类别 或者  问询类别
    public func getEnquiryTypes(success:@escaping (([CreateEnquiryTypeModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/bizData/v1/getBizDataTree?categoryKey=inquiry_categories", success: { (json) in
            
            var resumes: [CreateEnquiryTypeModel] = []
            if let subJson = json["data"]["children"].array {
                for resumesJson in subJson {
                    let model = CreateEnquiryTypeModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 客户三类--公共接口
    ///客户三类--获取沟通反馈
    public func getConnectFeedback(taskID: String, success:@escaping ((ConnectFeedModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/bpm-runtime/runtime/task/v1/getTaskCommuNow?taskId=\(taskID)", success: { (json) in
            
            let model = ConnectFeedModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取之前申请延期的 次数、天数 数据
    public func getDelayDataByID(id: String, success:@escaping ((CustomerDelayModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param: [String: Any] = Dictionary()
        var querysList: [Any] = []
        let bxDKIDDict = queryParameters(property: "parent_id", operation: "EQUAL", value: id, relation: "AND")
        querysList.append(bxDKIDDict)
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getDelayByCondition", parameters: param, success: { (json) in
            
            let model = CustomerDelayModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户三类--申请延期接口
    public func delayCustomer(applyDelayModel: CustomerApplyDelayModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        let param = applyDelayModel.toDictionary()
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/startSubProcess", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 发起沟通
    /// - Parameters:
    ///   - userID: 沟通id
    ///   - taskID: 任务id
    ///   - opinion: 沟通内容
    ///   - expectTime: 沟通时间--年月日时分秒
    public func initiateConnect(userID: String, taskID: String, opinion: String, expectTime: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param: [String: Any] = Dictionary()
        
        param["taskId"] = taskID
        param["messageType"] = "inner,app_push"
        param["opinion"] = opinion
        param["userId"] = userID
        param["expectTime"] = expectTime
        param["account"] = CurrentUser.username ?? ""
        
        BMSServices.shared.postRequest(with: "/bpm-runtime/runtime/task/v1/communicate", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///沟通反馈
    public func connectFeedback(taskID: String, opinion: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param: [String: Any] = Dictionary()
        
        param["taskId"] = taskID
        param["opinion"] = opinion
        param["account"] = CurrentUser.username ?? ""
        param["notifyType"] = "inner,app_push"
        param["actionName"] = "commu"
        
        BMSServices.shared.postRequest(with: "/bpm-runtime/runtime/instance/v1/doNext", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///任务转办
    /// - Parameters:
    ///   - userID: 转办人id
    ///   - taskID: 任务id
    ///   - opinion: 转办原因
    public func transferToOffice(userID: String, taskID: String, opinion: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param: [String: Any] = Dictionary()
        param["taskId"] = taskID
        param["opinion"] = opinion
        param["userId"] = userID
        param["messageType"] = "inner,app_push"
        
        BMSServices.shared.postRequest(with: "/bpm-runtime/runtime/task/v1/delegate", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 客户报修
    ///获取--报修区域 和 级别
    public func getRepairAreaAndLevel(success:@escaping (([RepairAreaLevelModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/customerRepair/v1/getRepairAreaAndType", success: { (json) in
            
            var resumes: [RepairAreaLevelModel] = []
            if let subJson = json["data"]["children"].array {
                for resumesJson in subJson {
                    let model = RepairAreaLevelModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--报修 性质评估
    public func getRepairNatureAppraise(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=repair_nature_assessment", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--报修 预约上门时间
    public func getRepairAppointmentTime(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=appoint_time_period", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--客户报修 申请无效原因
    public func getRepairReason(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=invalidate_reason_category", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //获取--报修处理支付方式
    public func getRepairPayType(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=pay_type", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //获取--报修工单归属
    public func getRepairWorkAscription(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=Work_Ascription", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///创建--客户报修工单
    /// - Parameters:
    ///   - divideCode: 分期code
    ///   - addRepairModel: 新增的Model
    public func addRepairOrder(divideCode: String, addRepairModel: RepairListModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var dicParam = addRepairModel.toDictionary()
        dicParam["state"] = "added"
        
        var param: [String: Any] = Dictionary()
        param["withModelKey"] = false
        param["bizData"] = dicParam
        param.updateValue(["flowKey": "customer_repair_flow", "vars": ["stagingCode": divideCode]], forKey: "startFlowParamObject")
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerRepair/v1/start", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取 报修--工单状态
    public func getRepairOrderStatus(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=workorder_status_repair", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修---抢单--列表数据
    public func getRepairGrabSheetList(pageBean: PageBean, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        let param = pageBeanParameter(pageBean)
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getGrabListAlia", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修---待跟进--列表数据
    public func getRepairWaitFollowList(pageBean: PageBean, filter: RepairListModel? = nil, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "bx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let bxDKID = filter.divideID {
                let bxDKIDDict = queryParameters(property: "bx_dk_id", operation: "EQUAL", value: bxDKID, relation: "AND")
                querysList.append(bxDKIDDict)
            }
            //报修区域
            if let bxAreaID = filter.areaID {
                let bxAreaIDDict = queryParameters(property: "bx_area_id", operation: "EQUAL", value: bxAreaID, relation: "AND")
                querysList.append(bxAreaIDDict)
            }
            //报修一级
            if let bxCateLv1ID = filter.firstCateLevelID {
                let bxCateLv1IDDict = queryParameters(property: "bx_cate_lv1_id", operation: "EQUAL", value: bxCateLv1ID, relation: "AND")
                querysList.append(bxCateLv1IDDict)
            }
            //报修二级
            if let bxCateLv2ID = filter.secondCateLevelID {
                let bxCateLv2IDDict = queryParameters(property: "bx_cate_lv2_id", operation: "EQUAL", value: bxCateLv2ID, relation: "AND")
                querysList.append(bxCateLv2IDDict)
            }
            //报修三级
            if let bxCateLv3ID = filter.thirdCateLevelID {
                let bxCateLv3IDDict = queryParameters(property: "bx_cate_lv3_id", operation: "EQUAL", value: bxCateLv3ID, relation: "AND")
                querysList.append(bxCateLv3IDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/customer_repair_flow/NORMAL,DELIVERTO", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修---待反馈--列表数据
    public func getRepairWaitFeedbackList(pageBean: PageBean, filter: RepairListModel? = nil, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "bx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let bxDKID = filter.divideID {
                let bxDKIDDict = queryParameters(property: "bx_dk_id", operation: "EQUAL", value: bxDKID, relation: "AND")
                querysList.append(bxDKIDDict)
            }
            //报修区域
            if let bxAreaID = filter.areaID {
                let bxAreaIDDict = queryParameters(property: "bx_area_id", operation: "EQUAL", value: bxAreaID, relation: "AND")
                querysList.append(bxAreaIDDict)
            }
            //报修一级
            if let bxCateLv1ID = filter.firstCateLevelID {
                let bxCateLv1IDDict = queryParameters(property: "bx_cate_lv1_id", operation: "EQUAL", value: bxCateLv1ID, relation: "AND")
                querysList.append(bxCateLv1IDDict)
            }
            //报修二级
            if let bxCateLv2ID = filter.secondCateLevelID {
                let bxCateLv2IDDict = queryParameters(property: "bx_cate_lv2_id", operation: "EQUAL", value: bxCateLv2ID, relation: "AND")
                querysList.append(bxCateLv2IDDict)
            }
            //报修三级
            if let bxCateLv3ID = filter.thirdCateLevelID {
                let bxCateLv3IDDict = queryParameters(property: "bx_cate_lv3_id", operation: "EQUAL", value: bxCateLv3ID, relation: "AND")
                querysList.append(bxCateLv3IDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/customer_repair_flow/COMMU", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修---已跟进--列表数据
    public func getRepairDoneFollowList(pageBean: PageBean, filter: RepairListModel? = nil, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "bx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let bxDKID = filter.divideID {
                let bxDKIDDict = queryParameters(property: "bx_dk_id", operation: "EQUAL", value: bxDKID, relation: "AND")
                querysList.append(bxDKIDDict)
            }
            //报修区域
            if let bxAreaID = filter.areaID {
                let bxAreaIDDict = queryParameters(property: "bx_area_id", operation: "EQUAL", value: bxAreaID, relation: "AND")
                querysList.append(bxAreaIDDict)
            }
            //报修一级
            if let bxCateLv1ID = filter.firstCateLevelID {
                let bxCateLv1IDDict = queryParameters(property: "bx_cate_lv1_id", operation: "EQUAL", value: bxCateLv1ID, relation: "AND")
                querysList.append(bxCateLv1IDDict)
            }
            //报修二级
            if let bxCateLv2ID = filter.secondCateLevelID {
                let bxCateLv2IDDict = queryParameters(property: "bx_cate_lv2_id", operation: "EQUAL", value: bxCateLv2ID, relation: "AND")
                querysList.append(bxCateLv2IDDict)
            }
            //报修三级
            if let bxCateLv3ID = filter.thirdCateLevelID {
                let bxCateLv3IDDict = queryParameters(property: "bx_cate_lv3_id", operation: "EQUAL", value: bxCateLv3ID, relation: "AND")
                querysList.append(bxCateLv3IDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getDoneListAliaForApp/customer_repair_flow", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修---已办结--列表数据
    public func getRepairAlreadyDoneList(pageBean: PageBean, filter: RepairListModel? = nil, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "bx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let bxDKID = filter.divideID {
                let bxDKIDDict = queryParameters(property: "bx_dk_id", operation: "EQUAL", value: bxDKID, relation: "AND")
                querysList.append(bxDKIDDict)
            }
            //报修区域
            if let bxAreaID = filter.areaID {
                let bxAreaIDDict = queryParameters(property: "bx_area_id", operation: "EQUAL", value: bxAreaID, relation: "AND")
                querysList.append(bxAreaIDDict)
            }
            //报修一级
            if let bxCateLv1ID = filter.firstCateLevelID {
                let bxCateLv1IDDict = queryParameters(property: "bx_cate_lv1_id", operation: "EQUAL", value: bxCateLv1ID, relation: "AND")
                querysList.append(bxCateLv1IDDict)
            }
            //报修二级
            if let bxCateLv2ID = filter.secondCateLevelID {
                let bxCateLv2IDDict = queryParameters(property: "bx_cate_lv2_id", operation: "EQUAL", value: bxCateLv2ID, relation: "AND")
                querysList.append(bxCateLv2IDDict)
            }
            //报修三级
            if let bxCateLv3ID = filter.thirdCateLevelID {
                let bxCateLv3IDDict = queryParameters(property: "bx_cate_lv3_id", operation: "EQUAL", value: bxCateLv3ID, relation: "AND")
                querysList.append(bxCateLv3IDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getCompletedAliaForApp/customer_repair_flow", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修---抄送我--列表数据
    public func getRepairCopySendMeList(pageBean: PageBean, filter: RepairListModel? = nil, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "bx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let bxDKID = filter.divideID {
                let bxDKIDDict = queryParameters(property: "bx_dk_id", operation: "EQUAL", value: bxDKID, relation: "AND")
                querysList.append(bxDKIDDict)
            }
            //报修区域
            if let bxAreaID = filter.areaID {
                let bxAreaIDDict = queryParameters(property: "bx_area_id", operation: "EQUAL", value: bxAreaID, relation: "AND")
                querysList.append(bxAreaIDDict)
            }
            //报修一级
            if let bxCateLv1ID = filter.firstCateLevelID {
                let bxCateLv1IDDict = queryParameters(property: "bx_cate_lv1_id", operation: "EQUAL", value: bxCateLv1ID, relation: "AND")
                querysList.append(bxCateLv1IDDict)
            }
            //报修二级
            if let bxCateLv2ID = filter.secondCateLevelID {
                let bxCateLv2IDDict = queryParameters(property: "bx_cate_lv2_id", operation: "EQUAL", value: bxCateLv2ID, relation: "AND")
                querysList.append(bxCateLv2IDDict)
            }
            //报修三级
            if let bxCateLv3ID = filter.thirdCateLevelID {
                let bxCateLv3IDDict = queryParameters(property: "bx_cate_lv3_id", operation: "EQUAL", value: bxCateLv3ID, relation: "AND")
                querysList.append(bxCateLv3IDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getReceiverCopyToForApp/customer_repair_flow", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--客户报修详情
    public func getRepairDetail(procInstID: String, taskID: String? = nil, success:@escaping ((RepairDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var sureTaskID = ""
        if let tempTaskID = taskID {
            sureTaskID = tempTaskID
        }
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/task/v1/getOrderDetail?procInstId=\(procInstID)&taskId=\(sureTaskID)", success: { (json) in
            
            let model = RepairDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--派单
    public func distributeRepairOrder(taskID: String, detailModel: RepairDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        
        /*
         bizDataDict["bx_appoint_time_period"] = detailModel.appointTimePeriod
         bizDataDict["bx_cate_lv1"] = detailModel.firstCateLevel
         bizDataDict["bx_cate_lv1_id"] = detailModel.firstCateLevelID
         bizDataDict["bx_cate_lv2"] = detailModel.secondCateLevel
         bizDataDict["bx_cate_lv2_id"] = detailModel.secondCateLevelID
         bizDataDict["bx_cate_lv3"] = detailModel.thirdCateLevel
         bizDataDict["bx_cate_lv3_id"] = detailModel.thirdCateLevelID
         bizDataDict["house_code"] = detailModel.houseCode
         bizDataDict["bx_user"] = detailModel.user
         bizDataDict["bx_time"] = detailModel.time
         bizDataDict["bx_unit_id"] = detailModel.unitID
         bizDataDict["bx_area_id"] = detailModel.areaID
         bizDataDict["bx_code"] = detailModel.code
         bizDataDict["bx_property_ass"] = detailModel.propertyAss
         bizDataDict["bx_way"] = detailModel.way
         bizDataDict["bx_area"] = detailModel.area
         bizDataDict["bx_property_ass_id"] = detailModel.propertyAssID
         bizDataDict["u_project_id"] = detailModel.projectID
         bizDataDict["bx_house_id"] = detailModel.houseID
         bizDataDict["bx_appoint_time"] = detailModel.appointTime
         bizDataDict["bx_way_id"] = detailModel.wayID
         bizDataDict["bx_mobile"] = detailModel.mobile
         bizDataDict["bx_user_id"] = detailModel.userID
         bizDataDict["bx_house"] = detailModel.house
         bizDataDict["bx_content"] = detailModel.content
         bizDataDict["bx_attachment"] = detailModel.attachment
         bizDataDict["bx_appoint_time_period_id"] = detailModel.appointTimePeriodID
         
         bizDataDict["pd_remark"] = detailModel.pdRemark                         //转派备注
         bizDataDict["assign_grab_user"] = detailModel.assignGrabUser            //派单指派人
         bizDataDict["assign_grab_user_id"] = detailModel.assignGrabUserID       //派单指派人ID
         */
        
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_repair_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerRepair/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--抢单
    public func grabRepairOrder(taskID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/customerRepair/v1/orderGrab?taskId=\(taskID)", success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--响应
    public func responseRepairOrder(taskID: String, detailModel: RepairDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_repair_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerRepair/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--处理
    public func dealRepairOrder(taskID: String, detailModel: RepairDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_repair_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerRepair/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--处理保存
    public func saveRepairOrder(ID: String, detailModel: RepairDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        detailModel.handleUser = nil
        detailModel.handleUserID = nil
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_repair_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        param["ID_"] = ID
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/saveDraft/v1/saveHandle", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--评价
    public func commentRepairOrder(taskID: String, detailModel: RepairDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_repair_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        param["withModelKey"] = false
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerRepair/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户报修--申请强制闭单
    public func closeRepairOrder(taskID: String, detailModel: RepairDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_repair_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerRepair/v1/applyFclose", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 客户投诉
    ///获取最近历史投诉工单列表数据
    public func getComplaintHistoryList(pageBean: PageBean, tsMobile: String, success:@escaping (([ComplaintHistoryModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "F_ts_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        var mobileDict: [String: Any] = Dictionary()
        mobileDict["property"] = "F_ts_mobile"
        mobileDict["operation"] = "EQUAL"
        mobileDict["value"] = tsMobile
        querysList.append(mobileDict)
        param["querys"] = querysList
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getPersonWorkByKey/customer_complain_flow", parameters: param, success: { (json) in
            
            var resumes: [ComplaintHistoryModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintHistoryModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///追加投诉信息 接口
    /// - Parameters:
    ///   - id: 历史投诉工单的 id
    ///   - content: 追加投诉信息
    ///   - createTimeStr: 工单的创建时间
    public func chaseAddComplaintContent(id: String, content: String, createTimeStr: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param: [String: Any] = Dictionary()
        param["boId"] = id
        param["editor"] = CurrentUser.username ?? ""
        param["editorId"] = CurrentUser.userID ?? ""
        param["createTime"] = createTimeStr
        param["desc"] = content
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/appendWorkOrder", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///创建--客户投诉工单
    /// - Parameters:
    ///   - divideCode: 分期的code
    ///   - addComplaintModel: 投诉Model
    public func addComplaintOrder(divideCode: String, addComplaintModel: ComplaintListModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var dicParam = addComplaintModel.toDictionary()
        dicParam["F_state"] = "added"
        
        var param: [String: Any] = Dictionary()
        param["withModelKey"] = false
        param["bizData"] = dicParam
        param.updateValue(["flowKey": "customer_complain_flow", "vars": ["stagingCode": divideCode]], forKey: "startFlowParamObject")
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/taskRun/v1/start", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取 投诉--工单状态
    public func getComplaintOrderStatus(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=workorder_status_complain", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户投诉--待跟进--列表数据
    public func getComplaintWaitFollowList(pageBean: PageBean, filter: ComplaintListModel? = nil, success:@escaping (([ComplaintListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "F_ts_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let tsDKID = filter.divideID {
                let tsDKIDDict = queryParameters(property: "F_ts_dk_id", operation: "EQUAL", value: tsDKID, relation: "AND")
                querysList.append(tsDKIDDict)
            }
            //性质
            if let tsPropertyID = filter.propertyID {
                let tsPropertyIDDict = queryParameters(property: "F_ts_property_id", operation: "EQUAL", value: tsPropertyID, relation: "AND")
                querysList.append(tsPropertyIDDict)
            }
            //类别
            if let tsCateID = filter.cateID {
                let tsCateIDDict = queryParameters(property: "F_ts_cate_id", operation: "EQUAL", value: tsCateID, relation: "AND")
                querysList.append(tsCateIDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/customer_complain_flow/NORMAL,DELIVERTO", parameters: param, success: { (json) in
            
            var resumes: [ComplaintListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户投诉--待反馈--列表数据
    public func getComplaintWaitFeedbackList(pageBean: PageBean, filter: ComplaintListModel? = nil, success:@escaping (([ComplaintListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "F_ts_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let tsDKID = filter.divideID {
                let tsDKIDDict = queryParameters(property: "F_ts_dk_id", operation: "EQUAL", value: tsDKID, relation: "AND")
                querysList.append(tsDKIDDict)
            }
            //性质
            if let tsPropertyID = filter.propertyID {
                let tsPropertyIDDict = queryParameters(property: "F_ts_property_id", operation: "EQUAL", value: tsPropertyID, relation: "AND")
                querysList.append(tsPropertyIDDict)
            }
            //类别
            if let tsCateID = filter.cateID {
                let tsCateIDDict = queryParameters(property: "F_ts_cate_id", operation: "EQUAL", value: tsCateID, relation: "AND")
                querysList.append(tsCateIDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/customer_complain_flow/COMMU", parameters: param, success: { (json) in
            
            var resumes: [ComplaintListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户投诉--已跟进--列表数据
    public func getComplaintDoneFollowList(pageBean: PageBean, filter: ComplaintListModel? = nil, success:@escaping (([ComplaintListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "F_ts_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let tsDKID = filter.divideID {
                let tsDKIDDict = queryParameters(property: "F_ts_dk_id", operation: "EQUAL", value: tsDKID, relation: "AND")
                querysList.append(tsDKIDDict)
            }
            //性质
            if let tsPropertyID = filter.propertyID {
                let tsPropertyIDDict = queryParameters(property: "F_ts_property_id", operation: "EQUAL", value: tsPropertyID, relation: "AND")
                querysList.append(tsPropertyIDDict)
            }
            //类别
            if let tsCateID = filter.cateID {
                let tsCateIDDict = queryParameters(property: "F_ts_cate_id", operation: "EQUAL", value: tsCateID, relation: "AND")
                querysList.append(tsCateIDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getDoneListAliaForApp/customer_complain_flow", parameters: param, success: { (json) in
            
            var resumes: [ComplaintListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户投诉---已办结--列表数据
    public func getComplaintAlreadyDoneList(pageBean: PageBean, filter: ComplaintListModel? = nil, success:@escaping (([ComplaintListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "F_ts_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let tsDKID = filter.divideID {
                let tsDKIDDict = queryParameters(property: "F_ts_dk_id", operation: "EQUAL", value: tsDKID, relation: "AND")
                querysList.append(tsDKIDDict)
            }
            //性质
            if let tsPropertyID = filter.propertyID {
                let tsPropertyIDDict = queryParameters(property: "F_ts_property_id", operation: "EQUAL", value: tsPropertyID, relation: "AND")
                querysList.append(tsPropertyIDDict)
            }
            //类别
            if let tsCateID = filter.cateID {
                let tsCateIDDict = queryParameters(property: "F_ts_cate_id", operation: "EQUAL", value: tsCateID, relation: "AND")
                querysList.append(tsCateIDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getCompletedAliaForApp/customer_complain_flow", parameters: param, success: { (json) in
            
            var resumes: [ComplaintListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户投诉---抄送我--列表数据
    public func getComplaintCopySendMeList(pageBean: PageBean, filter: ComplaintListModel? = nil, success:@escaping (([ComplaintListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "F_ts_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let tsDKID = filter.divideID {
                let tsDKIDDict = queryParameters(property: "F_ts_dk_id", operation: "EQUAL", value: tsDKID, relation: "AND")
                querysList.append(tsDKIDDict)
            }
            //性质
            if let tsPropertyID = filter.propertyID {
                let tsPropertyIDDict = queryParameters(property: "F_ts_property_id", operation: "EQUAL", value: tsPropertyID, relation: "AND")
                querysList.append(tsPropertyIDDict)
            }
            //类别
            if let tsCateID = filter.cateID {
                let tsCateIDDict = queryParameters(property: "F_ts_cate_id", operation: "EQUAL", value: tsCateID, relation: "AND")
                querysList.append(tsCateIDDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getReceiverCopyToForApp/customer_complain_flow", parameters: param, success: { (json) in
            
            var resumes: [ComplaintListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--投诉详情
    public func getComplaintDetail(procInstID: String, taskID: String? = nil, success:@escaping ((ComplaintDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var sureTaskID = ""
        if let tempTaskID = taskID {
            sureTaskID = tempTaskID
        }
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/task/v1/getOrderDetail?procInstId=\(procInstID)&taskId=\(sureTaskID)", success: { (json) in
            
            let model = ComplaintDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--处理记录列表接口
    public func getHandleRecordList(pageBean: PageBean, id: String, success:@escaping (([HandleRecordModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "handle_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/saveDraft/v1/getHandleList?bizId=\(id)", parameters: param, success: { (json) in
            
            var resumes: [HandleRecordModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = HandleRecordModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///投诉--派单
    public func dispatchComplaintOrder(taskID: String, detailModel: ComplaintDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_complain_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        doNextParam["F_pd_assignor"] = detailModel.sendPersonName
        doNextParam["F_pd_assignor_id"] = detailModel.sendPersonID
        doNextParam["F_pd_remark"] = detailModel.sendRemark
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/taskRun/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///投诉--响应
    public func responseComplaintOrder(taskID: String, opinion: String, detailModel: ComplaintDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_complain_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["opinion"] = opinion
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/taskRun/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///投诉--处理
    public func dealComplaintOrder(taskID: String, handleResult: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        bizDataDict["F_handle_result"] = handleResult
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/taskRun/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///投诉--处理保存接口
    public func dealSaveComplaintOrder(detailModel: ComplaintDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_complain_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        param["ID_"] = detailModel.id
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/saveDraft/v1/saveHandle", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///投诉--评价
    public func commentComplaintOrder(taskID: String, detailModel: ComplaintDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_complain_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/taskRun/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///投诉--申请强制闭单
    public func closeComplaintOrder(taskID: String, detailModel: ComplaintDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_complain_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/taskRun/v1/applyFclose", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                success(json["msg"].string ?? "")
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 客户问询
    ///创建--客户问询工单
    /// - Parameters:
    ///   - divideCode: 分期code
    ///   - addEnquiryModel: 新增的Model
    public func addEnquiryOrder(divideCode: String, addEnquiryModel: EnquiryListModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var dicParam = addEnquiryModel.toDictionary()
        dicParam["state"] = "added"
        
        var param: [String: Any] = Dictionary()
        param["withModelKey"] = false
        param["bizData"] = dicParam
        param.updateValue(["flowKey": "customer_enquiry_flow", "vars": ["stagingCode": divideCode]], forKey: "startFlowParamObject")
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerEnquiry/v1/start", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 获取 问询--工单状态
    /// - Parameters:
    ///   - success: TypeContainerModel
    ///   - fail: ErrorModel
    public func getEnquiryOrderStatus(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=workorder_status_enquiry", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--待跟进--列表数据
    /// - Parameters:
    ///   - pageBean: 分页
    ///   - filter: EnquiryListModel 筛选条件，筛选参数为divideID(分期ID) And cateID(类别)
    ///   - success: EnquiryListModel
    ///   - fail: ErrorModel
    public func getEnquiryWaitFollowList(pageBean: PageBean, filter: EnquiryListModel? = nil, success:@escaping (([EnquiryListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "wx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let wxDKID = filter.divideID {
                let wxDKIDDict = queryParameters(property: "wx_dk_id", operation: "EQUAL", value: wxDKID, relation: "AND")
                querysList.append(wxDKIDDict)
            }
            //问询大类
            if let cateID = filter.cateID {
                let cateIDDic = queryParameters(property: "wx_cate_id", operation: "EQUAL", value: cateID, relation: "AND")
                querysList.append(cateIDDic)
            }
            //问询小类
            if let subCateID = filter.subCateID {
                let subCateIDDic = queryParameters(property: "wx_sub_cate_id", operation: "EQUAL", value: subCateID, relation: "AND")
                querysList.append(subCateIDDic)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/customer_enquiry_flow/NORMAL,DELIVERTO", parameters: param, success: { (json) in
            
            var resumes: [EnquiryListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = EnquiryListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--待反馈--列表数据
    /// - Parameters:
    ///   - pageBean: 分页
    ///   - filter: EnquiryListModel EnquiryListModel 筛选条件,可以为nil，涉及到的参数divideID(分期ID) And cateID(类别)
    ///   - success: EnquiryListModel
    ///   - fail: ErrorModel
    public func getEnquiryWaitFeedbackList(pageBean: PageBean, filter: EnquiryListModel? = nil, success:@escaping (([EnquiryListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "wx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let wxDKID = filter.divideID {
                let wxDKIDDict = queryParameters(property: "wx_dk_id", operation: "EQUAL", value: wxDKID, relation: "AND")
                querysList.append(wxDKIDDict)
            }
            //问询大类
            if let cateID = filter.cateID {
                let cateIDDic = queryParameters(property: "wx_cate_id", operation: "EQUAL", value: cateID, relation: "AND")
                querysList.append(cateIDDic)
            }
            //问询小类
            if let subCateID = filter.subCateID {
                let subCateIDDic = queryParameters(property: "wx_sub_cate_id", operation: "EQUAL", value: subCateID, relation: "AND")
                querysList.append(subCateIDDic)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/customer_enquiry_flow/COMMU", parameters: param, success: { (json) in
            
            var resumes: [EnquiryListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = EnquiryListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--已跟进--列表数据
    /// - Parameters:
    ///   - pageBean: 分页
    ///   - filter: EnquiryListModel EnquiryListModel 筛选条件,可以为nil，涉及到的参数divideID(分期ID) And cateID(类别)
    ///   - success: EnquiryListModel
    ///   - fail: ErrorModel
    public func getEnquiryDoneFollowList(pageBean: PageBean, filter: EnquiryListModel? = nil, success:@escaping (([EnquiryListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "wx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let wxDKID = filter.divideID {
                let wxDKIDDict = queryParameters(property: "wx_dk_id", operation: "EQUAL", value: wxDKID, relation: "AND")
                querysList.append(wxDKIDDict)
            }
            //问询大类
            if let cateID = filter.cateID {
                let cateIDDic = queryParameters(property: "wx_cate_id", operation: "EQUAL", value: cateID, relation: "AND")
                querysList.append(cateIDDic)
            }
            //问询小类
            if let subCateID = filter.subCateID {
                let subCateIDDic = queryParameters(property: "wx_sub_cate_id", operation: "EQUAL", value: subCateID, relation: "AND")
                querysList.append(subCateIDDic)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getDoneListAliaForApp/customer_enquiry_flow", parameters: param, success: { (json) in
            
            var resumes: [EnquiryListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = EnquiryListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户问询--已办结--列表数据
    /// - Parameters:
    ///   - pageBean: 分页
    ///   - filter: EnquiryListModel EnquiryListModel 筛选条件,可以为nil，涉及到的参数divideID(分期ID) And cateID(类别)
    ///   - success: EnquiryListModel
    ///   - fail: ErrorModel
    public func getEnquiryAlreadyDoneList(pageBean: PageBean, filter: EnquiryListModel? = nil, success:@escaping (([EnquiryListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "wx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let wxDKID = filter.divideID {
                let wxDKIDDict = queryParameters(property: "wx_dk_id", operation: "EQUAL", value: wxDKID, relation: "AND")
                querysList.append(wxDKIDDict)
            }
            //问询大类
            if let cateID = filter.cateID {
                let cateIDDic = queryParameters(property: "wx_cate_id", operation: "EQUAL", value: cateID, relation: "AND")
                querysList.append(cateIDDic)
            }
            //问询小类
            if let subCateID = filter.subCateID {
                let subCateIDDic = queryParameters(property: "wx_sub_cate_id", operation: "EQUAL", value: subCateID, relation: "AND")
                querysList.append(subCateIDDic)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getCompletedAliaForApp/customer_enquiry_flow", parameters: param, success: { (json) in
            
            var resumes: [EnquiryListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = EnquiryListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///客户问询--抄送我--列表数据
    /// - Parameters:
    ///   - pageBean: 分页
    ///   - filter: EnquiryListModel EnquiryListModel 筛选条件,可以为nil，涉及到的参数divideID(分期ID) And cateID(类别)
    ///   - success: EnquiryListModel
    ///   - fail: ErrorModel
    public func getEnquiryCopySendMeList(pageBean: PageBean, filter: EnquiryListModel? = nil, success:@escaping (([EnquiryListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var sorterList: [Any] = []
        let sorterDict: [String: String] = ["direction": "DESC", "property": "wx_time"]
        sorterList.append(sorterDict)
        param["sorter"] = sorterList
        
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let wxDKID = filter.divideID {
                let wxDKIDDict = queryParameters(property: "wx_dk_id", operation: "EQUAL", value: wxDKID, relation: "AND")
                querysList.append(wxDKIDDict)
            }
            //问询大类
            if let cateID = filter.cateID {
                let cateIDDic = queryParameters(property: "wx_cate_id", operation: "EQUAL", value: cateID, relation: "AND")
                querysList.append(cateIDDic)
            }
            //问询小类
            if let subCateID = filter.subCateID {
                let subCateIDDic = queryParameters(property: "wx_sub_cate_id", operation: "EQUAL", value: subCateID, relation: "AND")
                querysList.append(subCateIDDic)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getReceiverCopyToForApp/customer_enquiry_flow", parameters: param, success: { (json) in
            
            var resumes: [EnquiryListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = EnquiryListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 获取--客户问询详情
    /// - Parameters:
    ///   - procInstID: 实例ID
    ///   - taskID: 任务ID
    ///   - success: EnquiryDetailModel
    ///   - fail: ErrorModel
    public func getEnquiryDetail(procInstID: String, taskID: String? = nil, success:@escaping ((EnquiryDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var sureTaskID = ""
        if let tempTaskID = taskID {
            sureTaskID = tempTaskID
        }
        
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/task/v1/getOrderDetail?procInstId=\(procInstID)&taskId=\(sureTaskID)", success: { (json) in
            
            let model = EnquiryDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--派单
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - detailModel: EnquiryDetailModel
    ///   - success: String（成功提示）
    ///   - fail: ErrorModel
    public func dispatchEnquiryOrder(taskID: String, detailModel: EnquiryDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_enquiry_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        doNextParam["pd_assignor"] = detailModel.sendPersonName
        doNextParam["pd_assignor_id"] = detailModel.sendPersonID
        doNextParam["pd_remark"] = detailModel.sendRemark
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerEnquiry/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--响应
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - detailModel: EnquiryDetailModel
    ///   - success: String（成功提示）
    ///   - fail: ErrorModel
    public func responseEnquiryOrder(taskID: String, detailModel: EnquiryDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_enquiry_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        doNextParam["response_user"] = detailModel.responseUser
        doNextParam["response_time"] = detailModel.responseTime
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerEnquiry/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 客户问询--处理
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - detailModel: EnquiryDetailModel
    ///   - success: String（成功提示)
    ///   - fail: ErrorModel
    public func dealEnquiryOrder(taskID: String, detailModel: EnquiryDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_enquiry_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerEnquiry/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--处理保存接口
    /// - Parameters:
    ///   - detailModel: EnquiryDetailModel
    ///   - success: String（成功提示)
    ///   - fail: ErrorModel
    public func dealSaveEnquiryOrder(detailModel: EnquiryDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_enquiry_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        param["ID_"] = detailModel.id
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/saveDraft/v1/saveHandle", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 客户问询--评价
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - detailModel: EnquiryDetailModel
    ///   - success: String（成功提示)
    ///   - fail: ErrorModel
    public func commentEnquiryOrder(taskID: String, detailModel: EnquiryDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_enquiry_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerEnquiry/v1/complete", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    
    /// 客户问询--申请强制闭单
    /// - Parameters:
    ///   - taskID: 任务ID
    ///   - detailModel: EnquiryDetailModel
    ///   - success: String（成功提示)
    ///   - fail: ErrorModel
    public func closeEnquiryOrder(taskID: String, detailModel: EnquiryDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["customer_enquiry_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/customerEnquiry/v1/applyFclose", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 工单列表模块
    /// 工单列表--客户投诉列表
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - mineBool: 不需要传
    ///   - filter: ComplaintListModel(筛选条件 (分期id)divideID (性质)propertyID (类别)cateID (状态)state )
    ///   - success: ComplaintListModel
    ///   - fail: ErrorModel
    public func getOrderListComplainOrderList(pageBean: PageBean, mineBool: Bool? = nil, filter: ComplaintListModel? = nil, success:@escaping (([ComplaintListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var querysList: [Any] = []
        
        if mineBool != nil {
            let mineDict = queryParameters(property: "F_ts_recorder_id", operation: "EQUAL", value: CurrentUser.userID ?? "", relation: "AND")
            querysList.append(mineDict)
        }
        
        if let filter = filter {
            //分期 id
            if let tsDKID = filter.divideID {
                let tsDKIDDict = queryParameters(property: "F_ts_dk_id", operation: "EQUAL", value: tsDKID, relation: "AND")
                querysList.append(tsDKIDDict)
            }
            //性质
            if let tsPropertyID = filter.propertyID {
                let tsPropertyIDDict = queryParameters(property: "F_ts_property_id", operation: "EQUAL", value: tsPropertyID, relation: "AND")
                querysList.append(tsPropertyIDDict)
            }
            //类别
            if let tsCateID = filter.cateID {
                let tsCateIDDict = queryParameters(property: "F_ts_cate_id", operation: "EQUAL", value: tsCateID, relation: "AND")
                querysList.append(tsCateIDDict)
            }
            //状态
            if let state = filter.state {
                let stateDict = queryParameters(property: "F_state", operation: "EQUAL", value: state.rawValue, relation: "AND")
                querysList.append(stateDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getWorkListBydefKeyForApp?defKey=customer_complain_flow", parameters: param, success: { (json) in
            
            var resumes: [ComplaintListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = ComplaintListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 工单列表--客户报修列表
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - mineBool: 不需要传
    ///   - filter: RepairListModel(筛选条件 (分期id)divideID (报修区域)areaID (报修一级)firstCateLevelID (报修二级)secondCateLevelID (报修三级)thirdCateLevelID (状态)state )
    ///   - success: RepairListModel
    ///   - fail: ErrorModel
    public func getOrderListRepairOrderList(pageBean: PageBean, mineBool: Bool = false, filter: RepairListModel? = nil, success:@escaping (([RepairListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var querysList: [Any] = []
        
        if mineBool {
            let mineDict = queryParameters(property: "bx_recorder_id", operation: "EQUAL", value: CurrentUser.userID ?? "", relation: "AND")
            querysList.append(mineDict)
        }
        
        if let filter = filter {
            //分期 id
            if let bxDKID = filter.divideID {
                let bxDKIDDict = queryParameters(property: "bx_dk_id", operation: "EQUAL", value: bxDKID, relation: "AND")
                querysList.append(bxDKIDDict)
            }
            //报修区域
            if let bxAreaID = filter.areaID {
                let bxAreaIDDict = queryParameters(property: "bx_area_id", operation: "EQUAL", value: bxAreaID, relation: "AND")
                querysList.append(bxAreaIDDict)
            }
            //报修一级
            if let bxCateLv1ID = filter.firstCateLevelID {
                let bxCateLv1IDDict = queryParameters(property: "bx_cate_lv1_id", operation: "EQUAL", value: bxCateLv1ID, relation: "AND")
                querysList.append(bxCateLv1IDDict)
            }
            //报修二级
            if let bxCateLv2ID = filter.secondCateLevelID {
                let bxCateLv2IDDict = queryParameters(property: "bx_cate_lv2_id", operation: "EQUAL", value: bxCateLv2ID, relation: "AND")
                querysList.append(bxCateLv2IDDict)
            }
            //报修三级
            if let bxCateLv3ID = filter.thirdCateLevelID {
                let bxCateLv3IDDict = queryParameters(property: "bx_cate_lv3_id", operation: "EQUAL", value: bxCateLv3ID, relation: "AND")
                querysList.append(bxCateLv3IDDict)
            }
            //状态
            if let state = filter.state {
                let stateDict = queryParameters(property: "state", operation: "EQUAL", value: state.rawValue, relation: "AND")
                querysList.append(stateDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getWorkListBydefKeyForApp?defKey=customer_repair_flow", parameters: param, success: { (json) in
            
            var resumes: [RepairListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = RepairListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 工单列表--客户问询列表
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - mineBool: 不需要传
    ///   - filter: EnquiryListModel
    ///   - success: EnquiryListModel
    ///   - fail: ErrorModel
    public func getOrderListEnquiryOrderList(pageBean: PageBean, mineBool: Bool? = nil, filter: EnquiryListModel? = nil, success:@escaping (([EnquiryListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var querysList: [Any] = []
        
        if mineBool != nil {
            let mineDict = queryParameters(property: "wx_recorder_id", operation: "EQUAL", value: CurrentUser.userID ?? "", relation: "AND")
            querysList.append(mineDict)
        }
        
        if let filter = filter {
            //分期 id
            if let wxDKID = filter.divideID {
                let wxDKIDDict = queryParameters(property: "wx_dk_id", operation: "EQUAL", value: wxDKID, relation: "AND")
                querysList.append(wxDKIDDict)
            }
            //问询大类
            if let cateID = filter.cateID {
                let cateIDDic = queryParameters(property: "wx_cate_id", operation: "EQUAL", value: cateID, relation: "AND")
                querysList.append(cateIDDic)
            }
            //问询小类
            if let subCateID = filter.subCateID {
                let subCateIDDic = queryParameters(property: "wx_sub_cate_id", operation: "EQUAL", value: subCateID, relation: "AND")
                querysList.append(subCateIDDic)
            }
            //状态
            if let state = filter.state {
                let stateDict = queryParameters(property: "state", operation: "EQUAL", value: state.rawValue, relation: "AND")
                querysList.append(stateDict)
            }
        }
        param["querys"] = querysList
        //搜索内容
        if let searchValue = filter?.searchValue {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getWorkListBydefKeyForApp?defKey=customer_enquiry_flow", parameters: param, success: { (json) in
            
            var resumes: [EnquiryListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = EnquiryListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 工单列表--派工单列表--分期和条线组合查询
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - sendOrderTrackModel: SendOrderTrackModel
    ///   - success: SendOrderTrackModel
    ///   - fail: ErrorModel
    public func getOrderListDistributeOrderListByResource(pageBean: PageBean, sendOrderTrackModel: SendOrderTrackModel, success:@escaping (([SendOrderTrackModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendOrderTrackModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        if let searchValue = sendOrderTrackModel.searchValue {
            param["searchValue"] = searchValue
        }
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/distribute/v2/listByResource", parameters: param, success: { (json) in
            
            var infoArray: [SendOrderTrackModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let info = SendOrderTrackModel(fromJson: row)
                infoArray.append(info)
            }
            success(infoArray)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    /// 工单列表--计划工单列表--分期和条线组合查询
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - sendPlannedWorkOrderListModel: SendPlannedWorkOrderListModel
    ///   - success: SendPlannedWorkOrderListModel
    ///   - fail: ErrorModel
    public func getOrderListPlanOrderList(pageBean: PageBean, sendPlannedWorkOrderListModel: SendPlannedWorkOrderListModel, success:@escaping (([SendPlannedWorkOrderListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendPlannedWorkOrderListModel.toDictionary()
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/plan/v2/queryList", parameters: param, success: { (json) in
            
            var resumes: [SendPlannedWorkOrderListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendPlannedWorkOrderListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //TODO: -- 字段传值需要 检查
    
    /// 工单列表--巡查工单列表-分期和条线组合查询
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - sendOrderPatrolModel: sendOrderPatrolModel
    ///   - success: SendOrderPatrolModel
    ///   - fail: ErrorModel
    public func getOrderListPatrolOrderList(pageBean: PageBean, sendOrderPatrolModel: SendOrderPatrolModel, success:@escaping (([SendOrderPatrolModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = sendOrderPatrolModel.toDictionary()
        
        let pageParam = pageParameter(pageBean)
        for (key, value) in pageParam.reversed() {
            param[key] = value
        }
        
        BMSServices.shared.postRequest(with: "/resource-workorder/res-order/patrol/v2/queryList", parameters: param, success: { (json) in
            
            var resumes: [SendOrderPatrolModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = SendOrderPatrolModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: - - 不合格单模块
    ///获取--不合格单状态
    public func getUnqualifiedOrderStatus(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=unqualified_order_status", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取不合格工单编号
    /// - Parameters:
    ///   - success: String 工单编号  创建的时候 选择对应的条线时 需要拼接工单编号
    public func getUnqualifiedOrderCode(success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/identity/v1/getNextIdByAlias?alias=bhggdbh", success: { (json) in
            
            //            "data": "-BHG-2020019-0020",
            
            if let _ = json["state"].bool {
                success(json["data"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--不合格工单--严重程度
    public func getUnqualifiedOrderSeverity(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=severity", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///获取--不合格单条线
    public func getUnqualifiedOrderLine(success:@escaping (([TypeContainerModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/portal/sys/dataDict/v1/getByTypeKey?typeKey=unqualified_order_line", success: { (json) in
            
            var resumes: [TypeContainerModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = TypeContainerModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///通过组织角色查询用户--被检查人接口
    public func getUnqualifiedInspectUserList(divideID: String, success:@escaping (([DealPeopleModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/uc/api/user/v1/users/getUserByConditionRoles?orgId=\(divideID)", success: { (json) in
            
            var resumes: [DealPeopleModel] = []
            if let subJson = json["data"].array {
                for resumesJson in subJson {
                    let model = DealPeopleModel(fromJson: resumesJson)
                    resumes.append(model)
                }
                success(resumes)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///创建--不合格单
    /// - Parameters:
    ///   - addRepairModel: 新增的Model
    ///   -String 返回--流程实例Id
    public func addUnqualifiedOrder(addUnqualifiedModel: UnqualifiedOrderListModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        let dicParam = addUnqualifiedModel.toDictionary()
        var param: [String: Any] = Dictionary()
        param["bizData"] = dicParam
        param.updateValue(["flowKey": "unqualified_key"], forKey: "startFlowParamObject")
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/unqualified/v1/start", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["instId"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///待跟进--不合格单列表--分期和条线组合查询
    public func getUnqualifiedWaitFollowList(pageBean: PageBean, filter: UnqualifiedOrderListModel? = nil, success:@escaping (([UnqualifiedOrderListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let divideID = filter.divideID {
                let divideIDDict = queryParameters(property: "divide_id", operation: "EQUAL", value: divideID, relation: "AND")
                querysList.append(divideIDDict)
            }
            //条线
            if let line = filter.line {
                let lineDict = queryParameters(property: "line", operation: "EQUAL", value: line, relation: "AND")
                querysList.append(lineDict)
            }
            //状态
            if let status = filter.status {
                let statusDict = queryParameters(property: "status", operation: "EQUAL", value: status.rawValue, relation: "AND")
                querysList.append(statusDict)
            }
            
            //不合格单编号
            if let code = filter.code {
                let codeDict = queryParameters(property: "code", operation: "LIKE", value: code, relation: "OR")
                querysList.append(codeDict)
            }
            //问题描述
            if let problemDescription = filter.problemDescription {
                let problemDescriptionDict = queryParameters(property: "problem_description", operation: "LIKE", value: problemDescription, relation: "OR")
                querysList.append(problemDescriptionDict)
            }
        }
        param["querys"] = querysList
        let sortDic = ["property": "created_time", "direction": "DESC"]
        param["sorter"] = [sortDic]
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getTodoListAliaForApp/unqualified_key/NORMAL", parameters: param, success: { (json) in
            
            var resumes: [UnqualifiedOrderListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = UnqualifiedOrderListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///已跟进--不合格单列表--分期和条线组合查询
    public func getUnqualifiedDoneFollowList(pageBean: PageBean, filter: UnqualifiedOrderListModel? = nil, success:@escaping (([UnqualifiedOrderListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let divideID = filter.divideID {
                let divideIDDict = queryParameters(property: "divide_id", operation: "EQUAL", value: divideID, relation: "AND")
                querysList.append(divideIDDict)
            }
            //条线
            if let line = filter.line {
                let lineDict = queryParameters(property: "line", operation: "EQUAL", value: line, relation: "AND")
                querysList.append(lineDict)
            }
            //状态
            if let status = filter.status {
                let statusDict = queryParameters(property: "status", operation: "EQUAL", value: status.rawValue, relation: "AND")
                querysList.append(statusDict)
            }
            
            //不合格单编号
            if let code = filter.code {
                let codeDict = queryParameters(property: "code", operation: "LIKE", value: code, relation: "OR")
                querysList.append(codeDict)
            }
            //问题描述
            if let problemDescription = filter.problemDescription {
                let problemDescriptionDict = queryParameters(property: "problem_description", operation: "LIKE", value: problemDescription, relation: "OR")
                querysList.append(problemDescriptionDict)
            }
        }
        param["querys"] = querysList
        let sortDic = ["property": "created_time", "direction": "DESC"]
        param["sorter"] = [sortDic]
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getDoneListAliaForApp/unqualified_key", parameters: param, success: { (json) in
            
            var resumes: [UnqualifiedOrderListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = UnqualifiedOrderListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///不合格单--待跟进详情接口
    public func getUnqualifiedWaitDetail(taskID: String, success:@escaping ((UnqualifiedDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/bpm-runtime/runtime/task/v1/taskDetailMini?taskId=\(taskID)&reqParams", success: { (json) in
            
            let model = UnqualifiedDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///不合格单--已跟进详情接口
    public func getUnqualifiedDoneDetail(proInstID: String, success:@escaping ((UnqualifiedDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/bpm-runtime/runtime/instance/v1/getInstBO?proInstId=\(proInstID)", success: { (json) in
            
            let model = UnqualifiedDetailModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///工单列表--不合格单
    public func getOrderListUnqualifiedList(pageBean: PageBean, filter: UnqualifiedOrderListModel? = nil, success:@escaping (([UnqualifiedOrderListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var param = pageBeanParameter(pageBean)
        var querysList: [Any] = []
        if let filter = filter {
            //分期 id
            if let divideID = filter.divideID {
                let divideIDDict = queryParameters(property: "divide_id", operation: "EQUAL", value: divideID, relation: "AND")
                querysList.append(divideIDDict)
            }
            //条线
            if let line = filter.line {
                let lineDict = queryParameters(property: "line", operation: "EQUAL", value: line, relation: "AND")
                querysList.append(lineDict)
            }
            //状态
            if let status = filter.status {
                let statusDict = queryParameters(property: "status", operation: "EQUAL", value: status.rawValue, relation: "AND")
                querysList.append(statusDict)
            }
        }
        param["querys"] = querysList
        if let searchValue = filter?.problemDescription {
            param["params"] = ["searchValue": searchValue]
        }
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/task/v1/getWorkListBydefKeyForApp?defKey=unqualified_key", parameters: param, success: { (json) in
            
            var resumes: [UnqualifiedOrderListModel] = []
            let container = ListContainer(fromJson: json["data"])
            for row in container.rows {
                let resume = UnqualifiedOrderListModel(fromJson: row)
                resumes.append(resume)
            }
            success(resumes)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///反馈不合格工单
    
    public func feedbackUnqualifiedOrder(taskID: String, detailModel: UnqualifiedDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        //        reason 原因分析 必须
        //        corrective_action 纠正预防措施  必须
        //        feedback_date    反馈日期  必须
        //        feedback_enclosure 反馈图片  非必须
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["unqualified_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/unqualified/v1/feedback", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///验证不合格工单
    public func checkUnqualifiedOrder(taskID: String, detailModel: UnqualifiedDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        //        verification_situation    验证情况  必须
        //        verification_date    验证日期 (yyyy-MM-dd) 必须
        //        is_pass    是否通过 0不通过 1通过  必须
        //        verification_enclosure    验证图片 非必须
        
        var param = [String: Any]()
        var bizDataDict = [String: Any]()
        let detail = detailModel.toDictionary()
        if let tempData: [String: Any] = detail["data"] as? [String: Any] {
            if let tempDict: [String: Any] = tempData["unqualified_model"] as? [String: Any] {
                bizDataDict = tempDict
            }
        }
        
        param["bizData"] = bizDataDict
        
        var doNextParam = [String: Any]()
        doNextParam["taskId"] = taskID
        
        param["doNextParam"] = doNextParam
        
        BMSServices.shared.postRequest(with: "/workOrder/workOrder/unqualified/v1/validate", parameters: param, success: { (json) in
            
            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: 资源扫码
    //    //扫码获取资源计划和派工单待办
    //    public func getWaitOrder(userID: String, page: Int, pageSize: Int, resourceID: String, overTime: Int?, success:@escaping (([ResourceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
    //
    //        var dic: [String: Any] = Dictionary()
    //        dic["page"] = String(page)
    //        dic["pageSize"] = String(pageSize)
    //        dic["resId"] = resourceID
    //        dic["userId"] = userID
    //        if overTime != nil {
    //            dic["orderOverTime"] = String(overTime ?? 1)
    //        }
    //        BMSServices.shared.postRequest(with: "/resource/res-order/resource/wait", parameters: dic, success: { (json) in
    //            var array: [ResourceListModel] = []
    //            for infoJson in json["data"]["rows"].arrayValue {
    //                let model = ResourceListModel(fromJson: infoJson)
    //                array.append(model)
    //            }
    //            success(array)
    //        }, fail: { (error) in
    //            fail(error)
    //        })
    //    }
    
    //扫码获取资源计划和派工单待办
    public func getWaitOrderV2(userID: String, page: Int, pageSize: Int, resourceID: String, overTime: Int?, success:@escaping (([ResourceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        var dic: [String: Any] = Dictionary()
        dic["page"] = String(page)
        dic["pageSize"] = String(pageSize)
        dic["id"] = resourceID
        dic["resId"] = resourceID
        dic["userId"] = userID
        if overTime != nil {
            dic["orderOverTime"] = String(overTime ?? 1)
        }
        BMSServices.shared.postRequest(with: "/resource/res-order/resource/v2/merge/wait", parameters: dic, success: { (json) in
            var array: [ResourceListModel] = []
            for infoJson in json["data"]["rows"].arrayValue {
                let model = ResourceListModel(fromJson: infoJson)
                array.append(model)
            }
            success(array)
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //扫码获取资源历史计划和派工单
    //    public func getHistoryOrderList(page: Int, pageSize: Int, resourceID: String, overTime: Int?, success:@escaping (([ResourceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
    //
    //        var dic: [String: Any] = Dictionary()
    //        dic["page"] = String(page)
    //        dic["pageSize"] = String(pageSize)
    //        dic["resId"] = resourceID
    //        if overTime != nil {
    //            dic["orderOverTime"] = String(overTime ?? 1)
    //        }
    //        BMSServices.shared.postRequest(with: "/resource/res-order/resource/history", parameters: dic, success: { (json) in
    //
    //            var array: [ResourceListModel] = []
    //            for infoJson in json["data"]["rows"].arrayValue {
    //                let model = ResourceListModel(fromJson: infoJson)
    //                array.append(model)
    //            }
    //            success(array)
    //
    //        }, fail: { (error) in
    //            fail(error)
    //        })
    //    }
    
    //合并历史
    public func getHistoryOrderListV2(page: Int, pageSize: Int, resourceID: String, overTime: Int?, success:@escaping (([ResourceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
        var dic: [String: Any] = Dictionary()
        dic["page"] = String(page)
        dic["pageSize"] = String(pageSize)
        dic["id"] = resourceID
        if overTime != nil {
            dic["orderOverTime"] = String(overTime ?? 1)
        }
        BMSServices.shared.postRequest(with: "/resource/res-order/resource/v2/merge/history", parameters: dic, success: { (json) in
            
            var array: [ResourceListModel] = []
            for infoJson in json["data"]["rows"].arrayValue {
                let model = ResourceListModel(fromJson: infoJson)
                array.append(model)
            }
            success(array)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    ///资源扫码获取资源详细信息
    //    public func getOrderBaseInfo(resourceID: String, success:@escaping ((ResourceModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
    //        BMSServices.shared.getRequest(with: "/resource/res-order/resource/detail/\(resourceID)", success: { (json) in
    //
    //            let model = ResourceModel(fromJson: json["data"])
    //            success(model)
    //
    //        }, fail: { (error) in
    //            fail(error)
    //        })
    //    }
    
    ///资源扫码和查看巡更点
    public func getOrderOrPatrolPointInfo(resourceID: String, success:@escaping ((ResourceModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.getRequest(with: "/resource/res-order/resource/v2/detail/merge/\(resourceID)", success: { (json) in
            
            let model = ResourceModel(fromJson: json["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }
    
    //MARK: 公共部分
    ///查询审批开关是否打开
    public func getAuditSetting(typeKey: String, lineKey: String, success:@escaping ((Bool, Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {
        BMSServices.shared.getRequest(with: "/workOrder/workOrder/workOrderInnerAudit/v1/getAuditSetting?defKey=\(typeKey)&line=\(lineKey)", success: { (json) in
            let subJson = json["data"]
            success(subJson["delay"].boolValue, subJson["fClose"].boolValue)
        }, fail: { (error) in
            fail(error)
        })
    }
    
    // MARK: 巡更点扫码
    //    //扫码获取巡更点待办
    //    public func getWaitPatrol(userID: String, page: Int, pageSize: Int, resourceID: String, overTime: Int?, success:@escaping (([ResourceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
    //
    //        var dic: [String: Any] = Dictionary()
    //        dic["page"] = String(page)
    //        dic["pageSize"] = String(pageSize)
    //        dic["id"] = resourceID
    //        dic["userId"] = userID
    //        if overTime != nil {
    //            dic["orderOverTime"] = String(overTime ?? 1)
    //        }
    //        BMSServices.shared.postRequest(with: "/resource/res-order/resource/patrolPointWait", parameters: dic, success: { (json) in
    //
    //            var array: [ResourceListModel] = []
    //            for infoJson in json["data"]["rows"].arrayValue {
    //                let model = ResourceListModel(fromJson: infoJson)
    //                array.append(model)
    //            }
    //            success(array)
    //
    //        }, fail: { (error) in
    //            fail(error)
    //        })
    //    }
    
    //扫码获取巡更点历史列表
    //    public func getHistoryPatrolList(page: Int, pageSize: Int, resourceID: String, overTime: Int?, success:@escaping (([ResourceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {
    //
    //        var dic: [String: Any] = Dictionary()
    //        dic["page"] = String(page)
    //        dic["pageSize"] = String(pageSize)
    //        dic["id"] = resourceID
    //        if overTime != nil {
    //            dic["orderOverTime"] = String(overTime ?? 1)
    //        }
    //
    //        BMSServices.shared.postRequest(with: "/resource/res-order/resource/history/patrolPoint", parameters: dic, success: { (json) in
    //
    //            var array: [ResourceListModel] = []
    //            for infoJson in json["data"]["rows"].arrayValue {
    //                let model = ResourceListModel(fromJson: infoJson)
    //                array.append(model)
    //            }
    //            success(array)
    //
    //        }, fail: { (error) in
    //            fail(error)
    //        })
    //    }
    
    ///资源扫码获取巡更点信息
    //    public func getPatrolPointBaseInfo(resourceID: String, success:@escaping ((ResourceModel) -> Void), fail:@escaping (ErrorModel) -> Void) {
    //
    //        BMSServices.shared.getRequest(with: "/resource/api/resource/v1/patrolPoint/get/\(resourceID)", success: { (json) in
    //
    //            let model = ResourceModel(fromJson: json["data"])
    //            success(model)
    //
    //        }, fail: { (error) in
    //            fail(error)
    //        })
    //    }
    
    // MARK: 版本信息
    ///获取版本信息
    public func checkVersionUpdate(version: String, osVersion: String, success:@escaping (Bool, String, String) -> Void, fail:@escaping (ErrorModel) -> Void) {
        
        BMSServices.shared.postRequest(with: "/appcenter/api/appConf/v1/appbbConf/isUp", parameters: ["type": 1, "osVersion": osVersion, "version": version, "appCode": "bms"], success: { (json) in
            if let isForece = json["data"]["isForce"].bool {
                var contentStr = "因服务器系统升级，您的APP需要升级到最新版本！"
                if let content = json["data"]["content"].string {
                    contentStr = content
                }
                var versionStr = ""
                if let version = json["data"]["version"].string {
                    versionStr = version
                }
                success(isForece, contentStr, versionStr)
            } else {
                success(false, "", "")
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    public func GainSearchHouseList(page: Int, build: String?, unit: String?, house: String?, divideID: String,success:@escaping ([SearchHouseModel]) -> Void, fail:@escaping (ErrorModel) -> Void)  {

        var params: [String: Any] = [:]

        var querysList: [Any] = []

        if let build = build {
            let qu1 = queryParameters(property: "buildingName", operation: "LIKE", value: build, relation: "AND")
            querysList.append(qu1)
        }

        if let unit = unit {
            let qu1 = queryParameters(property: "unitName", operation: "LIKE", value: unit, relation: "AND")
            querysList.append(qu1)
        }

        if let house = house {
            let qu1 = queryParameters(property: "houseCode", operation: "LIKE", value: house, relation: "AND")
            querysList.append(qu1)
        }


        let qu2 = queryParameters(property: "divideId", operation: "EQUAL", value: divideID, relation: "AND")
        querysList.append(qu2)

        let qu3 = queryParameters(property: "enableFlag", operation: "EQUAL", value: "1", relation: "AND")
        querysList.append(qu3)

        params["querys"] = querysList
        params["pageBean"] = ["page":page,"pageSize":10,"showTotal":true]

        BMSServices.shared.postRequest(with: "/mdm/api/mdm/v1/house/list", parameters: params, success: { (json) in

            var dataArray:[SearchHouseModel] = []
            for unit in json["data"]["rows"].arrayValue {
                let model = SearchHouseModel(fromJson: unit)
                dataArray.append(model)
            }
            success(dataArray)

        }, fail: {error in
            fail(error)
        })
    }
}
