//
//  PatrolClassifyModel.swift
//  EServices
//
//  Created by pxy on 2019/11/8.
//

import Foundation
import SwiftyJSON

public class PatrolClassifyModel: NSObject {

    public var children: [PatrolClassifyModel] = []
    public var ID: String?
    public var key: String?
    public var name: String?

    public override init() {
        super.init()
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        children = [PatrolClassifyModel]()
        let childrenArray = json["children"].arrayValue
        for childrenJson in childrenArray {
            let value = PatrolClassifyModel(fromJson: childrenJson)
            children.append(value)
        }
        ID = json["id"].string
        key = json["key"].string
        name = json["name"].string
    }
}
