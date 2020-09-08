//
//  PersonalServices.swift
//  EServices
//
//  Created by pxy on 2020/3/10.
//  Copyright © 2020 EinYun. All rights reserved.
//

import Alamofire

class PersonalServices: AlamofireManager {
    static let shared = BMSServices(baseURL: EServicesConfig.BMSURL)

}
