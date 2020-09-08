//
//  EServicesDefine.swift
//  EServices
//
//  Created by pxy on 2020/3/10.
//  Copyright © 2020 EinYun. All rights reserved.
//

import UIKit

//页码字典 有pageBean 字段
public func pageBeanParameter(_ page: PageBean) -> [String: Any] {
    let bean = ["pageSize": page.size, "page": page.page, "showTotal": page.showAll ? 1 : 0]
    return ["pageBean": bean]
}

//页码字典 没有pageBean 字段
public func pageParameter(_ page: PageBean, showBool: Bool = false) -> [String: Any] {
    let page = ["pageSize": page.size, "page": page.page, "showTotal": showBool ? (page.showAll ? true : false) : (page.showAll ? 1 : 0)] as [String: Any]
    return page
}

//通用传值字典
public func queryParameters(property: String, operation: String, value: String, relation: String) -> [String: Any] {
    let query = ["property": property,
                 "operation": operation,
                 "value": value,
                 "relation": relation]
    return query
}

public func urlToUTF8(urlStr: String) -> String {
    var charSet = CharacterSet.urlQueryAllowed
    charSet.insert(charactersIn: "#")//根据需求添加不需要转义的字符
    let encodingURL = urlStr.addingPercentEncoding(withAllowedCharacters: charSet) ?? ""
    return encodingURL
}

public func setDataSize(data: Data) -> Data {
    let length: CGFloat = CGFloat(data.count)
    if length > 70000 {
        let scale = length/70000.0
        let image = UIImage(data: data, scale: scale)
        if let da = image?.jpegData(compressionQuality: 0.1) {
            return da
        }
        return data
    }
    return data
}
