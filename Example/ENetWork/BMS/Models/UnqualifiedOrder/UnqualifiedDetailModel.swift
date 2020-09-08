//
//  UnqualifiedDetailModel.swift
//  EServices
//
//  Created by 刘小白 on 2020/1/9.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class UnqualifiedInfoModel: NSObject {
    
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

public class UnqualifiedDetailModel: NSObject, NSCoding {
    
    public var buttons: String?
    public var form: String?
    public var info: UnqualifiedInfoModel?
    public var opinionList: String?
    public var permission: String?
    public var result: Bool?
    public var checkDate: String?                     //检查日期
    public var checkUserID: String?                   //检查人Id
    public var checkUserName: String?                 //检查人姓名
    public var checkedUserID: String?                 //被检查人Id
    public var checkedUserName: String?               //被检查人姓名
    public var code: String?                          //工单编号
    public var completionTime: String?                //完成时间
    public var correctionDate: String?                //纠正截止日期
    public var correctiveAction: String?              //纠正预防措施
    public var createEnclosure: String?               //创建附件 图片集合字符串
    public var createEnclosureArray: [PictureModel] = []  //创建附件 图片集合字符串 图片Model 集合
    public var cacheEnclosureArray: [String] = []
    public var createdTime: String?                   //创建工单时间
    public var divideID: String?                      //分期Id
    public var divideName: String?                    //分期名称
    public var feedbackDate: String?                  //反馈日期
    public var feedbackEnclosure: String?             //反馈附件 图片集合字符串
    public var feedbackEnclosureArray: [PictureModel] = [] //反馈附件 图片集合字符串 图片Model 集合
    public var feedbackTime: String?                  //实际反馈时间
    public var feedbackUserID: String?                //实际反馈人Id
    public var feedbackUserName: String?              //实际反馈用户姓名
    public var id: String?
    public var initData: String?
    public var isPass: Int?                            //是否通过0 不通过 1通过
    public var line: String?                           //条线 取自数据字典
    public var parentCode: String?                     //父级工单编号
    public var originalCode: String?                     //原工单编号
    public var originalProInstID: String?               //原工单实例ID
    public var originalType: String?                    //原工单类型  1计划工单，2巡查工单 3.不合格单',
    public var parentID: String?                       //父级工单id
    public var problemDescription: String?             //问题描述
    public var procInstID: String?                     //实例id
    public var reason: String?                         //原因分析
    public var refID: String?
    public var severity: String?                       //严重程度 取自数据字典
    public var cacheStatus: String?                         //工单状态 取自数据字典
    public var status: UnqualifiedOrderState?             //工单状态 取自数据字典
    public var tenantID: String?                       //租户Id
    public var verificationDate: String?               //验证日期
    public var verificationEnclosure: String?          //验证附件 图片集合字符串
    public var verificationEnclosureArray: [PictureModel] = [] //验证附件 图片集合字符串 图片Model 集合
    public var verificationSituation: String?          //严重情况
    public var verifierID: String?                     //验证人Id
    public var verifierName: String?                   //实际验证人姓名
    
    public override init() {
        super.init()
    }
    
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        buttons = json["buttons"].string
        form = json["form"].string
        
        let initDataJson = json["info"]
        if !initDataJson.isEmpty {
            info = UnqualifiedInfoModel(fromJson: initDataJson)
        }
        
        opinionList = json["opinionList"].string
        permission = json["permission"].string
        result = json["result"].bool
        
        let dataJson = json["data"]["unqualified_model"]
        if !dataJson.isEmpty {
            checkDate = dataJson["check_date"].string
            checkUserID = dataJson["check_user_id"].string
            checkUserName = dataJson["check_user_name"].string
            checkedUserID = dataJson["checked_user_id"].string
            checkedUserName = dataJson["checked_user_name"].string
            code = dataJson["code"].string
            completionTime = dataJson["completion_time"].string
            correctionDate = dataJson["correction_date"].string
            correctiveAction = dataJson["corrective_action"].string
            createEnclosure = dataJson["create_enclosure"].string
            createEnclosureArray = [PictureModel]() //图片集合
            let tempFiles = dataJson["create_enclosure"].stringValue
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
                        cacheEnclosureArray.append(model.filePath ?? "")
                        createEnclosureArray.append(model)
                    }
                }
            }
            createdTime = dataJson["created_time"].string
            divideID = dataJson["divide_id"].string
            divideName = dataJson["divide_name"].string
            feedbackDate = dataJson["feedback_date"].string
            feedbackEnclosure = dataJson["feedback_enclosure"].string
            feedbackEnclosureArray = [PictureModel]() //图片集合
            let feedbackFiles = dataJson["feedback_enclosure"].stringValue
            if let jsonData = feedbackFiles.data(using: .utf8) {
                let json = JSON(jsonData)
                if json.arrayValue.count > 0 {
                    for tempJson in json.arrayValue {
                        let model = PictureModel(fromJson: tempJson)
                        if let path = model.filePath {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + path
                        } else {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                        }
                        feedbackEnclosureArray.append(model)
                    }
                }
            }
            feedbackTime = dataJson["feedback_time"].string
            feedbackUserID = dataJson["feedback_user_id"].string
            feedbackUserName = dataJson["feedback_user_name"].string
            id = dataJson["id_"].string
            initData = dataJson["initData"].string
            isPass = dataJson["is_pass"].int
            line = dataJson["line"].string
            parentCode = dataJson["parent_code"].string
            originalCode = dataJson["original_code"].string
            originalProInstID = dataJson["original_prolnstld"].string
            originalType = dataJson["original_type"].string
            parentID = dataJson["parent_id"].string
            problemDescription = dataJson["problem_description"].string
            procInstID = dataJson["proc_inst_id_"].string
            reason = dataJson["reason"].string
            refID = dataJson["ref_id_"].string
            severity = dataJson["severity"].string
            
            if let type = dataJson["status"].string {
                cacheStatus = type
                status = UnqualifiedOrderState(rawValue: type)
            }
            tenantID = dataJson["tenant_id"].string
            verificationDate = dataJson["verification_date"].string
            verificationEnclosure = dataJson["verification_enclosure"].string
            verificationEnclosureArray = [PictureModel]() //图片集合
            let verificationFiles = dataJson["verification_enclosure"].stringValue
            if let jsonData = verificationFiles.data(using: .utf8) {
                let json = JSON(jsonData)
                if json.arrayValue.count > 0 {
                    for tempJson in json.arrayValue {
                        let model = PictureModel(fromJson: tempJson)
                        if let path = model.filePath {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + path
                        } else {
                            model.filePath = EServicesConfig.BMSURL + "/media/" + ""
                        }
                        verificationEnclosureArray.append(model)
                    }
                }
            }
            verificationSituation = dataJson["verification_situation"].string
            verifierID = dataJson["verifier_id"].string
            verifierName = dataJson["verifier_name"].string
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
        var dictionary = [String: Any]()
        
        if checkDate != nil {
            dictionary["check_date"] = checkDate
        }
        if checkUserID != nil {
            dictionary["check_user_id"] = checkUserID
        }
        if checkUserName != nil {
            dictionary["check_user_name"] = checkUserName
        }
        if checkedUserID != nil {
            dictionary["checked_user_id"] = checkedUserID
        }
        if checkedUserName != nil {
            dictionary["checked_user_name"] = checkedUserName
        }
        if code != nil {
            dictionary["code"] = code
        }
        if completionTime != nil {
            dictionary["completion_time"] = completionTime
        }
        if correctionDate != nil {
            dictionary["correction_date"] = correctionDate
        }
        if correctiveAction != nil {
            dictionary["corrective_action"] = correctiveAction
        }
        if createEnclosure != nil {
            dictionary["create_enclosure"] = createEnclosure
        }
        if createdTime != nil {
            dictionary["created_time"] = createdTime
        }
        if divideID != nil {
            dictionary["divide_id"] = divideID
        }
        if divideName != nil {
            dictionary["divide_name"] = divideName
        }
        if feedbackDate != nil {
            dictionary["feedback_date"] = feedbackDate
        }
        if feedbackEnclosure != nil {
            dictionary["feedback_enclosure"] = feedbackEnclosure
        }
        if feedbackTime != nil {
            dictionary["feedback_time"] = feedbackTime
        }
        if feedbackUserID != nil {
            dictionary["feedback_user_id"] = feedbackUserID
        }
        if feedbackUserName != nil {
            dictionary["feedback_user_name"] = feedbackUserName
        }
        if id != nil {
            dictionary["id_"] = id
        }
        if initData != nil {
            dictionary["initData"] = initData
        }
        if isPass != nil {
            dictionary["is_pass"] = isPass
        }
        if line != nil {
            dictionary["line"] = line
        }
        if parentCode != nil {
            dictionary["parent_code"] = parentCode
        }
        if parentID != nil {
            dictionary["parent_id"] = parentID
        }
        if problemDescription != nil {
            dictionary["problem_description"] = problemDescription
        }
        if procInstID != nil {
            dictionary["proc_inst_id_"] = procInstID
        }
        if reason != nil {
            dictionary["reason"] = reason
        }
        if refID != nil {
            dictionary["ref_id_"] = refID
        }
        if severity != nil {
            dictionary["severity"] = severity
        }
        if status != nil {
            dictionary["status"] = status?.rawValue
        }
        if tenantID != nil {
            dictionary["tenant_id"] = tenantID
        }
        if verificationDate != nil {
            dictionary["verification_date"] = verificationDate
        }
        if verificationEnclosure != nil {
            dictionary["verification_enclosure"] = verificationEnclosure
        }
        if verificationSituation != nil {
            dictionary["verification_situation"] = verificationSituation
        }
        if verifierID != nil {
            dictionary["verifier_id"] = verifierID
        }
        if verifierName != nil {
            dictionary["verifier_name"] = verifierName
        }
        if originalCode != nil {
            dictionary["original_id"] = originalCode
        }
        if originalProInstID != nil {
            dictionary["original_prolnstld"] = originalProInstID
        }
        if originalType != nil {
            dictionary["original_type"] = originalType
        }
        var tempDictionary = [String: Any]()
        tempDictionary["unqualified_model"] = dictionary
        sureDictionary["data"] = tempDictionary
        
        return sureDictionary
    }
    
    
    @objc required public init(coder aDecoder: NSCoder) {
        cacheEnclosureArray = aDecoder.decodeObject(forKey: "cacheEnclosureArray") as? [String] ?? [String]()
        checkDate = aDecoder.decodeObject(forKey: "check_date") as? String
        checkUserID = aDecoder.decodeObject(forKey: "check_user_id") as? String
        checkUserName = aDecoder.decodeObject(forKey: "check_user_name") as? String
        checkedUserID = aDecoder.decodeObject(forKey: "checked_user_id") as? String
        checkedUserName = aDecoder.decodeObject(forKey: "checked_user_name") as? String
        code = aDecoder.decodeObject(forKey: "code") as? String
        completionTime = aDecoder.decodeObject(forKey: "completion_time")  as? String
        correctionDate = aDecoder.decodeObject(forKey: "correction_date") as? String
        correctiveAction = aDecoder.decodeObject(forKey: "corrective_action") as? String
        createEnclosure = aDecoder.decodeObject(forKey: "create_enclosure") as? String
        createdTime = aDecoder.decodeObject(forKey: "created_time") as? String
        divideID = aDecoder.decodeObject(forKey: "divide_id") as? String
        divideName = aDecoder.decodeObject(forKey: "divide_name") as? String
        feedbackDate = aDecoder.decodeObject(forKey: "feedback_date") as? String
        feedbackEnclosure = aDecoder.decodeObject(forKey: "feedback_enclosure") as? String
        feedbackTime = aDecoder.decodeObject(forKey: "feedback_time") as? String
        feedbackUserID = aDecoder.decodeObject(forKey: "feedback_user_id") as? String
        feedbackUserName = aDecoder.decodeObject(forKey: "feedback_user_name") as? String
        id = aDecoder.decodeObject(forKey: "id_") as? String
        initData = aDecoder.decodeObject(forKey: "initData") as? String
        isPass = aDecoder.decodeObject(forKey: "is_pass") as? Int
        line = aDecoder.decodeObject(forKey: "line") as? String
        parentCode = aDecoder.decodeObject(forKey: "parent_code") as? String
        parentID = aDecoder.decodeObject(forKey: "parent_id") as? String
        problemDescription = aDecoder.decodeObject(forKey: "problem_description") as? String
        procInstID = aDecoder.decodeObject(forKey: "proc_inst_id_") as? String
        reason = aDecoder.decodeObject(forKey: "reason") as? String
        refID = aDecoder.decodeObject(forKey: "ref_id_") as? String
        severity = aDecoder.decodeObject(forKey: "severity") as? String
        cacheStatus = aDecoder.decodeObject(forKey: "status") as? String
        tenantID = aDecoder.decodeObject(forKey: "tenant_id") as? String
        verificationDate = aDecoder.decodeObject(forKey: "verification_date") as? String
        verificationEnclosure = aDecoder.decodeObject(forKey: "verification_enclosure") as? String
        verificationSituation = aDecoder.decodeObject(forKey: "verification_situation") as? String
        verifierID = aDecoder.decodeObject(forKey: "verifier_id") as? String
        verifierName = aDecoder.decodeObject(forKey: "verifier_name") as? String
        
    }
    
    
    public func encode(with aCoder: NSCoder) {
        if cacheEnclosureArray.count  > 0 {
            aCoder.encode(cacheEnclosureArray, forKey: "cacheEnclosureArray")
        }
        if checkDate != nil {
            aCoder.encode(checkDate, forKey: "check_date")
        }
        if checkUserID != nil {
            aCoder.encode(checkUserID, forKey: "check_user_id")
        }
        if checkUserName != nil {
            aCoder.encode(checkUserName, forKey: "check_user_name")
        }
        if checkedUserID != nil {
            aCoder.encode(checkedUserID, forKey: "checked_user_id")
        }
        if checkedUserName != nil {
            aCoder.encode(checkedUserName, forKey: "checked_user_name")
        }
        if code != nil {
            aCoder.encode(code, forKey: "code")
        }
        if completionTime != nil {
            aCoder.encode(completionTime, forKey: "completion_time")
        }
        if correctionDate != nil {
            aCoder.encode(correctionDate, forKey: "correction_date")
        }
        if correctiveAction != nil {
            aCoder.encode(correctiveAction, forKey: "corrective_action")
        }
        if createEnclosure != nil {
            aCoder.encode(createEnclosure, forKey: "create_enclosure")
        }
        if createdTime != nil {
            aCoder.encode(createdTime, forKey: "created_time")
        }
        if divideID != nil {
            aCoder.encode(divideID, forKey: "divide_id")
        }
        if divideName != nil {
            aCoder.encode(divideName, forKey: "divide_name")
        }
        if feedbackDate != nil {
            aCoder.encode(feedbackDate, forKey: "feedback_date")
        }
        if feedbackEnclosure != nil {
            aCoder.encode(feedbackEnclosure, forKey: "feedback_enclosure")
        }
        if feedbackTime != nil {
            aCoder.encode(feedbackTime, forKey: "feedback_time")
        }
        if feedbackUserID != nil {
            aCoder.encode(feedbackUserID, forKey: "feedback_user_id")
        }
        if feedbackUserName != nil {
            aCoder.encode(feedbackUserName, forKey: "feedback_user_name")
        }
        if id != nil {
            aCoder.encode(id, forKey: "id_")
        }
        if initData != nil {
            aCoder.encode(initData, forKey: "initData")
        }
        if isPass != nil {
            aCoder.encode(isPass, forKey: "is_pass")
        }
        if line != nil {
            aCoder.encode(line, forKey: "line")
        }
        if parentCode != nil {
            aCoder.encode(parentCode, forKey: "parent_code")
        }
        if parentID != nil {
            aCoder.encode(parentID, forKey: "parent_id")
        }
        if problemDescription != nil {
            aCoder.encode(problemDescription, forKey: "problem_description")
        }
        if procInstID != nil {
            aCoder.encode(procInstID, forKey: "proc_inst_id_")
        }
        if reason != nil {
            aCoder.encode(reason, forKey: "reason")
        }
        if refID != nil {
            aCoder.encode(refID, forKey: "ref_id_")
        }
        if severity != nil {
            aCoder.encode(severity, forKey: "severity")
        }
        if cacheStatus != nil {
            aCoder.encode(cacheStatus, forKey: "status")
        }
        if tenantID != nil {
            aCoder.encode(tenantID, forKey: "tenant_id")
        }
        if verificationDate != nil {
            aCoder.encode(verificationDate, forKey: "verification_date")
        }
        if verificationEnclosure != nil {
            aCoder.encode(verificationEnclosure, forKey: "verification_enclosure")
        }
        if verificationSituation != nil {
            aCoder.encode(verificationSituation, forKey: "verification_situation")
        }
        if verifierID != nil {
            aCoder.encode(verifierID, forKey: "verifier_id")
        }
        if verifierName != nil {
            aCoder.encode(verifierName, forKey: "verifier_name")
        }
        
    }
    
}
