//
//  FeedBackModel.swift
//  EServices
//
//  Created by uni on 2020/6/11.
//  Copyright © 2020 EinYun. All rights reserved.
//

import UIKit
import SwiftyJSON

public class FeedBackModel: NSObject {

    public var status: Int?  //'回复状态，1:待回复，2:已回复',
    public var source: String?  //'来源 0.pc  1.一应未来 2.一应家园',
    public var feedbackName: String? //'反馈人姓名',
    public var feedbackCode: String? //'反馈编号',
    public var feedbackPhone: String? //反馈人手机号
    public var feedbackAccount: String? //反馈人账号
    public var feedbackId: String? //反馈人id'

    public var creationDate: String? //创建时间
    public var updationDate: String? //更新时间

    public var companyId: String? //集团id
    public var companyName: String? //集团名称
    public var orgName: String? //社区名称
    public var orgId: String? //社区id

    public var title: String? //标题
    public var content: String? //反馈内容
    public var id: String? //主键
    public var issueType: String? // '意见反馈问题类型，1:功能优化、2:新需求、3:运维支持 4.其他 ',
    public var replyName: String? //回复人名称
    public var replyPhone: String? //回复人手机号
    public var replyId: String? //回复id
    public var reply: String? //回复内容
    public var attachment: String? //附件
    public var attachmentArray: [PictureModel] = []    //图片 model 集合

    init?(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        id = json["id"].stringValue
        status = json["status"].intValue

        title = json["title"].stringValue
        content = json["content"].stringValue
        creationDate = json["creationDate"].stringValue

        orgName = json["orgName"].stringValue
        orgId = json["orgId"].stringValue

        replyName = json["replyName"].stringValue
        replyPhone = json["replyPhone"].stringValue
        replyId = json["replyId"].stringValue
        reply = json["reply"].stringValue
        updationDate = json["updationDate"].stringValue

        attachment = json["attachment"].stringValue
        if let jsonData = attachment?.data(using: .utf8) {
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
    }
}
