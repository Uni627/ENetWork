//
//  UserDetailModel.swift
//  EServices
//
//  Created by pxy on 2019/11/5.
//

import Foundation
import SwiftyJSON

public class UserDetailModel: NSObject {

    public var id: String?
    public var projectName: String?            //项目名称
    public var devideName: String?             //分期名称
    public var jobs: [String]?                 //工作
    public var stars: Int?                     //评星 目前后台是写死的
    public var lists: [UserDetailModel] = []   //
    public var rank: Int?                      //等级 目前后台是写死的

    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }

        id = json["id"].string
        projectName = json["projectName"].string
        devideName = json["devideName"].string
        jobs = json["jobs"].arrayObject as? [String]
        stars = json["stars"].int
        rank = json["rank"].int
        lists = [UserDetailModel]()
        let listsArray = json["lists"].arrayValue
        for listsJson in listsArray {
            let value = UserDetailModel(fromJson: listsJson)
            lists.append(value)
        }

    }
}
