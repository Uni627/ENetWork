//
//  ConnectFeedModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/19.
//  Copyright © 2019 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ConnectTaskModel: NSObject {

    public var createTime: String?
    public var id: String?
    public var instanceID: String?
    public var nodeID: String?
    public var nodeName: String?
    public var opinion: String?
    public var sender: String?
    public var senderID: String?
    public var taskID: String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        createTime = json["createtime"].string
        id = json["id"].string
        instanceID = json["instanceId"].string
        nodeID = json["nodeId"].string
        nodeName = json["nodeName"].string
        opinion = json["opinion"].string
        sender = json["sender"].string
        senderID = json["senderId"].string
        taskID = json["taskId"].string
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if createTime != nil {
            dictionary["createtime"] = createTime
        }
        if id != nil {
            dictionary["id"] = id
        }
        if instanceID != nil {
            dictionary["instanceId"] = instanceID
        }
        if nodeID != nil {
            dictionary["nodeId"] = nodeID
        }
        if nodeName != nil {
            dictionary["nodeName"] = nodeName
        }
        if opinion != nil {
            dictionary["opinion"] = opinion
        }
        if sender != nil {
            dictionary["sender"] = sender
        }
        if senderID != nil {
            dictionary["senderId"] = senderID
        }
        if taskID != nil {
            dictionary["taskId"] = taskID
        }
        return dictionary
    }

}

public class ConnectReceiverModel: NSObject {

    public var commuID: String?
    public var createOrgID: String?
    public var expectTime: Int?                //期待答复时间 整形 毫秒
    public var expectTimeStr: String?          //期待答复时间 整形转 年月日时分秒
    public var feedbackTime: String?
    public var id: String?
    public var opinion: String?
    public var receiveTime: String?               //
    public var receiver: String?
    public var receiverID: String?
    public var status: String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        commuID = json["commuId"].string
        createOrgID = json["createOrgId"].string

        expectTime = json["expectTime"].int
        let expectTimeTemp = json["expectTime"].double
        if expectTimeTemp != nil {
            expectTimeStr = expectTimeTemp?.dateString(outputFormatter: "yyyy-MM-dd HH:mm:ss")
        }

        feedbackTime = json["feedbackTime"].string
        id = json["id"].string
        opinion = json["opinion"].string
        receiveTime = json["receiveTime"].string
        receiver = json["receiver"].string
        receiverID = json["receiverId"].string
        status = json["status"].string
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if commuID != nil {
            dictionary["commuId"] = commuID
        }
        if createOrgID != nil {
            dictionary["createOrgId"] = createOrgID
        }
        if expectTime != nil {
            dictionary["expectTime"] = expectTime
        }
        if feedbackTime != nil {
            dictionary["feedbackTime"] = feedbackTime
        }
        if id != nil {
            dictionary["id"] = id
        }
        if opinion != nil {
            dictionary["opinion"] = opinion
        }
        if receiveTime != nil {
            dictionary["receiveTime"] = receiveTime
        }
        if receiver != nil {
            dictionary["receiver"] = receiver
        }
        if receiverID != nil {
            dictionary["receiverId"] = receiverID
        }
        if status != nil {
            dictionary["status"] = status
        }
        return dictionary
    }

}

public class ConnectFeedModel: NSObject {

    public var commuReceivers: [ConnectReceiverModel] = []
    public var taskCommu: ConnectTaskModel?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        commuReceivers = [ConnectReceiverModel]()
        let commuReceiversArray = json["commuReceivers"].arrayValue
        for commuReceiversJson in commuReceiversArray {
            let value = ConnectReceiverModel(fromJson: commuReceiversJson)
            commuReceivers.append(value)
        }

        let taskCommuJson = json["taskCommu"]
        if !taskCommuJson.isEmpty {
            taskCommu = ConnectTaskModel(fromJson: taskCommuJson)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()

        if commuReceivers.count > 0 {
            var dictionaryElements = [[String: Any]]()
            for commuReceiversElement in commuReceivers {
                dictionaryElements.append(commuReceiversElement.toDictionary())
            }
            dictionary["commuReceivers"] = dictionaryElements
        }

        if taskCommu != nil {
            dictionary["taskCommu"] = taskCommu?.toDictionary()
        }

        return dictionary
    }

}
