//
//  ErrorModel.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation

public enum ErrorModel: Error {    
    case noConnect
    case invalidParameter(String)
    case custom(String)
    case noAuth
    case isReplay
    case null
    
    public var localizedDescription: String {
        switch self {
        case .noConnect:
            return "您的网络出现问题啦，请检查网络！"
            
        case .noAuth:
            return "鉴权出错, 请重新登录APP"

        case .null:
            return "获取数据失败"
            
        case .custom(let description):
            return description
            
        case .invalidParameter(let parameter):
            return "参数"+parameter+"错误"
            
        case .isReplay:
            return "工单已处理，请勿重复提交"
        }
    }
}
