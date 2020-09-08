//
//  ChargeAssistantServices.swift
//  EServices
//
//  Created by pxy on 2020/2/13.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Alamofire

class ChargeAssistantServices: AlamofireManager {

    static let shared = ChargeAssistantServices(baseURL: EServicesConfig.FeeURL)

}
