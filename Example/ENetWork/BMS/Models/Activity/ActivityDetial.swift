//
//  ActivityDetial.swift
//  EServices
//
//  Created by uni on 2020/4/22.
//  Copyright © 2020 uni. All rights reserved.
//

import UIKit
import SwiftyJSON

public class ActivityDetial: NSObject {

    public var partNum: String?
    public var updatedBy: String?
    public var content: String?
    public var deadlineTime: String?
    public var address: String?
    public var thumbsDownNumber: String?
    public var publisherOrganization: String?
    public var contacts: String?
    public var title: String?
    public var publisherId: String?
    public var updateTime: String?
    public var publishingTerminalSmallProgram: String?
    public var isLink: String?
    public var publisherName: String?
    public var publishingOrganization: String?
    public var readingNumber: String?
    public var endTime: String?
    public var createdTime: String?
    public var releaseTime: String?
    public var cost: String?
    public var telephone: String?
    public var isDeleted: String?
    public var publishingTerminalFeature: String?
    public var createdBy: String?
    public var thumbsUpNumber: String?
    public var id: String?
    public var publishingTerminalFamily: String?
    public var status: String?
    public var reviewContent: String?
    public var participantNum: Int?

    public var cancelReason: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        cancelReason = json["cancelReason"].stringValue

        participantNum = json["participantNum"].int
        partNum = json["partNum"].stringValue
        updatedBy = json["updatedBy"].stringValue
        content = json["content"].stringValue
        deadlineTime = json["deadlineTime"].stringValue
        address = json["address"].stringValue
        thumbsDownNumber = json["thumbsDownNumber"].stringValue
        publisherOrganization = json["publisherOrganization"].stringValue
        contacts = json["contacts"].stringValue
        title = json["title"].stringValue
        publisherId = json["publisherId"].stringValue
        updateTime = json["updateTime"].stringValue
        publishingTerminalSmallProgram = json["publishingTerminalSmallProgram"].stringValue
        isLink = json["isLink"].stringValue
        publisherName = json["publisherName"].stringValue
        publishingOrganization = json["publishingOrganization"].stringValue
        readingNumber = json["readingNumber"].stringValue
        endTime = json["endTime"].stringValue
        createdTime = json["createdTime"].stringValue
        releaseTime = json["releaseTime"].stringValue
        cost = json["cost"].stringValue
        telephone = json["telephone"].stringValue
        isDeleted = json["isDeleted"].stringValue
        publishingTerminalFeature = json["publishingTerminalFeature"].stringValue
        createdBy = json["createdBy"].stringValue
        thumbsUpNumber = json["thumbsUpNumber"].stringValue
        id = json["id"].stringValue
        publishingTerminalFamily = json["publishingTerminalFamily"].stringValue
        status = json["status"].stringValue
        reviewContent = json["reviewContent"].string
    }
}
