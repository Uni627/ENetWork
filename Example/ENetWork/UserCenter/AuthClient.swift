//
//  AuthClient.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Alamofire
import SwiftyJSON

public typealias successBlock = (JSON) -> Void
public typealias failBlock = (ErrorModel) -> Void
public typealias successImageBlock = (UIImage) -> Void

class AuthClient: AlamofireManager {
    static let shared = AuthClient(baseURL: EServicesConfig.userCenterURL)
}
