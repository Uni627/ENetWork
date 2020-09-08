//
//  CustomerApplyDelayModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/21.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CustomerApplyDelayModel: NSObject {

    public var applyInsID: String?             //实例id
    public var auditType: AuditSubtype?        //延期的 类型
    public var bizId: String?                  //主键id
    public var divideId: String?               //分期id
    public var divideName: String?             //分期名称

    public var applyReason: String?            //申请原因
    public var attachment: String?             //延期上传的图片
    public var attachmentArray: [PictureModel] = []    //延期上传的图片 model 集合
    public var delayNumber: Int?               //延期次数
    public var delaySumTime: Int?              //延期总时
    public var delayTime: String?              //延期天数

//    public var formData : FormData?

    public override init() {
        super.init()
    }
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        applyInsID = json["applyInsId"].string

        if let type = json["auditType"].string {
            auditType = AuditSubtype(rawValue: type)
        }

        bizId = json["bizId"].string
        divideId = json["divideId"].string
        divideName = json["divideName"].string

        let dataJson = json["formData"]

        if !dataJson.isEmpty {

            applyReason = dataJson["apply_reason"].string

            attachment = dataJson["attachment"].string
            attachmentArray = [PictureModel]() //图片集合
            let tempFiles = dataJson["attachment"].stringValue
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

            delayNumber = dataJson["delay_number"].int
            delaySumTime = dataJson["delay_sum_time"].int
            delayTime = dataJson["delay_time"].string
        }
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if applyInsID != nil {
            dictionary["applyInsId"] = applyInsID
        }
        if auditType != nil {
            dictionary["auditType"] = auditType?.rawValue
        }
        if bizId != nil {
            dictionary["bizId"] = bizId
        }
        if divideId != nil {
            dictionary["divideId"] = divideId
        }
        if divideName != nil {
            dictionary["divideName"] = divideName
        }

        var tempDictionary = [String: Any]()

        if applyReason != nil {
            tempDictionary["apply_reason"] = applyReason
        }
        if attachment != nil {
            tempDictionary["attachment"] = attachment
        }
        if delayNumber != nil {
            tempDictionary["delay_number"] = delayNumber
        }
        if delaySumTime != nil {
            tempDictionary["delay_sum_time"] = delaySumTime
        }
        if delayTime != nil {
            tempDictionary["delay_time"] = delayTime
        }

        dictionary["formData"] = tempDictionary

        return dictionary
    }

}
