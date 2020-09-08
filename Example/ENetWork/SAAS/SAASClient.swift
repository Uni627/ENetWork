//
//  GatewayClient.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/25.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Alamofire
import EUtils

class SAASClient: AlamofireManager {
    static let shared = SAASClient(baseURL: EServicesConfig.SAASURL)
}
