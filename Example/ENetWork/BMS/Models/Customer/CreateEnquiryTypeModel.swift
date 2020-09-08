//
//  CreateEnquiryTypeModel.swift
//  EServices
//
//  Created by orichy on 2020/7/15.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON


public class CreateEnquiryTypeModel : NSObject{

    public var categoryID : String?
    public var children : [CreateEnquiryTypeModel] = []
    public var dataKey : String?
    public var dataName : String?
    public var ID : String?
    public var parentID : String?
    public var sn : Int?

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        categoryID = json["categoryId"].string
        children = [CreateEnquiryTypeModel]()
        let childrenArray = json["children"].arrayValue
        for childrenJson in childrenArray {
            let value = CreateEnquiryTypeModel(fromJson: childrenJson)
            children.append(value)
        }
        dataKey = json["dataKey"].string
        dataName = json["dataName"].string
        ID = json["id"].string
        parentID = json["parentId"].string
        sn = json["sn"].int
    }
}
