//
//  UserServices.swift
//  EServices
//
//  Created by pxy on 2019/11/7.
//

import ENetWork

class UserService: AlamofireManager {
    static let shared = UserService(baseURL: EServicesConfig.userCenterURL)
}
