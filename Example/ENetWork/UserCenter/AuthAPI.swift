//
//  AuthAPI.swift
//  EServices
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

public class AuthAPI: EBaseAPI {
    public static let shared = AuthAPI()

    // MARK: - - 登录
    public func login(username: String, password: String, success:@escaping ((UserModel) -> Void), fail:@escaping (ErrorModel) -> Void) {

        AuthClient.shared.postRequest(with: "/uc/auth", needToken: false, parameters: ["username": username, "password": password], queue: DispatchQueue.global(), success: { (json) in
            if let user = UserModel(fromJson: json["data"]) {

                CurrentUser.savePassword = true
                CurrentUser.username = username.lowercased()
                CurrentUser.password = password
                CurrentUser.token = user.token
                CurrentUser.userID = user.id

                success(user)
            } else {
                fail(ErrorModel.custom("系统内部异常"))
            }
        }) { (error) in
            fail(error)
        }
    }

    // MARK: - - 退出登录
    public func logout(success:@escaping () -> Void, fail:@escaping (ErrorModel) -> Void) {
        CurrentUser.password = ""
        CurrentUser.token = ""
        CurrentUser.tenantID = nil
        success()
    }
}
