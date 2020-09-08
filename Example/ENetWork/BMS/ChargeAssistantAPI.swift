//
//  ChargeAssistantAPI.swift
//  EServices
//
//  Created by pxy on 2020/2/13.
//  Copyright © 2020 EinYun. All rights reserved.
//

public class ChargeAssistantAPI: EBaseAPI {
    public static let shared = ChargeAssistantAPI()

    /// 通过MDMID查询收费ID的接口
    /// - Parameters:
    ///   - type: 分类  0分期，1楼栋，2单元，3房产，4客户
    ///   - queryID: 查询的ID
    ///   - success:
    ///   - fail:
    public func queryIdByMainID(type: String, queryID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        ChargeAssistantServices.shared.postRequest(with: "/payInfo/queryIdByMdmid/\(type)/\(queryID)", parameters: Dictionary(), success: { (json) in

            success(json["data"].stringValue)
        }, fail: { (error) in
            fail(error)
        })
    }

    ///房产获取
    public func getHouses(divideID: String, buildingName: String, unitCode: String, success:@escaping (([ChargeAssistantHouseModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/api/fee/house", parameters: ["divideId": divideID, "buildingName": buildingName, "unitCode": unitCode], success: { (json) in

            var list: [ChargeAssistantHouseModel] = []
            if let jsonArray = json["data"].array {
                for chartJson in jsonArray {
                    let info = ChargeAssistantHouseModel(fromJson: chartJson)
                    list.append(info)
                }
                success(list)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 欠费详单列表
    /// - Parameters:
    ///   - isArrears: <#isArrears description#>
    ///   - divideID: <#divideID description#>
    ///   - buildingName: <#buildingName description#>
    ///   - unitCode: <#unitCode description#>
    ///   - success: <#success description#>
    ///   - fail: <#fail description#>
    public func getChargeAssistantList(isArrears: String, divideID: String, buildingName: String, unitCode: String, success:@escaping (([ChargeAssistantOweListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/api/fee/feelist", parameters: ["divideId": divideID, "buildingName": buildingName, "unitCode": unitCode, "isarrears": isArrears], success: { (json) in

            var list: [ChargeAssistantOweListModel] = []
            if let jsonArray = json["data"].array {
                for chartJson in jsonArray {
                    let info = ChargeAssistantOweListModel(fromJson: chartJson)
                    list.append(info)
                }
                success(list)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    /// 获取上一次缴费时间
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - success:
    ///   - fail:
    public func getOverduePaymentByDivideID(divideID: String, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.getRequest(with: "/payment/getOverduePaymentByDivideId/\(divideID)", success: { (json) in
            if let data = json["data"]["data"]["urgeDate"].string {
                success(data)
            } else {
                success("")
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    /// 欠款详单列表
    /// - Parameters:
    ///   - houseID: 房间ID
    ///   - success:
    ///   - fail:
    public func getPayAmountList(houseID: String, success:@escaping ((ChargeAssisitantOweDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/payment/uppaidAmountOutV2", parameters: ["houseId": houseID], success: { (json) in

            let model = ChargeAssisitantOweDetailModel(fromJson: json["data"]["data"])
            success(model)

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 已付费用信息获取
    /// - Parameters:
    ///   - pageBean: 页数
    ///   - houseID: 房产ID
    ///   - payOrderType: 支付业务类型
    ///   - divideId: 分期ID
    ///   - channel: -1 ：显示所有渠道数据支付记录   1： 表示智能POS-APP渠道支付记录
    ///   - success:
    ///   - fail:
    public func getPaidAmountList(pageBean: BasicPage, houseID: String, payOrderType: String, divideID: String, channel: String, success:@escaping ((ChargeAssisitantPaidListModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = pageBean.toDictionary()
        dic["houseId"] = houseID
        dic["pOrderType"] = payOrderType
        dic["divideId"] = divideID
        dic["channel"] = channel

        ChargeAssistantServices.shared.postRequest(with: "/api/fee/payment/paidAmountListOut", parameters: dic, success: { (json) in

            let model = ChargeAssisitantPaidListModel(fromJson: json["data"])
            success(model)

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 跳缴验证
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - houseID: 房产ID
    ///   - feeList: 物业应收列表
    ///   - success:
    ///   - fail:
    public func checkPaymentJump(divideID: String, houseID: String, feeList: [String], success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["houseId"] = houseID
        var dicArr: [[String: Any]] = []
        for item in feeList {
            dicArr.append(["receivableId": item])
        }
        dic["feeList"] = dicArr

        ChargeAssistantServices.shared.postRequest(with: "/payment/check_jump", parameters: dic, success: { (json) in

            if let status = json["data"]["data"].bool {
                success(status)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 预缴的收费项目欠费检查接口
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - houseID: 房产ID
    ///   - feeItemIds: 预缴收费项目id数组
    ///   - success:
    ///   - fail:
    public func prePayCheckIn(divideID: String, houseID: String, feeItemIds: [String], success:@escaping (([Bool]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["houseId"] = houseID
        dic["feeItemIds"]  = feeItemIds

        ChargeAssistantServices.shared.postRequest(with: "/payment/prepaycheck_in", parameters: dic, success: { (json) in
            var responseArray: [Bool] = []
            if let dataDictinary = json["data"]["data"].dictionary {

                for item in feeItemIds {
                    if let status = dataDictinary["\(item)"]?.bool {
                        responseArray.append(status)
                    } else {
                        responseArray.append(false)
                    }
                }
                success(responseArray)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    ///支付结果通知
    public func getPaymentResult(payModel: ChargeAssistantPayDetailModel, success:@escaping ((String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        ChargeAssistantServices.shared.postRequest(with: "/payment/paymentresult_out", parameters: payModel.toDictionary(), success: { (json) in

            if let _ = json["state"].bool {
                success(json["msg"].string ?? "")
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    ///获取车位接口
    public func getHouseParking(divideID: String, houseID: String, success:@escaping (([ChargeAssistantHousePakingModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["houseId"] = houseID

        ChargeAssistantServices.shared.postRequest(with: "/houseParking/getByHouseId", parameters: dic, success: { (json) in

            var list: [ChargeAssistantHousePakingModel] = []
            if let jsonArray = json["data"].array {
                for chartJson in jsonArray {
                    let info = ChargeAssistantHousePakingModel(fromJson: chartJson)
                    list.append(info)
                }
                success(list)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 已付费用明细获取
    /// - Parameters:
    ///   - openID:
    ///   - success:
    ///   - fail:
    public func getPaidSuccessList(openID: String, success:@escaping (([ChargeAssistantPaidSuccessModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/payment/paidamountDetailOut", parameters: ["serialNum": openID], success: { (json) in

            var list: [ChargeAssistantPaidSuccessModel] = []

            if let jsonArray = json["data"]["data"]["deatil"].array {
                for subJson in jsonArray {

                    if let subArray = subJson["list"].array {
                        for listJson in subArray {
                            let info = ChargeAssistantPaidSuccessModel(fromJson: listJson)
                            list.append(info)
                        }
                    }

                }
                success(list)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 获取指定分期下所有房产欠费情况
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - type: 查询类型  1:楼幢;2:单元；3:房号
    ///   - buildingIds: 楼栋IDs
    ///   - untiIds: 单元IDs
    ///   - houseIds: 房产IDs
    ///   - success:
    ///   - fail:
    public func getFeeByQuery(divideID: String, type: Int, buildingIds: [String]?, unitIds: [String]?, houseIds: [String]?, success:@escaping ((ChargeAssistantArrearsDetailModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["buildingIds"] =  buildingIds
        dic["unitIds"] = unitIds
        dic["houseIdS"] = houseIds
        dic["type"] = type

        ChargeAssistantServices.shared.postRequest(with: "/payment/getFeeByQuery", parameters: dic, success: { (json) in

            let model = ChargeAssistantArrearsDetailModel(fromJson: json["data"]["data"])
            success(model)
            
        }, fail: { (error) in
            fail(error)
        })
    }

    /// 获取指定房产的欠费信息包含催交记录
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - houseID: 房产ID
    ///   - success:
    ///   - fail:
    public func getFeeInfoByHouse(divideID: String, houseID: String, success:@escaping ((ChargeAssistantArrearsByHourseModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["houseId"] = houseID

        ChargeAssistantServices.shared.postRequest(with: "/payment/getFeeInfoByHouse", parameters: dic, success: { (json) in

            let model = ChargeAssistantArrearsByHourseModel(fromJson: json["data"]["data"])
            success(model)

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 获取指定房产的预缴列表包含月单价
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - houseID: 房产ID
    ///   - success:
    ///   - fail:
    public func getAdvanceFeeItem(divideID: String, houseID: String, success:@escaping (([ChargeAssisitantAdvanceListModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["houseId"] = houseID

        ChargeAssistantServices.shared.postRequest(with: "/payment/advanceFeeItemIn", parameters: dic, success: { (json) in

            var list: [ChargeAssisitantAdvanceListModel] = []
            if let jsonArray = json["data"]["data"]["dataList"].array {
                for chartJson in jsonArray {
                    let info = ChargeAssisitantAdvanceListModel(fromJson: chartJson)
                    list.append(info)
                }
                success(list)
            } else {
                fail(ErrorModel.custom("该房产无任何收费项"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 催缴某一分期下所有房产或某个房产
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - buildingIds: 楼栋ID
    ///   - unitIds: 单元ID
    ///   - houseIds: 房产ID
    ///   - operateType: 0系统催缴；1线下催缴
    ///   - operateRemark: 线下催缴说明，线下必填
    ///   - operateTime: 线下催缴时间，线下必填
    ///   - success:
    ///   - fail:
    public func overduePaymentCall(divideID: String, buildingIds: [String]?, unitIds: [String]?, houseIds: [String]?, operateType: String, operateRemark: String? = nil, operateTime: String? = nil, success:@escaping ((Bool, String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["buildingIds"] = buildingIds
        dic["unitIds"] = unitIds
        dic["houseIdS"] = houseIds
        dic["operateType"] = operateType

        if operateRemark != nil {
            dic["operateRemark"] = operateRemark
        }
        if operateTime != nil {
            dic["operateTime"] = operateTime
        }

        ChargeAssistantServices.shared.postRequest(with: "/payment/overduePaymentCall", parameters: dic, success: { (json) in

            if let _ = json["state"].bool {
                var str = "催缴消息已发送成功！"
                if let msg = json["data"]["msg"].string {
                    if msg.count > 0 {
                        str = msg
                    }
                }
                if let code = json["data"]["code"].int {
                    if code == 0 {
                        success(true, str)
                    } else {
                        success(false, str)
                    }
                } else {
                    success(true, str)
                }
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    public func getImmediatePayment(payOrderType: String, userId: String, payAmount: Double, houseID: String, houseName: String, divideID: String, paymentList: [ChargeAssistantImmediateRequestModel], success:@escaping ((Int) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["payOrderType"] = payOrderType
        dic["userId"] = userId
        let amount = String.init(format: "%.2f", payAmount)
        dic["payAmount"] = NSDecimalNumber.init(string: amount)
        dic["houseId"] = houseID
        dic["houseName"] = houseName
        dic["divideId"] = divideID

        var paymentDicArray: [[String: Any]] = []
        for item in paymentList {
            let paymentDic = item.toDictionary()
            paymentDicArray.append(paymentDic)
        }
        dic["paymentDetails"] = paymentDicArray

        ChargeAssistantServices.shared.postRequest(with: "/payInfo/immediatePayment", parameters: dic, success: { (json) in

            if let orderId = json["data"].int {
                success(orderId)
            } else {
                fail(ErrorModel.custom("获取数据异常"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    public func getQRCode(orderID: String, success:@escaping ((UIImage) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.getRequest(with: "/payInfo/getQRCode?orderId=\(orderID)", successImage: { (image) in

            success(image)

        }, fail: { (error) in
            fail(error)
        })
    }

    public func confirmOrderStatus(orderID: String, success:@escaping ((ChargeAssistantCheckOrderModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["id"] = orderID

        ChargeAssistantServices.shared.postRequest(with: "/payInfo/confirmationOrder/\(orderID)", parameters: Dictionary(), success: { (json) in

            let model = ChargeAssistantCheckOrderModel(fromJson: json["data"])
            success(model)

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 根据手机号查询业主
    /// - Parameters:
    ///   - divideID: 分期ID
    ///   - phone: 手机号
    ///   - success:
    ///   - fail:
    public func getClientByPhone(divideID: String, phone: String, success:@escaping ((ChargeAssistantClientModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        var dic: [String: Any] = Dictionary()
        dic["divideId"] = divideID
        dic["cellphone"] = phone

        ChargeAssistantServices.shared.postRequest(with: "/v1/client/getClientByPhone", parameters: dic, success: { (json) in

            let model = ChargeAssistantClientModel(fromJson: json["data"]["data"])
            success(model)

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 添加住户
    /// - Parameters:
    ///   - model:
    ///   - success:
    ///   - fail:
    public func bindHouseOwner(model: ChargeAssistantClientModel, success:@escaping ((Bool) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/v1/house/bindHouseOwner", parameters: model.toDictionary(), success: { (json) in

            if let status = json["state"].bool {
                if status {
                    if json["data"]["code"].int == 0 {
                        success(true)
                    } else {
                        success(false)
                    }
                } else {
                    success(false)
                }
            } else {
                success(false)
            }
        }, fail: { (error) in
            fail(error)
        })
    }

    /// 获取字典（身份或证件类型）
    /// - Parameters:
    ///   - type: 查询类型
    ///   - success:
    ///   - fail:
    public func getRelationsOrCredentials(type: String, success:@escaping (([ChargeAssistantClinetDetailModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.getRequest(with: "/v1/house/getOwnerType/\(type)", success: { (json) in

            var list: [ChargeAssistantClinetDetailModel] = []
            if let jsonArray = json["data"]["data"].array {
                for chartJson in jsonArray {
                    let info = ChargeAssistantClinetDetailModel(fromJson: chartJson)
                    list.append(info)
                }
                success(list)
            } else {
                fail(ErrorModel.custom("查询类型失败"))
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 获取住户标签
    /// - Parameters:
    ///   - clientID: 住户ID
    ///   - divideID: 分期ID
    ///   - success:
    ///   - fail: 
    public func getLableByHouse(clientID: String, divideID: String, success:@escaping (([ChargeAssistantClinetTagModel]) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/v1/house/getLableByHouse", parameters: ["clientId": clientID, "divideId": divideID], success: { (json) in

            var list: [ChargeAssistantClinetTagModel] = []
            if let jsonArray = json["data"]["data"]["tagList"].array {
                for chartJson in jsonArray {
                    let info = ChargeAssistantClinetTagModel(fromJson: chartJson)
                    list.append(info)
                }
                success(list)
            } else {
                success(list)
            }

        }, fail: { (error) in
            fail(error)
        })
    }

    /// 打标签
    /// - Parameters:
    ///   - userID: 当前登录人ID
    ///   - divideID: 分期ID
    ///   - clientID: 业主ID
    ///   - tags: 新增标签集合
    ///   - success:
    ///   - fail:
    public func addTag(userID: String, divideID: String, clientID: String, tags: [String], success:@escaping ((Bool, String) -> Void), fail:@escaping (ErrorModel) -> Void) {

        ChargeAssistantServices.shared.postRequest(with: "/v1/house/AddLable", parameters: ["updateBy": userID, "clientId": clientID, "divideId": divideID, "lables": tags], success: { (json) in

            if let status = json["state"].bool {
                if status {
                    if json["data"]["code"].int == 0 {
                        success(true, "提交成功")
                    } else {
                        success(false, json["data"]["msg"].string ?? "")
                    }
                } else {
                    success(false, json["data"]["msg"].string ?? "")
                }
            } else {
                success(false, json["data"]["msg"].string ?? "")
            }

        }, fail: { (error) in
            fail(error)
        })
    }

}
