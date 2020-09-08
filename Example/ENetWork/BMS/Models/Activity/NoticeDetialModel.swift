//
//  NoticeDetialModel.swift
//  EServices
//
//  Created by uni on 2020/4/16.
//  Copyright © 2020 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class NoticeDetialModel: NSObject {

    public var id: String?

    public var title: String?

    public var type: String?

    public var content: String?

    public var insertLink: String?

    public var isLink: Int?

    public var releaseTime: String?

    public var endTime: String?

    public var picture: String?

    public var publisherOrganization: String?

    public var publisherOrganizationId: String?

    public var publishingTerminalFamily: String?

    public var publishingTerminalSmallProgram: String?

    public var publishingTerminalFeature: String?

    public var publishingOrganization: String?

    public var isImportant: String?

    public var readingNumber: String?

    public var thumbsUpNumber: String?

    public var thumbsDownNumber: String?

    public var publisherId: String?

    public var publisherName: String?

    public var auditorId: String?

    public var auditorName: String?

    public var status: String?

    public var createdBy: String?

    public var createdTime: String?

    public var updatedBy: String?

    public var updatedTime: String?

    public var rowVersion: String?

    public var isDeleted: String?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        id = json["id"].stringValue

        title = json["title"].stringValue

        type = json["type"].stringValue

        content = json["content"].stringValue

        insertLink = json["insertLink"].stringValue

        isLink = json["isLink"].intValue

        releaseTime = json["releaseTime"].stringValue

        endTime = json["endTime"].stringValue

        picture = json["picture"].stringValue

        publisherOrganization = json["publisherOrganization"].stringValue

        publisherOrganizationId = json["publisherOrganizationId"].stringValue

        publishingTerminalFamily = json["publishingTerminalFamily"].stringValue

        publishingTerminalSmallProgram = json["publishingTerminalSmallProgram"].stringValue

        publishingTerminalFeature = json["publishingTerminalFeature"].stringValue

        publishingOrganization = json["publishingOrganization"].stringValue

        isImportant = json["isImportant"].stringValue
        readingNumber = json["readingNumber"].stringValue
        thumbsUpNumber = json["thumbsUpNumber"].stringValue
        thumbsDownNumber = json["thumbsDownNumber"].stringValue
        publisherId = json["publisherId"].stringValue
        publisherName = json["publisherName"].stringValue
        auditorId = json["auditorId"].stringValue
        auditorName = json["auditorName"].stringValue
        status = json["status"].stringValue
        createdBy = json["createdBy"].stringValue
        if let time = json["createdTime"].string {
            createdTime = time
        } else {
            createdTime = json["createTime"].stringValue
        }
        updatedBy = json["updatedBy"].stringValue
        updatedTime = json["updatedTime"].stringValue
        rowVersion = json["rowVersion"].stringValue
        isDeleted = json["isDeleted"].stringValue

    }

}
