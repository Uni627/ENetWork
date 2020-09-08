//
//  ListContainer.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/12.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ListContainer: NSObject {
    
    public var page: Int?
    public var pageSize: Int?
    public var rows: [JSON] = []
    public var total: Int?

    public init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        page = json["page"].int
        pageSize = json["pageSize"].int
        rows = json["rows"].arrayValue
        total = json["total"].int
    }
}
