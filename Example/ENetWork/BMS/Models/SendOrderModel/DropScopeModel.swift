//
//  DropScopeModel.swift
//  EServices
//
//  Created by pxy on 2019/11/27.
//  Copyright © 2019 uni. All rights reserved.
//

import UIKit
import SwiftyJSON

public class DropScopeModel: NSObject {
    
    public var alias: String?
    public var checked: Int?
    public var children: [DropScopeModel]?
    public var createOrgID: String?
    public var enableMenu: Int?
    public var hasChildren: Bool?
    public var ID: String?
    public var isAllowTenant: Bool?
    public var isExtLink: Bool?
    public var isOpenWindow: Bool?
    public var isParent: Bool?
    public var load: String?
    public var menuIcon: String?
    public var menuType: Int?
    public var menuUrl: String?
    public var name: String?
    public var open: Bool?
    public var parentID: String?
    public var path: String?
    public var sn: String?
    public var sysMethods: [Any]?
    public var templateUrl: String?
    public var type: String?
    
    public override init() {
        super.init()
    }

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        children = [DropScopeModel]()
        let childrenArray = json["children"].arrayValue
        for childrenJson in childrenArray {
            let value = DropScopeModel(fromJson: childrenJson)
            children?.append(value)
        }
        alias = json["alias"].string
        checked = json["checked"].int
        createOrgID = json["createOrgId"].string
        enableMenu = json["enableMenu"].int
        hasChildren = json["hasChildren"].bool
        ID = json["id"].string
        isAllowTenant = json["isAllowTenant"].bool
        isExtLink = json["isExtLink"].bool
        isOpenWindow = json["isOpenWindow"].bool
        isParent = json["isParent"].bool
        load = json["load"].string
        menuIcon = json["menuIcon"].string
        menuType = json["menuType"].int
        menuUrl = json["menuUrl"].string
        name = json["name"].string
        open = json["open"].bool
        parentID = json["parentId"].string
        path = json["path"].string
        sn = json["sn"].string
        sysMethods = json["sysMethods"].array
        templateUrl = json["templateUrl"].string
        type = json["type"].string

    }
}
