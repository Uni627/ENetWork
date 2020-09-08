//
//  BMSServices.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//


import ENetWork

class BMSServices: AlamofireManager {
    
    static let shared = BMSServices(baseURL: EServicesConfig.BMSURL)
    
}
