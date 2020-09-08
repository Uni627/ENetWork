//
//  MessageOrderModel.swift
//  EServices
//
//  Created by orichy on 2020/7/24.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public class MessageOrderModel: NSObject {
    
    public var orderID: String?
    public var canTurn = false
    public var showDetail = false
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        orderID = json["businessKey"].string
        canTurn = json["canTurn"].bool ?? false
        showDetail = json["showDetail"].bool ?? false
    }
}
