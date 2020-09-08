//
//  PictureCountModel.swift
//  EServices
//
//  Created by orichy on 2020/8/11.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum PictureCountType: String {
    case checkRecordNew = "dianjian.pic.size"
    case unqualifiedNew = "bukegedan.pic.size"
    case unqualifiedFeedBack = "buhegedanfankui.pic.size"
    case unqualifiedConfirm = "buhegedanyanzheng.pic.size"
    case feedBackNew = "yijianfankui.pic.size"
    case patrolHandle = "xungeng.pic.size"
    case patrolInspect = "xunchagongdan.pic.size"
    case complaintNew = "kehutousu.pic.size"
    case repairNew = "kehubaoxiu.pic.size"
    case enquiryNew = "kehuwenxun.pic.size"
    case repairHandle = "kehubaoxiuchuli.pic.size"
    case distributeHandle = "paigongdan.pic.size"
    case planHandle = "jihuagongdan.pic.size"
    case delay = "yanqishenqing.pic.size"
    case close = "qiangzhibidan.pic.size"
}

public class PictureCountModel: NSObject {
    public var alias : PictureCountType?
    public var createOrgID : String?
    public var descriptionField : String?
    public var encrypt : Int?
    public var name : String?
    public var value : String?


    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        if let type = json["alias"].string {
            alias = PictureCountType.init(rawValue: type)
        }
        createOrgID = json["createOrgId"].string
        descriptionField = json["description"].string
        encrypt = json["encrypt"].int
        name = json["name"].string
        value = json["value"].string
    }
}
