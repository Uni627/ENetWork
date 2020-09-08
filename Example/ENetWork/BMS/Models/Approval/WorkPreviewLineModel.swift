//
//  WorkPreviewLineModel.swift
//  EServices
//
//  Created by 刘小白 on 2019/12/12.
//  Copyright © 2019 uni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class WorkPreviewLineModel: NSObject {

    public var children: [String] = []
    public var depth: Int?
    public var ID: String?
    public var isLeaf: String?
    public var name: String?
    public var ownerID: String?
    public var parentID: String?
    public var path: String?
    public var sn: Int?
    public var struType: Int?
    public var text: String?
    public var typeGroupKey: String?
    public var typeKey: LineType?

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
//        children = json["children"].string

        children = [String]()
        depth = json["depth"].int
        ID = json["id"].string
        isLeaf = json["isLeaf"].string
        name = json["name"].string
        ownerID = json["ownerId"].string
        parentID = json["parentId"].string
        path = json["path"].string
        sn = json["sn"].int
        struType = json["struType"].int
        text = json["text"].string
        typeGroupKey = json["typeGroupKey"].string
        if let key = json["typeKey"].string {
            typeKey = LineType(rawValue: key)
        }
    }

}
