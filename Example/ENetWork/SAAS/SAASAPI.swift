//
//  SAASAPI.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/25.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import SwiftyJSON
import EUtils

public class SAASAPI: NSObject {
    public static let shared = SAASAPI()

    ///获取租户
    public func getTenantID(by tenant: String, success:@escaping ((String, String) -> Void), fail:@escaping (ErrorModel) -> Void) {
        SAASClient.shared.getRequest(with: "/datasource/api/saas/v1/tenant/getByCode/\(tenant)", needToken: false, success: { (json) in

            let response = SAASReponse(fromJson: json)
            if response.data == nil {
                fail(ErrorModel.custom(response.msg))
                return
            }
            let tenant = TenantModel(fromJson: json["data"])
            guard let tenantID = tenant.id else {
                fail(ErrorModel.custom("获取数据异常"))
                return
            }
            success(tenantID, tenant.logo ?? "")
        }) { (error) in
            fail(error)
        }
    }
}
