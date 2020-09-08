//
//  PictureModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/6.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PictureModel: NSObject {

    public var fileID: String?
    public var fileName: String?
    public var filePath: String? //图片路径
    public var size: Int?
    public var success: Bool?

    public override init() {
        super.init()
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        if let tempfileID = json["fileId"].string {
            fileID = tempfileID
        } else {
            fileID = json["id"].string
        }
        if let tempFileName = json["fileName"].string {
            fileName = tempFileName
        } else {
            fileName = json["name"].string
        }
        if let tempFilePath = json["filePath"].string {
            filePath = tempFilePath
        } else {
            filePath = json["path"].string
        }

        size = json["size"].int
        success = json["success"].bool
    }
}
